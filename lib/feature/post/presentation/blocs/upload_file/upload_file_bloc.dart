import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/utils/failure_converter.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/upload_file_entity.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/posts/upload_file_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/usecase_params.dart';
import 'package:meta/meta.dart';

part 'upload_file_event.dart';

part 'upload_file_state.dart';

class UploadFileBloc extends Bloc<UploadFileEvent, UploadFileState> {
  final UploadFileUseCase _uploadFileUseCase;

  UploadFileBloc(this._uploadFileUseCase) : super(UploadFileInitialState()) {
    on<UploadImageFileEvent>(_uploadImageFile);
  }

  Future _uploadImageFile(UploadImageFileEvent event, Emitter emit) async {
    emit(UploadImageFileLoadingState());

    //final result = await _uploadFileUseCase.call(UploadFileParams(url: event.url));
    final result = await _uploadFileUseCase.call(event.url);

    result.fold(
      (failure) => emit(UploadImageFileFailureState(mapFailureToMessage(failure))),
      (success) => emit(UploadImageFileSuccessState(imageUrl: success)),
    );
  }
}
