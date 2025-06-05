import 'dart:io';
import 'package:fitora_mobile_app/common/dialog/app_display_message.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/common/widgets/avatar/app_avatar_widget.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/enums/file/image_type.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/newsfeed/newsfeed_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/post/post_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/post_form/post_form_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/upload_file/upload_file_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/forms/post/create_post_form_data.dart';
import 'package:fitora_mobile_app/feature/post/presentation/widgets/post/category_dropdown_widget.dart';
import 'package:fitora_mobile_app/feature/post/presentation/widgets/post/post_input_widget.dart';
import 'package:fitora_mobile_app/feature/post/presentation/widgets/post/privacy_dropdown_widget.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/user_profile_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class PostArticlesScreen extends StatefulWidget {
  final UserProfileEntity user;

  const PostArticlesScreen({super.key, required this.user});

  @override
  State<PostArticlesScreen> createState() => _PostArticlesScreenState();
}

class _PostArticlesScreenState extends State<PostArticlesScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  late UploadFileBloc _uploadFileBloc;

  List<Map<String, dynamic>> categories = [
    {"id": "", "name": "Chủ đề"},
    {"id": "08dd7006-1fa5-41f4-8ad5-205a44354035", "name": "CNTT"},
    {"id": "08dd7672-1b59-47de-8d05-6ea4b00a184a", "name": "AI"},
    {"id": "08dd7672-f518-466d-8f97-5edbc92f5d64", "name": "BE"},
    {"id": "08dd7d86-4d3c-4d18-83dd-b6202fd39886", "name": "FE"},
    {"id": "08dda29b-9f73-46c0-848e-559a45b3766e", "name": "DSA"},
    {"id": "08dda29d-16f1-4a3a-8389-2063d1a50e89", "name": "INTERN"},
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
  }

  @override
  void dispose() {
    _uploadFileBloc.close();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      logg.i("File Image Url: ${File(pickedFile.path)}");
      logg.i("Image Url: ${pickedFile.path}");
      logg.i("Url: $_image");
    }
  }

  Future<void> _uploadImageFile() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() => _image = file);
      _uploadFileBloc
          .add(UploadImageFileEvent(url: file, type: ImageType.Image));
      logg.i("File Image Url: ${File(pickedFile.path)}");
      logg.i("Image Url: ${pickedFile.path}");
      logg.i("Url: $_image");
    }
  }

  void _createPost(BuildContext context) async {
    primaryFocus?.unfocus();
    final postForm = context.read<PostFormBloc>().state;
    logg.i("Content: ${postForm.data.content}");
    logg.i("MediaUrl: ${postForm.data.mediaUrl}");
    logg.i("Privacy: ${postForm.data.privacy}");
    logg.i("GroupId: ${postForm.data.groupId}");
    logg.i("CategoryId: ${postForm.data.categoryId}");
    context.read<PostBloc>().add(
          CreatePostEvent(
            params: CreatePostFormData(
              content: postForm.data.content,
              mediaUrl: _image?.path ?? "",
              privacy: postForm.data.privacy,
              groupId: postForm.data.groupId,
              categoryId: postForm.data.categoryId,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
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
          final postBloc = context.read<PostFormBloc>();
          if (state is CreatePostLoadingState) {
            context.goNamed(AppRoute.appView.name);
          }
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: AppColors.bgWhite,
              title: const Text(
                "Tạo bài viết",
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
                  onPressed: context.watch<PostFormBloc>().state.data.isValid
                      ? () => _createPost(context)
                      : null,
                  child: const Text(
                    'ĐĂNG',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
            backgroundColor: AppColors.bgWhite,
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    ListTile(
                      leading: AppAvatarWidget(
                        imagePath: widget.user.userInfo.profilePictureUrl,
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
                    const PostInputWidget(),
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
                    if (isKeyboardOpen) ...[
                      _buildFeatureItemHorizontal()
                    ] else ...[
                      _buildFeatureItemVertical()
                    ]
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeatureItemVertical() {
    return Column(
      children: [
        _featureItem(
          Icons.image,
          'Ảnh/video',
          Colors.green,
          () {
            //_pickImage();
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.image),
              onPressed: () {
                _uploadImageFile();
              },
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
