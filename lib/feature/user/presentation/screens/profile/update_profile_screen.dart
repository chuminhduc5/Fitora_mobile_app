import 'dart:io';
import 'package:fitora_mobile_app/common/dialog/app_display_message.dart';
import 'package:fitora_mobile_app/common/widgets/button/app_button_widget.dart';
import 'package:fitora_mobile_app/core/config/assets/app_images.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/extensions/integer_sizebox_extension.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/user_profile_entity.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/profile/profile_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/profile_form/profile_form_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/forms/profile/profile_form_data.dart';
import 'package:fitora_mobile_app/feature/user/presentation/widgets/profile/update_profile_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileScreen extends StatefulWidget {
  final UserProfileEntity profile;

  const UpdateProfileScreen({super.key, required this.profile});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  late File? _avatar;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _updateProfile(BuildContext context) {
    primaryFocus?.unfocus();
    final fromBloc = context.read<ProfileFormBloc>().state;
    logg.i("Id: ${widget.profile.userInfo.id}");
    logg.i("UserId: ${widget.profile.userInfo.userId}");
    logg.i("FirstName: ${fromBloc.data.firstName}");
    logg.i("LastName: ${fromBloc.data.lastName}");
    logg.i("BirthDate: ${fromBloc.data.birthDate}");
    logg.i("Gender: ${fromBloc.data.gender}");
    logg.i("Address: ${fromBloc.data.address}");
    logg.i("PhoneNumber: ${fromBloc.data.phoneNumber}");
    logg.i("PictureUrl: ${fromBloc.data.profilePictureUrl}");
    logg.i("PictureBgUrl: ${fromBloc.data.profileBackgroundPictureUrl}");
    logg.i("Bio: ${fromBloc.data.bio}");
    context.read<ProfileBloc>().add(
      UpdateProfileEvent(
        params: ProfileFormData(
          id: widget.profile.userInfo.id,
          userId: widget.profile.userInfo.userId,
          firstName: fromBloc.data.firstName,
          lastName: fromBloc.data.lastName,
          birthDate: fromBloc.data.birthDate,
          gender: fromBloc.data.gender,
          address: fromBloc.data.address,
          phoneNumber: fromBloc.data.phoneNumber,
          profilePictureUrl: _image?.path ?? "",
          profileBackgroundPictureUrl: fromBloc.data.profileBackgroundPictureUrl,
          bio: fromBloc.data.bio,
        ),
      ),
    );
  }

  @override
  void initState() {
    ProfileState currentState = context.read<ProfileBloc>().state;
    if (widget.profile.userInfo.profilePictureUrl != null &&
        widget.profile.userInfo.profilePictureUrl.isNotEmpty) {
      _avatar = File(widget.profile.userInfo.profilePictureUrl!);
    } else {
      _avatar = null;
    }
    print("State hiện tại: $currentState");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileFormBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Chỉnh sửa hồ sơ"),
          backgroundColor: AppColors.bgWhite,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.grey,
              size: 20,
            ),
            // onPressed: () => context.goNamed(AppRoute.appView.name),
            onPressed: () => context.pop(),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60.r,
                      backgroundImage: (_avatar != null)
                          ? FileImage(_avatar!)
                          : (_image != null
                          ? FileImage(_image!)
                          : const AssetImage(AppImages.avatar) as ImageProvider),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: 15.r,
                          backgroundColor: Colors.white,
                          child: const Icon(Icons.camera_alt_outlined, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              UpdateProfileFormWidget(profile: widget.profile),
              30.hS,
              BlocConsumer<ProfileBloc, ProfileState>(
                listener: (_, state) {
                  if (state is UpdateProfileFailureState) {
                    AppDisplayMessage.error(context, state.message);
                  } else if (state is UpdateProfileSuccessState) {
                    context.pop();
                    context.read<ProfileBloc>().add(FetchProfileEvent());
                    AppDisplayMessage.success(context, "Cập nhật thành công");
                  }
                },
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: AppButtonWidget(
                      onPressed: () {
                        _updateProfile(context);
                      },
                      title: "Lưu thay đổi",
                      bgColor: AppColors.bgPink,
                      paddingTop: 15,
                      paddingBottom: 15,
                      fontSize: 15,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}