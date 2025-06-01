part of 'upload_file_bloc.dart';

@immutable
abstract class UploadFileEvent extends Equatable{
  const UploadFileEvent();

  @override
  List<Object?> get props => [];
}

class UploadImageFileEvent extends UploadFileEvent {
  final File url;

  const UploadImageFileEvent(this.url);

  @override
  List<Object?> get props => [url];
}
