import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'upload_file_state.dart';

class UploadFileCubit extends Cubit<UploadFileState> {
  UploadFileCubit() : super(UploadFileInitial());
}
