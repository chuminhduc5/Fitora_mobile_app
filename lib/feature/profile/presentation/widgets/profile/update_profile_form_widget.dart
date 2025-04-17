import 'dart:io';
import 'package:fitora_mobile_app/core/enums/user/gender.dart';
import 'package:fitora_mobile_app/core/extensions/integer_sizebox_extension.dart';
import 'package:fitora_mobile_app/feature/profile/domain/entities/profile_entity.dart';
import 'package:fitora_mobile_app/feature/profile/presentation/blocs/profile_form/profile_form_bloc.dart';
import 'package:fitora_mobile_app/feature/profile/presentation/widgets/profile/profile_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileFormWidget extends StatefulWidget {
  final ProfileEntity profile;

  const UpdateProfileFormWidget({super.key, required this.profile});

  @override
  State<UpdateProfileFormWidget> createState() => _UpdateProfileFormWidgetState();
}

class _UpdateProfileFormWidgetState extends State<UpdateProfileFormWidget> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

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
    final controller = FRadioSelectGroupController(value: Gender.Unknown);
    final fromBloc = context.read<ProfileFormBloc>();
    final userInfo = widget.profile.userInfo;
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ProfileTextFieldWidget(
          //   label: "Tên",
          //   hintText: "Ví dụ: A",
          //   initialValue: userInfo.lastName,
          //   onChanged: (val) {
          //     fromBloc.add(ProfileFormLastNameChangedEvent(val));
          //   },
          //   inputType: TextInputType.text,
          // ),
          // FTextField(
          //   enabled: true,
          //   label: const Text('Email'),
          //   hint: "yourname@gmail.com",
          //   initialValue: widget.profile.email,
          //   keyboardType: TextInputType.emailAddress,
          //   textCapitalization: TextCapitalization.none,
          //   maxLines: 1,
          //   onChange: (val) {,
          //   validator: (val) {
          //     if (val == null) {
          //       return "Email không được dể trống";
          //     }
          //     return null;
          //   },
          // ),
          // 10.hS,
          FTextField(
            enabled: true,
            label: const Text('Họ'),
            hint: "Ví dụ: Nguyễn",
            initialValue: widget.profile.userInfo.firstName,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.none,
            maxLines: 1,
          ),
          10.hS,
          FTextField(
            enabled: true,
            label: const Text('Tên'),
            hint: "Ví dụ: A",
            initialValue: widget.profile.userInfo.lastName,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.none,
            maxLines: 1,
            onChange: (val) {
              fromBloc.add(ProfileFormLastNameChangedEvent(val));
            },
          ),
          10.hS,
          const FDatePicker(
            label: Text('Ngày sinh'),
          ),
          10.hS,
          const Text(
            "Giới tính",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          FSelectMenuTile(
            groupController: controller,
            autoHide: true,
            title: const Text('Giới tính'),
            details: ListenableBuilder(
              listenable: controller,
              builder: (context, _) => Text(
                switch (controller.value.firstOrNull) {
                  Gender.Unknown => 'Không xác định',
                  Gender.Male => 'Nam',
                  Gender.Female => 'Nữ',
                  null || Gender.Other => 'Khác',
                },
              ),
            ),
            menu: [
              FSelectTile(title: const Text('Nam'), value: Gender.Male),
              FSelectTile(title: const Text('Nữ'), value: Gender.Female),
              FSelectTile(title: const Text('Khác'), value: Gender.Other),
            ],
          ),
          10.hS,
          FTextField(
            enabled: true,
            label: const Text('Địa chỉ'),
            initialValue: widget.profile.userInfo.address,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.none,
            maxLines: 1,
          ),
          10.hS,
          FTextField(
            enabled: true,
            label: const Text('Số điện thoại'),
            initialValue: widget.profile.userInfo.phoneNumber,
            keyboardType: TextInputType.phone,
            textCapitalization: TextCapitalization.none,
            maxLines: 1,
          ),
          10.hS,
          FTextField(
            enabled: true,
            label: const Text('Tiểu sử '),
            keyboardType: TextInputType.text,
            initialValue: widget.profile.userInfo.bio,
            textCapitalization: TextCapitalization.none,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}
