part of 'upload_file_bloc.dart';

@immutable
abstract class UploadFileEvent extends Equatable{
  const UploadFileEvent();

  @override
  List<Object?> get props => [];
}

class UploadImageFileEvent extends UploadFileEvent {
  final File url;
  final ImageType type;

  const UploadImageFileEvent({required this.url, required this.type});

  @override
  List<Object?> get props => [url];
}
