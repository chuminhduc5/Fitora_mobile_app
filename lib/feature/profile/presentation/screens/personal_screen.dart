import 'dart:io';

import 'package:fitora_mobile_app/common/widgets/button/app_button_widget.dart';
import 'package:fitora_mobile_app/core/config/router/app_router.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/config/theme/app_colors.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        //_image = File(pickedFile.path);
        _cropperImage(pickedFile.path);
        logg.i(pickedFile.path);
      });
    }
  }

  Future<void> _cropperImage(String imagePath) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 90,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Chỉnh sửa ảnh',
          toolbarColor: AppColors.bgPink,
          toolbarWidgetColor: Colors.white,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Cắt ảnh',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
          minimumAspectRatio: 1.0,
        ),
      ],
    );

    if (croppedFile != null) {
      setState(() {
        _image = File(croppedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
        backgroundColor: AppColors.bgWhite,
        leading: IconButton(
          onPressed: () {
            appRouter.go('/app-view');
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Center(child: Text('Minh Đức')),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                height: 180,
                width: double.infinity,
                child: _image != null
                    ? Image.file(
                        _image!,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        "https://ocafe.net/wp-content/uploads/2024/10/anh-nen-may-tinh-4k-1.jpg",
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),
              const Positioned(
                top: 100,
                left: 20,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                    "https://ocafe.net/wp-content/uploads/2024/10/hinh-nen-may-tinh-dep-4k-9.jpg",
                  ),
                ),
              ),
              Positioned(
                top: 130,
                right: 20,
                child: InkWell(
                  onTap: () {
                    logg.i("Cập nhật ảnh");
                    _pickImage();
                  },
                  child: const CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.bgWhite,
                    child: Icon(Icons.camera_alt_outlined, size: 20),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const Text(
                  'Chử Minh Đức',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text(
                  '1000 người bạn',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: AppButtonWidget(
                    onPressed: () {},
                    title: 'Thêm vào tin',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: AppButtonWidget(
                        onPressed: () {},
                        bgColor: AppColors.gray,
                        color: Colors.black,
                        paddingRight: 70,
                        paddingLeft: 70,
                        title: 'Chỉnh sửa trang cá nhân',
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.gray,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.more_horiz),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            height: 4,
            color: Colors.grey[400],
          )
        ],
      )),
    );
  }
}
