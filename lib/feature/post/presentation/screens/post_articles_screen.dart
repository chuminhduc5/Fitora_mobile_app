import 'dart:io';

import 'package:fitora_mobile_app/common/dialog/app_display_message.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/enums/post/privacy_post.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/newsfeed/newsfeed_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/post/post_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/post_form/post_form_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/forms/post/create_post_form_data.dart';
import 'package:fitora_mobile_app/feature/post/presentation/widgets/post/category_dropdown_widget.dart';
import 'package:fitora_mobile_app/feature/post/presentation/widgets/post/post_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class PostArticlesScreen extends StatefulWidget {
  const PostArticlesScreen({super.key});

  @override
  State<PostArticlesScreen> createState() => _PostArticlesScreenState();
}

class _PostArticlesScreenState extends State<PostArticlesScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  List<Map<String, dynamic>> categories = [
    {"id": "", "name": "Tất cả"},
    {"id": "08dd78b5-1e98-48bf-8765-9e922cf5713a", "name": "AI"},
    {"id": "08dd78b6-8f14-48c4-8e04-2e24d010b58b", "name": "Web"},
    {"id": "08dd7d39-8397-4b70-8e57-332e0f30c3e9", "name": "Mobile"},
    {"id": "08dd7d3c-ddba-4fb1-8bf8-cbb45a87642d", "name": "BlockChain"},
  ];

  String selectedCategoryId = "";

  String selectedPrivacy = 'Công khai';
  final List<String> privacy = [
    'Công khai',
    'Bạn bè',
    'Nhóm',
    'Chỉ Mình tôi',
  ];

  String? selectedCommunity;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final List<String> communities = ["Flutter", "Dart", "Programming", "Tech"];

  final controller = FRadioSelectGroupController(value: PrivacyPost.Public);

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
    return BlocProvider(
      create: (context) => getIt<PostFormBloc>(),
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
            appBar: AppBar(
              backgroundColor: AppColors.bgWhite,
              title: const Text(
                "Tạo bài viết",
                style: TextStyle(fontSize: 20),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    _createPost(context);
                  },
                  child: const Text(
                    'ĐĂNG',
                    style: TextStyle(color: AppColors.bgPink, fontSize: 15),
                  ),
                ),
              ],
            ),
            backgroundColor: AppColors.bgWhite,
            body: SingleChildScrollView(
              child: SizedBox(
                child: Column(
                  children: [
                    ListTile(
                      leading: FAvatar(
                        image: const NetworkImage(''),
                        size: 45,
                        fallback: const Icon(Icons.person),
                      ),
                      title: const Text(
                        'Minh Đức',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Row(
                        children: [
                          _optionButton(
                              Icons.public, 'Công khai', Icons.unfold_more),
                          // _optionButton(
                          //     Icons.photo_album, 'Danh mục', Icons.unfold_more),
                          //const SizedBox(width: 5),
                          CategoryDropdownWidget(
                            selectedCategoryId: selectedCategoryId,
                            categories: categories,
                            onChanged: (String? id) {
                                setState(() {
                                  selectedCategoryId = id ?? "";
                                });
                                postBloc.add(PostCategoryIdChangedEvent(selectedCategoryId));
                            },
                          ),
                        ],
                      ),
                    ),
                    const PostInputWidget(),
                    _image != null
                        ? Image.file(
                            _image!,
                            width: double.infinity,
                            height: 500,
                            fit: BoxFit.cover,
                          )
                        : const SizedBox.shrink(),
                    //const Spacer(),
                    const SizedBox(height: 100),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: isKeyboardOpen
                            ? _buildFeatureItemHorizontal()
                            : _buildFeatureItemVertical(),
                      ),
                    ),
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
            _pickImage();
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
        _featureItem(
          Icons.videocam,
          'Video trực tiếp',
          Colors.pink,
          () {},
        ),
        _featureItem(
          Icons.format_paint,
          'Màu nền',
          Colors.teal,
          () {},
        ),
        _featureItem(
          Icons.camera_alt,
          'Camera',
          Colors.blueAccent,
          () {},
        ),
        _featureItem(
          Icons.gif,
          'File GIF',
          Colors.green,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {},
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _optionButton(IconData prefixIcon, String label, IconData suffix) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        spacing: 3,
        children: [
          Icon(prefixIcon, size: 16, color: AppColors.bgPink),
          Text(label,
              style: const TextStyle(fontSize: 12, color: AppColors.bgPink)),
          Icon(
            suffix,
            size: 16,
            color: AppColors.bgPink,
          )
        ],
      ),
    );
  }

  Widget _privacy(IconData prefixIcon, String label, IconData suffix) {
    // return Container(
    //   margin: const EdgeInsets.only(right: 5),
    //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    //   decoration: BoxDecoration(
    //     color: Colors.grey.shade100,
    //     borderRadius: BorderRadius.circular(10),
    //   ),
    //   child: Row(
    //     spacing: 3,
    //     children: [
    //       Icon(prefixIcon, size: 16, color: AppColors.bgPink),
    //       Text(label,
    //           style: const TextStyle(fontSize: 12, color: AppColors.bgPink)),
    //       Icon(
    //         suffix,
    //         size: 16,
    //         color: AppColors.bgPink,
    //       )
    //     ],
    //   ),
    // );
    return SizedBox(
      width: 120,
      height: 45,
      child: FSelectMenuTile(
        groupController: controller,
        autoHide: true,
        validator: (value) => value == null ? 'Select an item' : null,
        prefixIcon: FIcon(FAssets.icons.bell, size: 15),
        title: const Text(''),
        details: ListenableBuilder(
          listenable: controller,
          builder: (context, _) => Text(
            switch (controller.value.firstOrNull) {
              PrivacyPost.Public => 'Công khai',
              PrivacyPost.FriendsOnly => 'Bạn bè',
              PrivacyPost.GroupOnly => 'Cộng đồng',
              PrivacyPost.Private => 'Riêng tư',
              null || PrivacyPost.Custom => 'Tùy chỉnh',
            },
          ),
        ),
        menu: [
          FSelectTile(
              title: const Text('Công khai', style: TextStyle(fontSize: 12)),
              value: PrivacyPost.Public),
          FSelectTile(
              title: const Text('Bạn bè', style: TextStyle(fontSize: 12)),
              value: PrivacyPost.FriendsOnly),
          FSelectTile(
              title: const Text('Cộng đồng', style: TextStyle(fontSize: 12)),
              value: PrivacyPost.GroupOnly),
          FSelectTile(
              title: const Text('Riêng tư', style: TextStyle(fontSize: 12)),
              value: PrivacyPost.Private),
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
