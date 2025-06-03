import 'dart:io';
import 'package:fitora_mobile_app/common/dialog/app_display_message.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/common/widgets/avatar/app_avatar_widget.dart';
import 'package:fitora_mobile_app/common/widgets/button/app_button_widget.dart';
import 'package:fitora_mobile_app/core/config/assets/app_images.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/enums/file/image_type.dart';
import 'package:fitora_mobile_app/core/extensions/integer_sizebox_extension.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/upload_file/upload_file_bloc.dart';
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
  late UploadFileBloc _uploadFileBloc;

  @override
  void initState() {
    _uploadFileBloc = getIt<UploadFileBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _uploadFileBloc.close();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() => _image = file);
      _uploadFileBloc.add(
        UploadImageFileEvent(url: file, type: ImageType.Avatar),
      );
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
              profilePictureUrl: fromBloc.data.profilePictureUrl,
              profileBackgroundPictureUrl:
                  fromBloc.data.profileBackgroundPictureUrl,
              bio: fromBloc.data.bio,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ProfileFormBloc>(),
        ),
        BlocProvider(
          create: (context) => _uploadFileBloc,
        ),
      ],
      child: Builder(
        builder: (context) {
          final formBloc = context.read<ProfileFormBloc>();
          return Scaffold(
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
                  InkWell(
                    onTap: () => _pickImage(),
                    child: BlocConsumer<UploadFileBloc, UploadFileState>(
                      listener: (_, state) {
                        if (state is UploadImageFileFailureState &&
                            state.type == ImageType.Background) {
                          AppDisplayMessage.error(context, state.message);
                        }
                      },
                      builder: (context, state) {
                        logg.i("Current upload file state: $state");
                        if (state is UploadImageFileLoadingState &&
                            state.type == ImageType.Background) {
                          return Container(
                              height: 180,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: const AppLoadingWidget());
                        } else if (state is UploadImageFileSuccessState &&
                            state.type == ImageType.Background) {
                          final imageUrl = state.imageUrl;
                          logg.i("Image Url File: $imageUrl");
                          formBloc.add(
                            ProfileFormProfileBackgroundPictureUrlChangedEvent(imageUrl.url),
                          );
                          return Container(
                            height: 180,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                imageUrl.url,
                                width: double.infinity,
                                height: 180,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }
                        return Container(
                          height: 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: const Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.camera_alt,
                                    color: Colors.grey, size: 32),
                                SizedBox(height: 8),
                                Text(
                                  'Chọn ảnh nền',
                                  style:
                                      TextStyle(color: Colors.grey, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Stack(
                      children: [
                        BlocConsumer<UploadFileBloc, UploadFileState>(
                          listener: (_, state) {
                            if (state is UploadImageFileFailureState &&
                                state.type == ImageType.Avatar) {
                              AppDisplayMessage.error(context, state.message);
                            }
                          },
                          builder: (context, state) {
                            logg.i("Current upload file state: $state");
                            if (state is UploadImageFileLoadingState &&
                                state.type == ImageType.Avatar) {
                              return Center(
                                child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey),
                                      color: Colors.white,
                                    ),
                                    child: const AppLoadingWidget()),
                              );
                            } else if (state is UploadImageFileSuccessState &&
                                state.type == ImageType.Avatar) {
                              final imageUrl = state.imageUrl;
                              logg.i("Image Url File: $imageUrl");
                              formBloc.add(ProfileFormProfilePictureUrlChangedEvent(imageUrl.url));
                              return Center(
                                child: AppAvatarWidget(
                                    imagePath: imageUrl.url, size: 150),
                              );
                            }
                            return Center(
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey),
                                  color: Colors.white,
                                ),
                                child: const Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.camera_alt,
                                          color: Colors.grey, size: 28),
                                      SizedBox(height: 6),
                                      Text(
                                        'Chọn ảnh đại diện',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                        overflow: TextOverflow.visible,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: _pickImage,
                            child: CircleAvatar(
                              radius: 15.r,
                              backgroundColor: Colors.white,
                              child:
                                  const Icon(Icons.camera_alt_outlined, size: 20),
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
          );
        }
      ),
    );
  }
}
