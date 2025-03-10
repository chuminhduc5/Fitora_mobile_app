import 'dart:io';
import 'package:fitora_mobile_app/common/widgets/button/app_button_widget.dart';
import 'package:fitora_mobile_app/core/config/assets/app_images.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_conf.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

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
        logg.i("Path: ${pickedFile.path}");
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
            context.goNamed(AppRoute.appView.name);
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
                height: 180.h,
                width: double.infinity,
                child: _image != null
                    ? Image.file(
                        _image!,
                        width: 1.sw,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        AppImages.bgImage,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),
              Positioned(
                top: 100.h,
                left: 20.w,
                child: CircleAvatar(
                  radius: 60.r,
                  backgroundImage: const AssetImage(
                    AppImages.avatar,
                  ),
                ),
              ),
              Positioned(
                top: 130.h,
                right: 20.w,
                child: InkWell(
                  onTap: () {
                    logg.i("Cập nhật ảnh");
                    _pickImage();
                  },
                  child: CircleAvatar(
                    radius: 18.r,
                    backgroundColor: AppColors.bgWhite,
                    child: const Icon(Icons.camera_alt_outlined, size: 20),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),
                Text(
                  'Chử Minh Đức',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  '1000 người bạn',
                  style:
                      TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: AppButtonWidget(
                    onPressed: () {},
                    title: 'Thêm vào tin',
                    bgColor: AppColors.bgPink,
                  ),
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: AppButtonWidget(
                        onPressed: () {
                          context.goNamed(AppRoute.profile.name);
                        },
                        bgColor: AppColors.gray,
                        color: Colors.black,
                        paddingRight: 65.h,
                        paddingLeft: 65.h,
                        title: 'Chỉnh sửa trang cá nhân',
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.gray,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: const Icon(Icons.more_horiz),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.h),
            width: 1.sw,
            height: 4.h,
            color: Colors.grey[400],
          ),
          FTabs(
            style: FTabsStyle(
              padding: EdgeInsets.zero,
              decoration: const BoxDecoration(color: AppColors.bgWhite),
              selectedLabelTextStyle: const TextStyle(color: AppColors.bgPink),
              unselectedLabelTextStyle: const TextStyle(color: Colors.black),
              indicatorDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedOutlineStyle: FFocusedOutlineStyle(
                color: AppColors.bgPink,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            scrollable: true,
            tabs: [
              FTabEntry(
                label: const Text('Bài viết'),
                content: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 100,
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        //color: AppColors.bgPink,
                        child: Text("Bài viết"),
                      )
                    ],
                  ),
                ),
              ),
              FTabEntry(
                label: const Text('Ảnh'),
                content: FCard(
                  child: const Column(
                    children: [],
                  ),
                ),
              ),
              FTabEntry(
                label: const Text('Video'),
                content: FCard(
                  child: const Column(
                    children: [],
                  ),
                ),
              ),
              FTabEntry(
                label: const Text('Sự kiện'),
                content: FCard(
                  child: const Column(
                    children: [],
                  ),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
