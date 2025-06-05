part of 'interact_bloc.dart';

@immutable
abstract class InteractState extends Equatable {
  const InteractState();

  @override
  List<Object?> get props => [];
}

class InteractPostInitialState extends InteractState {}

class InteractPostLoadingState extends InteractState {}

class InteractPostSuccessState extends InteractState {}

class InteractPostFailureState extends InteractState {
  final String message;

  const InteractPostFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

// class InteractState extends Equatable {
//   final int voteCount;
//   final int? userVoteType;
//   final Color upVoteColor;
//   final Color downVoteColor;
//   final bool isLoading;
//   final String? errorMessage;
//
//   const InteractState({
//     required this.voteCount,
//     required this.userVoteType,
//     required this.upVoteColor,
//     required this.downVoteColor,
//     this.isLoading = false,
//     this.errorMessage,
//   });
//
//   factory InteractState.initial(int voteCount, int? userVoteType) {
//     return InteractState(
//       voteCount: voteCount,
//       userVoteType: userVoteType,
//       upVoteColor: userVoteType == 1 ? AppColors.bgPink : Colors.black,
//       downVoteColor: userVoteType == 2 ? AppColors.bgPink : Colors.black,
//     );
//   }
//
//   InteractState copyWith({
//     int? voteCount,
//     int? userVoteType,
//     Color? upVoteColor,
//     Color? downVoteColor,
//     bool? isLoading,
//     String? errorMessage,
//   }) {
//     return InteractState(
//       voteCount: voteCount ?? this.voteCount,
//       userVoteType: userVoteType ?? this.userVoteType,
//       upVoteColor: upVoteColor ?? this.upVoteColor,
//       downVoteColor: downVoteColor ?? this.downVoteColor,
//       isLoading: isLoading ?? this.isLoading,
//       errorMessage: errorMessage,
//     );
//   }
//
//   @override
//   List<Object?> get props => [
//         voteCount,
//         userVoteType,
//         upVoteColor,
//         downVoteColor,
//         isLoading,
//         errorMessage,
//       ];
// }

// class InteractState extends Equatable {
//   final int voteCount;
//   final int? userVoteType;
//   final bool isLoading;
//   final String? errorMessage;
//
//   const InteractState({
//     required this.voteCount,
//     required this.userVoteType,
//     this.isLoading = false,
//     this.errorMessage,
//   });
//
//   factory InteractState.initial(int voteCount, int? userVoteType) {
//     return InteractState(
//       voteCount: voteCount,
//       userVoteType: userVoteType,
//     );
//   }
//
//   InteractState copyWith({
//     int? voteCount,
//     int? userVoteType,
//     bool? isLoading,
//     String? errorMessage,
//   }) {
//     return InteractState(
//       voteCount: voteCount ?? this.voteCount,
//       userVoteType: userVoteType ?? this.userVoteType,
//       isLoading: isLoading ?? this.isLoading,
//       errorMessage: errorMessage,
//     );
//   }
//
//   Color get upVoteColor => userVoteType == 1 ? AppColors.bgPink : Colors.black;
//   Color get downVoteColor => userVoteType == 2 ? AppColors.bgPink : Colors.black;
//
//   @override
//   List<Object?> get props => [
//     voteCount,
//     userVoteType,
//     isLoading,
//     errorMessage,
//   ];
// }
