import 'package:fitora_mobile_app/common/dialog/app_display_message.dart';
import 'package:fitora_mobile_app/common/dialog/app_error_widget.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/common/widgets/avatar/app_avatar_widget.dart';
import 'package:fitora_mobile_app/common/widgets/textfield/app_text_field_widget.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/post_entity.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/comment/comment_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/comment_form/comment_form_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/forms/comment/comment_form_data.dart';
import 'package:fitora_mobile_app/feature/post/presentation/forms/comment/create_comment_form_data.dart';
import 'package:fitora_mobile_app/feature/post/presentation/widgets/comment/comment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentScreen extends StatefulWidget {
  final PostEntity post;

  const CommentScreen({super.key, required this.post});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Tự động focus khi widget được mount
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _createComment(BuildContext context) async {
    primaryFocus?.unfocus();
    final formState = context.read<CommentFormBloc>().state;
    final formData = formState.data;
    logg.i("PostId: ${widget.post.id}");
    logg.i("ParentCommentId: ${formState.data.parentCommentId}");
    logg.i("Content: ${_controller.text}");
    logg.i("MediaUrl: ");
    context.read<CommentBloc>().add(
          CreateCommentEvent(
            params: CreateCommentFormData(
              postId: widget.post.id,
              parentCommentId: formData.parentCommentId,
              content: _controller.text,
              mediaUrl: "",
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<CommentFormBloc>()),
        BlocProvider(
          create: (_) => getIt<CommentBloc>()
            ..add(
              FetchCommentEvent(postId: widget.post.id),
            ),
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<CommentBloc, CommentState>(
                  builder: (context, state) {
                    if (state is FetchCommentLoadingState) {
                      return const AppLoadingWidget();
                    } else if (state is FetchCommentFailureState) {
                      return AppErrorWidget(state.message);
                    } else if (state is FetchCommentSuccessState) {
                      final comments = state.data;
                      return CustomScrollView(
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final comment = comments[index];
                                return CommentWidget(comment: comment);
                              },
                              childCount: comments.length,
                            ),
                          ),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
              // Nếu bàn phím mở, thanh TextField sẽ luôn nằm trên bàn phím
              if (isKeyboardOpen) ...[
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Row(
                    children: [
                      //AppAvatarWidget(imagePath: imagePath, size: size)
                      //const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          focusNode: _focusNode,
                          decoration: InputDecoration(
                            hintText: "Viết bình luận...",
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          textInputAction: TextInputAction.send,
                          onSubmitted: (text) {
                            // Xử lý gửi comment
                            print('Gửi bình luận: $text');
                            _controller.clear();
                          },
                        ),
                      ),
                      const SizedBox(width: 6),
                      BlocConsumer<CommentBloc, CommentState>(
                        listener: (context, state) {
                          if (state is CreateCommentFailureState) {
                            AppDisplayMessage.error(context, state.message);
                          } else if (state is CreateCommentSuccessState) {
                            logg.i("Bình luận đã được gửi: ${_controller.text}");
                            _controller.clear();
                          }
                        },
                        builder: (context, state) {
                          if (state is CreateCommentLoadingState) {
                            const AppLoadingWidget();
                          }
                          return IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {
                              _createComment(context);
                              print('Gửi bình luận: ${_controller.text}');
                              _controller.clear();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ]
              // Nếu bàn phím đóng, thanh TextField sẽ nằm ở dưới cùng của màn hình
              else ...[
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Row(
                    children: [
                      //AppAvatarWidget(imagePath: imagePath, size: size)
                      //const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          focusNode: _focusNode,
                          decoration: InputDecoration(
                            hintText: "Viết bình luận...",
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          textInputAction: TextInputAction.send,
                          onSubmitted: (text) {
                            // Xử lý gửi comment
                            print('Gửi bình luận: $text');
                            _controller.clear();
                          },
                        ),
                      ),
                      const SizedBox(width: 6),
                      BlocConsumer<CommentBloc, CommentState>(
                        listener: (context, state) {
                          if (state is CreateCommentFailureState) {
                            AppDisplayMessage.error(context, state.message);
                          } else if (state is CreateCommentSuccessState) {
                            logg.i("Bình luận đã được gửi: ${_controller.text}");
                            _controller.clear();
                          }
                        },
                        builder: (context, state) {
                          if (state is CreateCommentLoadingState) {
                            const AppLoadingWidget();
                          }
                          return IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {
                              _createComment(context);
                              print('Gửi bình luận: ${_controller.text}');
                              _controller.clear();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
