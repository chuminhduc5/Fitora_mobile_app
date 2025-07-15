part of 'upload_file_bloc.dart';

@immutable
abstract class UploadFileState extends Equatable {
  const UploadFileState();

  @override
  List<Object?> get props => [];
}

class UploadImageFilePickedState extends UploadFileState {
  final File file;
  final ImageType type;

  const UploadImageFilePickedState({required this.file, required this.type});

  @override
  List<Object?> get props => [file, type];
}

class UploadFileInitialState extends UploadFileState {}

class UploadImageFileLoadingState extends UploadFileState {
  final ImageType type;

  const UploadImageFileLoadingState(this.type);

  @override
  List<Object?> get props => [type];
}

class UploadImageFileSuccessState extends UploadFileState {
  final UploadFileEntity imageUrl;
  final ImageType type;

  const UploadImageFileSuccessState({
    required this.imageUrl,
    required this.type,
  });

  @override
  List<Object?> get props => [imageUrl, type];
}

class UploadImageFileFailureState extends UploadFileState {
  final String message;
  final ImageType type;

  const UploadImageFileFailureState({
    required this.type,
    required this.message,
  });

  @override
  List<Object?> get props => [message, type];
}
