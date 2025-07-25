import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/utils/failure_converter.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/interact/vote_comment_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/interact/vote_post_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/usecase_params.dart';
import 'package:fitora_mobile_app/feature/post/presentation/forms/interact/interact_post_from_data.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'interact_event.dart';

part 'interact_state.dart';

// class InteractBloc extends Bloc<InteractEvent, InteractState> {
//   final VotePostUseCase _votePostUseCase;
//   final VoteCommentUseCase _voteCommentUseCase;
//
//   InteractBloc(
//     this._votePostUseCase,
//     this._voteCommentUseCase,
//   ) : super(InteractPostInitialState()) {
//     on<InteractPostEvent>(_interactPost);
//     on<InteractCommentEvent>(_interactComment);
//   }
//
//   Future _interactPost(InteractPostEvent event, Emitter emit) async {
//     emit(InteractPostLoadingState());
//
//     final result = await _votePostUseCase.call(VotePostParams(
//       userId: event.userId,
//       postId: event.postId,
//       voteType: event.voteType,
//     ));
//
//     result.fold(
//       (failure) => emit(InteractPostFailureState(mapFailureToMessage(failure))),
//       (success) => emit(InteractPostSuccessState()),
//     );
//   }
//
//   Future _interactComment(InteractCommentEvent event, Emitter emit) async {
//     emit(InteractCommentLoadingState());
//
//     final result = await _voteCommentUseCase.call(VoteCommentParams(
//       userId: event.userId,
//       commentId: event.commentId,
//       voteType: event.voteType,
//     ));
//
//     result.fold(
//           (failure) => emit(InteractCommentFailureState(mapFailureToMessage(failure))),
//           (success) => emit(InteractCommentSuccessState()),
//     );
//   }
// }

class InteractBloc extends Bloc<InteractEvent, InteractState> {
  final VotePostUseCase _votePostUseCase;

  InteractBloc({
    required VotePostUseCase votePostUseCase,
    required int initialVoteCount,
    required int? initialUserVoteType,
  })  : _votePostUseCase = votePostUseCase,
        super(InteractState.initial(initialVoteCount, initialUserVoteType)) {
    on<InteractPostEvent>(_onVote);
  }

  Future<void> _onVote(InteractPostEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));

    final updated = _calculateVoteChange(
      currentVoteCount: state.voteCount,
      currentVoteType: state.userVoteType,
      incomingVoteType: event.voteType,
    );

    final result = await _votePostUseCase.call(VotePostParams(
      userId: event.userId,
      postId: event.postId,
      voteType: event.voteType,
    ));

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: mapFailureToMessage(failure),
        ));
      },
      (_) {
        emit(state.copyWith(
          voteCount: updated.voteCount,
          userVoteType: updated.newVoteType,
          isLoading: false,
          errorMessage: null,
        ));
      },
    );
  }

  _VoteUpdateResult _calculateVoteChange({
    required int currentVoteCount,
    required int? currentVoteType,
    required int incomingVoteType,
  }) {
    int updatedCount = currentVoteCount;
    int? newVoteType = currentVoteType;

    if (incomingVoteType == 1) {
      // Upvote
      if (currentVoteType == 1) {
        updatedCount -= 1;
        newVoteType = null;
      } else {
        if (currentVoteType == 2) updatedCount += 2;
        if (currentVoteType == null) updatedCount += 1;
        newVoteType = 1;
      }
    } else if (incomingVoteType == 2) {
      // Downvote
      if (currentVoteType == 2) {
        updatedCount += 1;
        newVoteType = null;
      } else {
        if (currentVoteType == 1) updatedCount -= 2;
        if (currentVoteType == null) updatedCount -= 1;
        newVoteType = 2;
      }
    } else if (incomingVoteType == 3) {
      // Unvote
      if (currentVoteType == 1) updatedCount -= 1;
      if (currentVoteType == 2) updatedCount += 1;
      newVoteType = null;
    }

    return _VoteUpdateResult(updatedCount, newVoteType);
  }
}

class _VoteUpdateResult {
  final int voteCount;
  final int? newVoteType;

  _VoteUpdateResult(this.voteCount, this.newVoteType);
}
