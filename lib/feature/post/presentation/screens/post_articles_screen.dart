import 'dart:io';

import 'package:fitora_mobile_app/core/config/assets/app_images.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/feature/post/presentation/widgets/select_community_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/navigation/router/app_router.dart';

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
  final ImagePicker _imagePicker = ImagePicker();

  String? selectedCommunity;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final List<String> communities = ["Flutter", "Dart", "Programming", "Tech"];

  Future<void> _pickImage() async {
    final pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgWhite,
        leading: IconButton(
            onPressed: () {
              appRouter.go('/app-view');
            },
            icon: const Icon(Icons.close)),
        actions: <Widget>[
          TextButton(
              onPressed: () {},
              child: const Text(
                'Đăng',
                style: TextStyle(color: AppColors.bgOrange, fontSize: 15),
              )),
        ],
      ),
      backgroundColor: AppColors.bgWhite,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectCommunityWidget(
                onPressed: () {},
                icon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      AppImages.avatar,
                      height: 25,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Title',
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _image != null
                  ? Image.file(
                      _image!,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : TextField(
                      style: const TextStyle(color: Colors.white),
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'body text (optional)',
                        hintStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.link, color: Colors.grey),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.image, color: Colors.grey),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.video_library, color: Colors.grey),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.format_list_bulleted,
                        color: Colors.grey),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh, color: Colors.grey),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
