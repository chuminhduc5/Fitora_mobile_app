import 'dart:io';
import 'package:fitora_mobile_app/common/dialog/app_display_message.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/common/widgets/avatar/app_avatar_widget.dart';
import 'package:fitora_mobile_app/common/widgets/button/app_button_widget.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/enums/file/image_type.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/upload_file/upload_file_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/group/group_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/group_form/group_form_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/forms/group/create_group_form_data.dart';
import 'package:fitora_mobile_app/feature/user/presentation/widgets/group/dropdown_privacy_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/widgets/text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final TextEditingController _nameController = TextEditingController();
  late UploadFileBloc _uploadFileBloc;

  final ImagePicker _picker = ImagePicker();

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
      final file = File(pickedFile.path);
      _uploadFileBloc
          .add(UploadImageFileEvent(file: file, type: ImageType.Background));
    }
  }

  Future<void> _pickAvatarImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      _uploadFileBloc
          .add(UploadImageFileEvent(file: file, type: ImageType.Avatar));
    }
  }

  void _createGroup(BuildContext context) {
    primaryFocus?.unfocus();
    final formBloc = context.read<GroupFormBloc>().state;
    logg.i("Name: ${formBloc.data.name}");
    logg.i("Description: ${formBloc.data.description}");
    logg.i("Privacy: ${formBloc.data.privacy}");
    logg.i("BgImage: ${formBloc.data.coverImageUrl}");
    logg.i("Avatar: ${formBloc.data.avatarUrl}");
    context.read<GroupBloc>().add(
          CreateGroupEvent(
            CreateGroupFormData(
              name: formBloc.data.name,
              description: formBloc.data.description,
              privacy: formBloc.data.privacy,
              requirePostApproval: true,
              coverImageUrl: formBloc.data.coverImageUrl,
              avatarUrl: formBloc.data.avatarUrl,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<GroupFormBloc>(),
        ),
        BlocProvider(
          create: (context) => _uploadFileBloc,
        ),
      ],
      child: Builder(
        builder: (context) {
          final bool isButtonEnabled = _nameController.text.trim().isNotEmpty;
          final formBloc = context.read<GroupFormBloc>();
          return Scaffold(
            appBar: AppBar(
              title: const Text('Tạo nhóm'),
              leading: const CloseButton(),
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
                          formBloc
                              .add(GroupCoverImageUrlChangeEvent(imageUrl.url));
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
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () => _pickAvatarImage(),
                    child: BlocConsumer<UploadFileBloc, UploadFileState>(
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
                          formBloc.add(GroupAvatarUrlChangeEvent(imageUrl.url));
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
                  ),
                  const SizedBox(height: 24),
                  FTextField(
                    enabled: true,
                    label: const Text('Tên nhóm'),
                    hint: "",
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.none,
                    maxLines: 1,
                    onChange: (value) {
                      formBloc.add(GroupNameChangeEvent(value));
                    },
                  ),
                  const SizedBox(height: 16),
                  FTextField(
                    enabled: true,
                    label: const Text('Mô tả'),
                    hint: "",
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.none,
                    maxLines: 1,
                    onChange: (value) {
                      formBloc.add(GroupDescriptionChangeEvent(value));
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Quyền riêng tư',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                  DropdownPrivacyWidget(
                    onChanged: (value) => formBloc.add(
                      GroupPrivacyChangeEvent(value),
                    ),
                  ),
                  const SizedBox(height: 24),
                  BlocConsumer<GroupBloc, GroupState>(
                    listener: (context, state) {
                      if (state is CreateGroupFailureState) {
                        AppDisplayMessage.error(context, state.message);
                      } else if (state is CreateGroupSuccessState) {
                        context.pop();
                        context.read<GroupBloc>().add(FetchManagedGroupEvent());
                        AppDisplayMessage.success(
                            context, "Tạo nhóm thành công");
                      }
                    },
                    builder: (context, state) {
                      if (state is CreateGroupLoadingState){
                        return const AppLoadingWidget();
                      }
                      return SizedBox(
                        width: double.infinity,
                        child: AppButtonWidget(
                          onPressed: () {
                            _createGroup(context);
                          },
                          title: "Tạo nhóm",
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
        },
      ),
    );
  }
}
