import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/utils/failure_converter.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/interact/vote_post_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/usecase_params.dart';
import 'package:fitora_mobile_app/feature/post/presentation/forms/interact/interact_post_from_data.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'interact_event.dart';

part 'interact_state.dart';

class InteractBloc extends Bloc<InteractEvent, InteractState> {
  final VotePostUseCase _votePostUseCase;

  InteractBloc(this._votePostUseCase) : super(InteractPostInitialState()) {
    on<InteractPostEvent>(_interact);
  }

  Future _interact(InteractPostEvent event, Emitter emit) async {
    emit(InteractPostLoadingState());

    final result = await _votePostUseCase.call(VotePostParams(
      userId: event.userId,
      postId: event.postId,
      voteType: event.voteType,
    ));

    result.fold(
      (failure) => emit(InteractPostFailureState(mapFailureToMessage(failure))),
      (success) => emit(InteractPostSuccessState()),
    );
  }
}


// class InteractBloc extends Bloc<InteractEvent, InteractState> {
//   final VotePostUseCase _votePostUseCase;
//
//   InteractBloc({
//     required VotePostUseCase votePostUseCase,
//     required int initialVoteCount,
//     required int? initialUserVoteType,
//   })  : _votePostUseCase = votePostUseCase,
//         super(InteractState.initial(initialVoteCount, initialUserVoteType)) {
//     on<InteractPostEvent>(_onVote);
//   }
//
//   Future<void> _onVote(InteractPostEvent event, Emitter<InteractState> emit) async {
//     int newVoteCount = state.voteCount;
//     int? newVoteType = state.userVoteType;
//
//     // Tính toán thay đổi vote
//     if (event.voteType == 1) {
//       if (newVoteType == 1) {
//         newVoteType = null;
//         newVoteCount -= 1;
//       } else {
//         if (newVoteType == 2) newVoteCount += 2;
//         if (newVoteType == null) newVoteCount += 1;
//         newVoteType = 1;
//       }
//     } else if (event.voteType == 2) {
//       if (newVoteType == 2) {
//         newVoteType = null;
//         newVoteCount += 1;
//       } else {
//         if (newVoteType == 1) newVoteCount -= 2;
//         if (newVoteType == null) newVoteCount -= 1;
//         newVoteType = 2;
//       }
//     } else if (event.voteType == 3) {
//       // unvote
//       if (newVoteType == 1) newVoteCount -= 1;
//       if (newVoteType == 2) newVoteCount += 1;
//       newVoteType = null;
//     }
//
//     // Gửi loading nếu muốn
//     emit(state.copyWith(isLoading: true));
//
//     final result = await _votePostUseCase.call(VotePostParams(
//       userId: event.userId,
//       postId: event.postId,
//       voteType: event.voteType,
//     ));
//
//     result.fold(
//           (failure) {
//         emit(state.copyWith(
//           isLoading: false,
//           errorMessage: mapFailureToMessage(failure),
//         ));
//       },
//           (_) {
//         emit(state.copyWith(
//           voteCount: newVoteCount,
//           userVoteType: newVoteType,
//           upVoteColor: newVoteType == 1 ? AppColors.bgPink : Colors.black,
//           downVoteColor: newVoteType == 2 ? AppColors.bgPink : Colors.black,
//           isLoading: false,
//           errorMessage: null,
//         ));
//       },
//     );
//   }
// }


// class InteractBloc extends Bloc<InteractEvent, InteractState> {
//   final VotePostUseCase _votePostUseCase;
//
//   InteractBloc({
//     required VotePostUseCase votePostUseCase,
//     required int initialVoteCount,
//     required int? initialUserVoteType,
//   })  : _votePostUseCase = votePostUseCase,
//         super(InteractState.initial(initialVoteCount, initialUserVoteType)) {
//     on<InteractPostEvent>(_onVote);
//   }
//
//   Future<void> _onVote(InteractPostEvent event, Emitter<InteractState> emit) async {
//     emit(state.copyWith(isLoading: true));
//
//     final updated = _calculateVoteChange(
//       currentVoteCount: state.voteCount,
//       currentVoteType: state.userVoteType,
//       incomingVoteType: event.voteType,
//     );
//
//     final result = await _votePostUseCase.call(VotePostParams(
//       userId: event.userId,
//       postId: event.postId,
//       voteType: event.voteType,
//     ));
//
//     result.fold(
//           (failure) {
//         emit(state.copyWith(
//           isLoading: false,
//           errorMessage: mapFailureToMessage(failure),
//         ));
//       },
//           (_) {
//         emit(state.copyWith(
//           voteCount: updated.voteCount,
//           userVoteType: updated.newVoteType,
//           isLoading: false,
//           errorMessage: null,
//         ));
//       },
//     );
//   }
//
//   _VoteUpdateResult _calculateVoteChange({
//     required int currentVoteCount,
//     required int? currentVoteType,
//     required int incomingVoteType,
//   }) {
//     int updatedCount = currentVoteCount;
//     int? newVoteType = currentVoteType;
//
//     if (incomingVoteType == 1) {
//       // Upvote
//       if (currentVoteType == 1) {
//         updatedCount -= 1;
//         newVoteType = null;
//       } else {
//         if (currentVoteType == 2) updatedCount += 2;
//         if (currentVoteType == null) updatedCount += 1;
//         newVoteType = 1;
//       }
//     } else if (incomingVoteType == 2) {
//       // Downvote
//       if (currentVoteType == 2) {
//         updatedCount += 1;
//         newVoteType = null;
//       } else {
//         if (currentVoteType == 1) updatedCount -= 2;
//         if (currentVoteType == null) updatedCount -= 1;
//         newVoteType = 2;
//       }
//     } else if (incomingVoteType == 3) {
//       // Unvote
//       if (currentVoteType == 1) updatedCount -= 1;
//       if (currentVoteType == 2) updatedCount += 1;
//       newVoteType = null;
//     }
//
//     return _VoteUpdateResult(updatedCount, newVoteType);
//   }
// }
//
// class _VoteUpdateResult {
//   final int voteCount;
//   final int? newVoteType;
//
//   _VoteUpdateResult(this.voteCount, this.newVoteType);
// }