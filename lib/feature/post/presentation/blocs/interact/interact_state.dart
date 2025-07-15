part of 'interact_bloc.dart';

@immutable
class InteractState extends Equatable {
  final int voteCount;
  final int? userVoteType;
  final bool isLoading;
  final String? errorMessage;

  const InteractState({
    required this.voteCount,
    required this.userVoteType,
    this.isLoading = false,
    this.errorMessage,
  });

  factory InteractState.initial(int voteCount, int? userVoteType) {
    return InteractState(
      voteCount: voteCount,
      userVoteType: userVoteType,
    );
  }

  InteractState copyWith({
    int? voteCount,
    int? userVoteType,
    bool? isLoading,
    String? errorMessage,
  }) {
    return InteractState(
      voteCount: voteCount ?? this.voteCount,
      userVoteType: userVoteType ?? this.userVoteType,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  Color get upVoteColor => userVoteType == 1 ? AppColors.bgPink : Colors.black;
  Color get downVoteColor => userVoteType == 2 ? AppColors.bgPink : Colors.black;

  @override
  List<Object?> get props => [
    voteCount,
    userVoteType,
    isLoading,
    errorMessage,
  ];
}
