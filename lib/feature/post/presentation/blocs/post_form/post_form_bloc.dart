import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/feature/post/presentation/forms/post/post_form_data.dart';
import 'package:fitora_mobile_app/feature/post/presentation/forms/post/post_form_input_data.dart';
import 'package:meta/meta.dart';

part 'post_form_event.dart';

part 'post_form_state.dart';

class PostFormBloc extends Bloc<PostFormEvent, PostFormState> {
  PostFormBloc() : super(const PostFormInitialState()) {
    on<PostLoadDataEvent>(_loadData);
    on<PostContentChangedEvent>(_contentChanged);
    on<PostMediaUrlChangedEvent>(_mediaUrlChanged);
    on<PostPrivacyChangedEvent>(_privacyChanged);
    on<PostGroupIdChangedEvent>(_groupIdChanged);
    on<PostCategoryIdChangedEvent>(_categoryIdChanged);
  }

  Future _loadData(PostLoadDataEvent event, Emitter emit) async {
    final updateData = PostFormInputData(
      inputContent: event.params.content,
      inputMediaUrl: event.params.mediaUrl,
      inputPrivacy: event.params.privacy,
      inputGroupId: event.params.groupId,
      inputCategoryId: event.params.categoryId,
      inputIsValid: inputValidator(event.params.content),
    );
    emit(PostFormDataState(updateData));
  }

  Future _contentChanged(PostContentChangedEvent event, Emitter emit) async {
    final updateData = PostFormInputData(
      inputContent: event.content,
      inputMediaUrl: state.data.mediaUrl,
      inputPrivacy: state.data.privacy,
      inputGroupId: state.data.groupId,
      inputCategoryId: state.data.categoryId,
      inputIsValid: inputValidator(event.content),
    );
    emit(PostFormDataState(updateData));
  }

  Future _mediaUrlChanged(PostMediaUrlChangedEvent event, Emitter emit) async {
    final updateData = PostFormInputData(
      inputContent: state.data.content,
      inputMediaUrl: event.mediaUrl,
      inputPrivacy: state.data.privacy,
      inputGroupId: state.data.groupId,
      inputCategoryId: state.data.categoryId,
      inputIsValid: inputValidator(state.data.content),
    );
    emit(PostFormDataState(updateData));
  }

  Future _privacyChanged(PostPrivacyChangedEvent event, Emitter emit) async {
    final updateData = PostFormInputData(
      inputContent: state.data.content,
      inputMediaUrl: state.data.mediaUrl,
      inputPrivacy: event.privacy,
      inputGroupId: state.data.groupId,
      inputCategoryId: state.data.categoryId,
      inputIsValid: inputValidator(state.data.content),
    );
    emit(PostFormDataState(updateData));
  }

  Future _groupIdChanged(PostGroupIdChangedEvent event, Emitter emit) async {
    final updateData = PostFormInputData(
      inputContent: state.data.content,
      inputMediaUrl: state.data.mediaUrl,
      inputPrivacy: state.data.privacy,
      inputGroupId: event.groupId,
      inputCategoryId: state.data.categoryId,
      inputIsValid: inputValidator(state.data.content),
    );
    emit(PostFormDataState(updateData));
  }

  Future _categoryIdChanged(PostCategoryIdChangedEvent event, Emitter emit) async {
    final updateData = PostFormInputData(
      inputContent: state.data.content,
      inputMediaUrl: state.data.mediaUrl,
      inputPrivacy: state.data.privacy,
      inputGroupId: state.data.groupId,
      inputCategoryId: event.categoryId,
      inputIsValid: inputValidator(state.data.content),
    );
    emit(PostFormDataState(updateData));
  }

  bool inputValidator(String content) {
    if (content.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE PostFormBloc =====");
    return super.close();
  }
}
