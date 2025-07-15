part of 'upload_file_bloc.dart';

@immutable
abstract class UploadFileEvent extends Equatable{
  const UploadFileEvent();

  @override
  List<Object?> get props => [];
}

class UploadImageFileEvent extends UploadFileEvent {
  final File file;
  final ImageType type;

  const UploadImageFileEvent({required this.file, required this.type});

  @override
  List<Object?> get props => [file, type];
}
