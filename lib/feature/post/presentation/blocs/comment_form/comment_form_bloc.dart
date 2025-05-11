import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/feature/post/presentation/forms/comment/comment_form_data.dart';
import 'package:fitora_mobile_app/feature/post/presentation/forms/comment/comment_form_input_data.dart';
import 'package:meta/meta.dart';

part 'comment_form_event.dart';

part 'comment_form_state.dart';

class CommentFormBloc extends Bloc<CommentFormEvent, CommentFormState> {
  CommentFormBloc() : super(const CommentFormInitialState()) {
    on<CommentLoadDataEvent>(_loadData);
    on<CommentContentChangedEvent>(_contentChanged);
    on<CommentMediaUrlChangedEvent>(_mediaUrlChanged);
  }

  Future _loadData(CommentLoadDataEvent event, Emitter emit) async {
    final updateData = CommentFormInputData(
      inputPostId: state.data.postId,
      inputParentCommentId: state.data.parentCommentId,
      inputContent: state.data.content,
      inputMediaUrl: state.data.mediaUrl,
    );
    emit(CommentFormDataState(updateData));
  }

  Future _contentChanged(CommentContentChangedEvent event, Emitter emit) async {
    final updateData = CommentFormInputData(
      inputPostId: state.data.postId,
      inputParentCommentId: state.data.parentCommentId,
      inputContent: event.content,
      inputMediaUrl: state.data.mediaUrl,
    );
    emit(CommentFormDataState(updateData));
  }

  Future _mediaUrlChanged(CommentMediaUrlChangedEvent event, Emitter emit) async {
    final updateData = CommentFormInputData(
      inputPostId: state.data.postId,
      inputParentCommentId: state.data.parentCommentId,
      inputContent: state.data.content,
      inputMediaUrl: event.mediaUrl,
    );
    emit(CommentFormDataState(updateData));
  }
}
