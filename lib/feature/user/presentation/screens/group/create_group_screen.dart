import 'dart:io';
import 'package:fitora_mobile_app/common/dialog/app_display_message.dart';
import 'package:fitora_mobile_app/common/widgets/button/app_button_widget.dart';
import 'package:fitora_mobile_app/common/widgets/dropdown/dropdown_privacy_widget.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/group/group_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/group_form/group_form_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/forms/group/create_group_form_data.dart';
import 'package:fitora_mobile_app/feature/user/presentation/forms/group/group_form_data.dart';
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
  String _privacy = 'Công khai';

  final List<String> _privacyOptions = ['Công khai', 'Riêng tư'];

  File? _image;
  final ImagePicker _picker = ImagePicker();
  late File? _avatar;
  File? _avatarImage;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickAvatarImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _avatarImage = File(pickedFile.path);
      });
    }
  }

  void _createGroup(BuildContext context) {
    primaryFocus?.unfocus();
    final formBloc = context.read<GroupFormBloc>().state;
    logg.i("Name: ${formBloc.data.name}");
    logg.i("Description: ${formBloc.data.description}");
    logg.i("BgImage: $_image");
    logg.i("Avatar: $_avatarImage");
    context.read<GroupBloc>().add(
          CreateGroupEvent(
            CreateGroupFormData(
              name: formBloc.data.name,
              description: formBloc.data.description,
              privacy: 1,
              requirePostApproval: true,
              coverImageUrl: _image?.path ?? "",
              avatarUrl: _avatarImage?.path ?? "",
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GroupFormBloc>(),
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
                    onTap: () {
                      _pickImage();
                    },
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: _image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                _image!,
                                width: double.infinity,
                                height: 180,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Center(
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
                    ),
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      _pickAvatarImage();
                    },
                    child: _avatarImage != null
                        ? Center(
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: FileImage(_avatarImage!),
                            ),
                          )
                        : Center(
                            child: Container(
                              width: 120,
                              height: 120,
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
                    onChange: (val) {
                      formBloc.add(GroupNameChangeEvent(val));
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
                    onChange: (val) {
                      formBloc.add(GroupDescriptionChangeEvent(val));
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Quyền riêng tư',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                  const DropdownPrivacyWidget(),
                  const SizedBox(height: 24),
                  BlocConsumer<GroupBloc, GroupState>(
                    listener: (context, state) {
                      if (state is CreateGroupFailureState) {
                        AppDisplayMessage.error(context, state.message);
                      } else if (state is CreateGroupSuccessState) {
                        context.pop();
                        context.read<GroupBloc>().add(FetchManagedGroupEvent());
                        AppDisplayMessage.success(context, "Tạo nhóm thành công");
                      }
                    },
                    builder: (context, state) {
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
