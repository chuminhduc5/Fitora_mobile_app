import 'dart:io';

import 'package:fitora_mobile_app/common/dialog/app_display_message.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/common/widgets/avatar/app_avatar_widget.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/enums/file/image_type.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/post_entity.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/newsfeed/newsfeed_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/post/post_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/post_form/post_form_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/upload_file/upload_file_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/forms/post/post_form_data.dart';
import 'package:fitora_mobile_app/feature/post/presentation/widgets/post/category_dropdown_widget.dart';
import 'package:fitora_mobile_app/feature/post/presentation/widgets/post/post_text_field_widget.dart';
import 'package:fitora_mobile_app/feature/post/presentation/widgets/post/privacy_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class UpdatePostScreen extends StatefulWidget {
  final PostEntity post;

  const UpdatePostScreen({super.key, required this.post});

  @override
  State<UpdatePostScreen> createState() => _UpdatePostScreenState();
}

class _UpdatePostScreenState extends State<UpdatePostScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  late UploadFileBloc _uploadFileBloc;

  List<Map<String, dynamic>> categories = [
    {"id": "", "name": "Chủ đề"},
    {"id": "08dd78b5-1e98-48bf-8765-9e922cf5713a", "name": "AI"},
    {"id": "08dd78b6-8f14-48c4-8e04-2e24d010b58b", "name": "Web"},
    {"id": "08dd7d39-8397-4b70-8e57-332e0f30c3e9", "name": "Mobile"},
    {"id": "08dd7d3c-ddba-4fb1-8bf8-cbb45a87642d", "name": "BlockChain"},
  ];

  String selectedCategoryId = "";

  String selectedPrivacyId = "1";
  final List<Map<String, dynamic>> privacy = [
    {"id": "1", "privacy": "Công khai", "icon": Icons.public},
    {"id": "2", "privacy": "Bạn bè", "icon": Icons.people},
    {"id": "3", "privacy": "Chỉ mình tôi", "icon": Icons.lock},
    {"id": "4", "privacy": "Nhóm", "icon": Icons.groups},
  ];

  @override
  void initState() {
    super.initState();
    _uploadFileBloc = getIt<UploadFileBloc>();
    context.read<PostFormBloc>().add(
          PostLoadDataEvent(
            params: PostFormData(
              content: widget.post.content,
              mediaUrl: widget.post.mediaUrl,
              privacy: widget.post.privacy,
              isValid: true,
            ),
          ),
        );
  }

  @override
  void dispose() {
    _uploadFileBloc.close();
    super.dispose();
  }

  Future<void> _uploadImageFile() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      _uploadFileBloc
          .add(UploadImageFileEvent(file: file, type: ImageType.Image));
      logg.i("File Image Url: ${File(pickedFile.path)}");
      logg.i("Image Url: ${pickedFile.path}");
      logg.i("Url: $_image");
    }
  }

  void _update(BuildContext context) async {
    primaryFocus?.unfocus();
    final postForm = context.read<PostFormBloc>().state;
    logg.i("Content: ${postForm.data.content}");
    logg.i("MediaUrl: ${postForm.data.mediaUrl}");
    logg.i("Privacy: ${postForm.data.privacy}");
    // context.read<PostBloc>().add(
    //       UpdatePostEvent(
    //         id: widget.post.id,
    //         params: UpdatePostFormData(
    //           content: postForm.data.content,
    //           mediaUrl: postForm.data.mediaUrl,
    //           privacy: postForm.data.privacy,
    //           isApproved: true,
    //         ),
    //       ),
    //     );
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    final postBloc = context.read<PostFormBloc>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<PostFormBloc>(),
        ),
        BlocProvider(
          create: (context) => _uploadFileBloc,
        ),
      ],
      child: BlocConsumer<PostBloc, PostState>(
        listener: (_, state) {
          if (state is CreatePostFailureState) {
            AppDisplayMessage.error(context, state.message);
          } else if (state is CreatePostSuccessState) {
            context.pop(true);
            context.read<NewsfeedBloc>().add(FetchNewsfeedEvent());
            AppDisplayMessage.success(context, "Đăng bài thành công");
          }
        },
        builder: (context, state) {
          if (state is CreatePostLoadingState) {
            context.goNamed(AppRoute.appView.name);
          }
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: AppColors.bgWhite,
              title: const Text(
                "Chỉnh sửa",
                style: TextStyle(fontSize: 20),
              ),
              actions: <Widget>[
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.disabled)) {
                          return Colors.grey; // Màu khi disable
                        }
                        return AppColors.bgPink; // Màu khi enable
                      },
                    ),
                  ),
                  // onPressed: context.watch<PostFormBloc>().state.data.isValid
                  //     ? () => _createPost(context)
                  //     : null,
                  onPressed: () => _update(context),
                  child: const Text(
                    'CẬP NHẬT',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
            backgroundColor: AppColors.bgWhite,
            body: BlocBuilder<PostFormBloc, PostFormState>(
              builder: (context, state) {
                final data = state.data;
                return SingleChildScrollView(
                  child: SizedBox(
                    child: Column(
                      children: [
                        ListTile(
                          leading: AppAvatarWidget(
                            imagePath: widget.post.user.profilePictureUrl,
                            size: 50,
                          ),
                          title: const Text(
                            'Minh Đức',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Row(
                            children: [
                              SizedBox(
                                width: 130,
                                child: PrivacyDropdownWidget(
                                  selectedPrivacyId: selectedPrivacyId,
                                  privacy: privacy,
                                  onChanged: (String? id) {
                                    setState(() {
                                      selectedPrivacyId = id ?? "";
                                    });
                                    postBloc.add(PostPrivacyChangedEvent(
                                        int.parse(selectedPrivacyId)));
                                  },
                                ),
                              ),
                              const SizedBox(width: 5),
                              SizedBox(
                                width: 120,
                                child: CategoryDropdownWidget(
                                  selectedCategoryId: selectedCategoryId,
                                  categories: categories,
                                  onChanged: (String? id) {
                                    setState(() {
                                      selectedCategoryId = id ?? "";
                                    });
                                    postBloc.add(PostCategoryIdChangedEvent(
                                        selectedCategoryId));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        PostTextFieldWidget<PostFormBloc>(
                          initialValue: widget.post.content,
                          onChanged: (val) {
                            postBloc.add(PostContentChangedEvent(val));
                          },
                        ),
                        BlocConsumer<UploadFileBloc, UploadFileState>(
                          listener: (_, state) {
                            if (state is UploadImageFileFailureState) {
                              AppDisplayMessage.error(context, state.message);
                            }
                          },
                          builder: (context, state) {
                            logg.i("Current upload file state: $state");
                            if (state is UploadImageFileLoadingState) {
                              return const AppLoadingWidget();
                            } else if (state is UploadImageFileSuccessState) {
                              final imageUrl = state.imageUrl;
                              logg.i("Image Url File: $imageUrl");
                              return Image.network(
                                imageUrl.url,
                                width: double.infinity,
                                height: 500,
                                fit: BoxFit.cover,
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                        const SizedBox(height: 100),
                        // Align(
                        //   alignment: Alignment.bottomCenter,
                        //   child: AnimatedSwitcher(
                        //     duration: const Duration(milliseconds: 300),
                        //     child: isKeyboardOpen
                        //         ? _buildFeatureItemHorizontal()
                        //         : _buildFeatureItemVertical(),
                        //   ),
                        // ),
                        if (isKeyboardOpen) _buildFeatureItemHorizontal()
                        else _buildFeatureItemVertical()
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeatureItemVertical() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _featureItem(
          Icons.image,
          'Ảnh/video',
          Colors.green,
          () {
            _uploadImageFile();
          },
        ),
        _featureItem(
          Icons.person_add,
          'Gắn thẻ người khác',
          Colors.blue,
          () {},
        ),
        _featureItem(
          Icons.emoji_emotions,
          'Cảm xúc/hoạt động',
          Colors.orange,
          () {},
        ),
        _featureItem(
          Icons.location_on,
          'Check in',
          Colors.red,
          () {},
        ),
      ],
    );
  }

  Widget _buildFeatureItemHorizontal() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(Icons.image),
            onPressed: () {},
            color: Colors.green,
          ),
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () {},
            color: Colors.blue,
          ),
          IconButton(
            icon: const Icon(Icons.emoji_emotions),
            onPressed: () {},
            color: Colors.orange,
          ),
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: () {},
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _featureItem(
      IconData icon, String title, Color color, Function() onTap) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      onTap: onTap,
    );
  }
}
