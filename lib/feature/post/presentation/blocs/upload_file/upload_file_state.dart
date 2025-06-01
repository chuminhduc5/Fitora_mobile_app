part of 'upload_file_bloc.dart';

@immutable
abstract class UploadFileState extends Equatable {
  const UploadFileState();

  @override
  List<Object?> get props => [];
}

class UploadFileInitialState extends UploadFileState {}

class UploadImageFileLoadingState extends UploadFileState {}

class UploadImageFileSuccessState extends UploadFileState {
  final UploadFileEntity imageUrl;
  const UploadImageFileSuccessState({required this.imageUrl});

  @override
  List<Object?> get props => [imageUrl];
}

class UploadImageFileFailureState extends UploadFileState {
  final String message;

  const UploadImageFileFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
