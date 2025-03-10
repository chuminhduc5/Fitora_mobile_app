import 'dart:io';
import 'package:fitora_mobile_app/core/config/assets/app_images.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/feature/post/presentation/widgets/select_community_widget.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

// class PostArticlesScreen extends StatelessWidget {
//   const PostArticlesScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.bgWhite,
//         leading: IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
//         actions: <Widget>[
//           TextButton(onPressed: (){}, child: const Text('Đăng', style: TextStyle(color: AppColors.bgOrange, fontSize: 15),)),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//           child: Column(
//             children: <Widget>[
//               SelectCommunityWidget(onPressed: (){}, icon: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(50),
//                   child: Image.asset(AppImages.avatar, height: 25, fit: BoxFit.cover,),
//                 ),
//               ),)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class PostArticlesScreen extends StatefulWidget {
  const PostArticlesScreen({super.key});

  @override
  State<PostArticlesScreen> createState() => _PostArticlesScreenState();
}

class _PostArticlesScreenState extends State<PostArticlesScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  String? selectedCommunity;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final List<String> communities = ["Flutter", "Dart", "Programming", "Tech"];

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgWhite,
        leading: IconButton(
            onPressed: () {
              context.goNamed(AppRoute.appView.name);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text(
          "Tạo bài viết",
          style: TextStyle(fontSize: 20),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {},
            child: const Text(
              'ĐĂNG',
              style: TextStyle(color: AppColors.bgPink, fontSize: 15),
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
                leading: FAvatar(
                  image: const NetworkImage(''),
                  size: 45,
                  fallback: const Icon(Icons.person),
                ),
                title: const Text('Minh Đức',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Row(
                  children: [
                    _optionButton(Icons.public, 'Công khai', Icons.unfold_more),
                    _optionButton(Icons.photo_album, 'Album', Icons.unfold_more),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Bạn đang nghĩ gì?',
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  maxLines: 5,
                ),
              ),
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

  Widget _featureItem(
      IconData icon, String title, Color color, Function() onTap) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      onTap: onTap,
    );
  }
}
