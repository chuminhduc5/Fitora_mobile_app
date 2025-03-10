import 'package:equatable/equatable.dart';

class UploadFileEntity extends Equatable {
  final String url;

  const UploadFileEntity({required this.url});

  @override
  List<Object?> get props => [url];
}