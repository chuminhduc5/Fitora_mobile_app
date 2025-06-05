import 'package:fitora_mobile_app/common/dialog/app_display_message.dart';
import 'package:fitora_mobile_app/common/dialog/app_error_widget.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/common/widgets/button/app_button_widget.dart';
import 'package:fitora_mobile_app/core/cache/hive_local_storage.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/helper/mapper/user/user_profile_mapper.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/post_entity.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/comment/comment_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/comment_form/comment_form_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/forms/comment/create_comment_form_data.dart';
import 'package:fitora_mobile_app/feature/post/presentation/widgets/comment/comment_widget.dart';
import 'package:fitora_mobile_app/feature/post/presentation/widgets/comment/text_field_comment_widget.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/user_profile_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentScreen extends StatefulWidget {
  final PostEntity post;

  const CommentScreen({super.key, required this.post});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentFocusNode = FocusNode();
  UserProfileEntity? userInfo;
  final _hiveLocalStorage = HiveLocalStorage();
  String? parentCommentId;

  late CommentBloc _commentBloc;
  late CommentBloc _repliesCommentBloc;

  @override
  void initState() {
    super.initState();
    _loadUser();
    // Tự động focus khi widget được mount
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_commentFocusNode);
    });
    _commentBloc = getIt<CommentBloc>()
      ..add(FetchCommentEvent(postId: widget.post.id));
    //_repliesCommentBloc = getIt<CommentBloc>()..add(FetchRepliesCommentEvent(parentCommentId: parentCommentId))
  }

  void _loadUser() async {
    final userModel =
        await _hiveLocalStorage.load(key: "user", boxName: "cache");
    if (userModel != null) {
      logg.i("Người dùng đã lưu: $userModel");
      final userEntity = UserProfileMapper.toEntity(userModel);
      setState(() {
        userInfo = userEntity;
      });
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocusNode.dispose();
    super.dispose();
  }

  void _createComment(BuildContext context) async {
    primaryFocus?.unfocus();
    final formState = context.read<CommentFormBloc>().state;
    final formData = formState.data;
    logg.i("PostId: ${widget.post.id}");
    logg.i("ParentCommentId: ${formState.data.parentCommentId}");
    logg.i("Content: ${_commentController.text}");
    logg.i("MediaUrl: ");
    context.read<CommentBloc>().add(
          CreateCommentEvent(
            params: CreateCommentFormData(
              postId: widget.post.id,
              parentCommentId: null,
              content: _commentController.text,
              mediaUrl: "",
            ),
          ),
        );
  }

  void _createRepliesComment(BuildContext context) async {
    primaryFocus?.unfocus();
    final formState = context.read<CommentFormBloc>().state;
    logg.i("PostId: ${widget.post.id}");
    logg.i("ParentCommentId: $parentCommentId");
    logg.i("Content: ${_commentController.text}");
    logg.i("MediaUrl: ");
    context.read<CommentBloc>().add(
          CreateRepliesCommentEvent(
            params: CreateCommentFormData(
              postId: widget.post.id,
              parentCommentId: parentCommentId,
              content: _commentController.text,
              mediaUrl: "",
            ),
          ),
        );
  }

  void _focusCommentInput() {
    FocusScope.of(context).requestFocus(_commentFocusNode);
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<CommentFormBloc>()),
        // BlocProvider(create: (_) => _commentBloc),
        BlocProvider.value(value: _commentBloc),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: AppColors.bgWhite,
          title: const Text(
            "Bình luận",
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: RefreshIndicator(
          color: AppColors.bgPink,
          backgroundColor: AppColors.bgWhite,
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            context.read<CommentBloc>().add(
                  FetchCommentEvent(postId: widget.post.id),
                );
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<CommentBloc, CommentState>(
                    builder: (context, state) {
                      final bloc = context.read<CommentBloc>();

                      if (userInfo == null) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is FetchCommentLoadingState) {
                        return const AppLoadingWidget();
                      }

                      if (state is FetchCommentFailureState) {
                        return AppErrorWidget(state.message);
                      }

                      final comments = bloc.comments;
                      //logger.e("Comment update: ${comments.length}");
                      final repliesComment = bloc.repliesMap;
                      logger.e("RepliesComment update: ${repliesComment.length}");

                      return CustomScrollView(
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final comment = comments[index];
                                final replies =
                                    repliesComment[comment.id] ?? [];
                                return CommentWidget(
                                  postId: widget.post.id,
                                  comment: comment,
                                  callback: _focusCommentInput,
                                  userInfo: userInfo!,
                                  onPressed: (value) {
                                    setState(() {
                                      parentCommentId = value;
                                      logger.i("Comment Id: $parentCommentId");
                                    });
                                  },
                                );
                              },
                              childCount: comments.length,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                // Nếu bàn phím mở, thanh TextField sẽ luôn nằm trên bàn phím
                if (isKeyboardOpen) ...[
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFieldCommentWidget(
                            controller: _commentController,
                            focusNode: _commentFocusNode,
                          ),
                        ),
                        const SizedBox(width: 6),
                        BlocConsumer<CommentBloc, CommentState>(
                          listener: (context, state) {
                            if (state is CreateCommentFailureState || state is CreateRepliesCommentFailureState) {
                              AppDisplayMessage.error(context, "Tạo comment không thành công!");
                            } else if (state is CreateCommentSuccessState || state is CreateRepliesCommentSuccessState) {
                              logg.i(
                                  "Bình luận đã được gửi: ${_commentController.text}");
                              _commentController.clear();
                            }
                          },
                          builder: (context, state) {
                            if (state is CreateCommentLoadingState) {
                              const AppLoadingWidget();
                            }
                            return IconButton(
                              icon: const Icon(Icons.send),
                              onPressed: () {
                                if (parentCommentId != null) {
                                  logger.i("Tạo Replies Comment");
                                  _createRepliesComment(context);
                                } else {
                                  logger.i("Tạo Comment");
                                  _createComment(context);
                                }
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
                          child: TextFieldCommentWidget(
                            controller: _commentController,
                            focusNode: _commentFocusNode,
                          ),
                        ),
                        const SizedBox(width: 6),
                        BlocConsumer<CommentBloc, CommentState>(
                          listener: (context, state) {
                            if (state is CreateCommentFailureState || state is CreateRepliesCommentFailureState) {
                              AppDisplayMessage.error(context, "Tạo comment không thành công!");
                            } else if (state is CreateCommentSuccessState) {
                              logg.i(
                                  "Bình luận đã được gửi: ${_commentController.text}");
                              _commentController.clear();
                            }
                          },
                          builder: (context, state) {
                            if (state is CreateCommentLoadingState) {
                              const AppLoadingWidget();
                            }
                            return IconButton(
                              icon: const Icon(Icons.send),
                              onPressed: () {
                                if (parentCommentId != null) {
                                  logger.i("Tạo Replies Comment");
                                  _createRepliesComment(context);
                                } else {
                                  logger.i("Tạo Comment");
                                  _createComment(context);
                                }
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
      ),
    );
  }
}
