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
import 'package:fitora_mobile_app/feature/user/domain/entities/managed_group_entity.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/group/group_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/group_form/group_form_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/forms/group/create_group_form_data.dart';
import 'package:fitora_mobile_app/feature/user/presentation/forms/group/update_group_form_data.dart';
import 'package:fitora_mobile_app/feature/user/presentation/widgets/group/dropdown_privacy_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/widgets/text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class UpdateGroupScreen extends StatefulWidget {
  final ManagedGroupEntity managedGroup;

  const UpdateGroupScreen({super.key, required this.managedGroup});

  @override
  State<UpdateGroupScreen> createState() => _UpdateGroupScreenState();
}

class _UpdateGroupScreenState extends State<UpdateGroupScreen> {
  final TextEditingController _nameController = TextEditingController();
  late UploadFileBloc _uploadFileBloc;
  final ImagePicker _picker = ImagePicker();
  String? _backgroundImageUrl;
  String? _avatarImageUrl;

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

  void _updateGroup(BuildContext context) {
    primaryFocus?.unfocus();
    final formBloc = context.read<GroupFormBloc>().state;
    final originalGroup = widget.managedGroup;

    final updatedName =
        (formBloc.data.name == null || formBloc.data.name!.trim().isEmpty)
            ? originalGroup.name
            : formBloc.data.name!;

    final updatedDescription = (formBloc.data.description == null ||
            formBloc.data.description!.trim().isEmpty)
        ? originalGroup.description
        : formBloc.data.description!;

    final updatedPrivacy = (formBloc.data.privacy == null)
        ? originalGroup.privacy
        : formBloc.data.privacy;

    final updatedCoverImageUrl = (formBloc.data.coverImageUrl == null ||
            formBloc.data.coverImageUrl!.trim().isEmpty)
        ? originalGroup.coverImageUrl ?? ''
        : formBloc.data.coverImageUrl!;

    final updatedAvatarUrl = (formBloc.data.avatarUrl == null ||
            formBloc.data.avatarUrl!.trim().isEmpty)
        ? originalGroup.avatarUrl ?? ''
        : formBloc.data.avatarUrl!;

    logg.i("Id: ${widget.managedGroup.id}");
    logg.i("Name: $updatedName");
    logg.i("Description: $updatedDescription");
    logg.i("Privacy: $updatedPrivacy");
    logg.i("BgImage: $updatedCoverImageUrl");
    logg.i("Avatar: $updatedAvatarUrl");
    context.read<GroupBloc>().add(
          UpdateGroupEvent(
            UpdateGroupFormData(
              id: widget.managedGroup.id,
              name: updatedName,
              description: updatedDescription,
              privacy: updatedPrivacy,
              requirePostApproval: true,
              coverImageUrl: updatedCoverImageUrl,
              avatarUrl: updatedAvatarUrl,
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
              title: const Text('Chỉnh sửa nhóm'),
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
                        } else if (state is UploadImageFileSuccessState &&
                            state.type == ImageType.Background) {
                          setState(() {
                            _backgroundImageUrl = state.imageUrl.url;
                          });
                          formBloc.add(GroupCoverImageUrlChangeEvent(
                              state.imageUrl.url));
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
                        }

                        if (_backgroundImageUrl != null) {
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
                                _backgroundImageUrl!,
                                width: double.infinity,
                                height: 180,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }

                        if (widget.managedGroup.coverImageUrl != null &&
                            widget.managedGroup.avatarUrl.isNotEmpty) {
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
                                widget.managedGroup.coverImageUrl!,
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
                        } else if (state is UploadImageFileSuccessState &&
                            state.type == ImageType.Avatar) {
                          setState(() {
                            _avatarImageUrl = state.imageUrl.url;
                          });
                          formBloc.add(
                              GroupAvatarUrlChangeEvent(state.imageUrl.url));
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
                        }
                        if (_avatarImageUrl != null) {
                          return Center(
                            child: AppAvatarWidget(
                                imagePath: _avatarImageUrl, size: 150),
                          );
                        }

                        if (widget.managedGroup.avatarUrl != null &&
                            widget.managedGroup.avatarUrl.isNotEmpty) {
                          return Center(
                            child: AppAvatarWidget(
                                imagePath: widget.managedGroup.avatarUrl,
                                size: 150),
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
                    initialValue: widget.managedGroup.name,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.none,
                    maxLines: 1,
                    onChange: (val) {
                      formBloc.add(GroupNameChangeEvent(val));
                    },
                  ),
                  const SizedBox(height: 16),
                  FTextField(
                    enabled: true,
                    label: const Text('Mô tả'),
                    hint: "",
                    initialValue: widget.managedGroup.description,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.none,
                    maxLines: 1,
                    onChange: (val) {
                      formBloc.add(GroupDescriptionChangeEvent(val));
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
                      if (state is UpdateGroupFailureState) {
                        AppDisplayMessage.error(context, state.message);
                      } else if (state is UpdateGroupSuccessState) {
                        context.pop();
                        context.read<GroupBloc>().add(FetchManagedGroupEvent());
                        AppDisplayMessage.success(
                            context, "Cập nhật nhóm thành công");
                      }
                    },
                    builder: (context, state) {
                      if (state is UpdateGroupLoadingState){
                        return const AppLoadingWidget();
                      }
                      return SizedBox(
                        width: double.infinity,
                        child: AppButtonWidget(
                          onPressed: () {
                            _updateGroup(context);
                          },
                          title: "Cập nhật",
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
