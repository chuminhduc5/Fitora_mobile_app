import 'dart:io';
import 'package:fitora_mobile_app/core/enums/user/gender.dart';
import 'package:fitora_mobile_app/core/extensions/integer_sizebox_extension.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/user_profile_entity.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/profile_form/profile_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileFormWidget extends StatefulWidget {
  final UserProfileEntity profile;

  const UpdateProfileFormWidget({super.key, required this.profile});

  @override
  State<UpdateProfileFormWidget> createState() =>
      _UpdateProfileFormWidgetState();
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

  int genderToGenderId(Gender gender) {
    return switch (gender) {
      Gender.Male => 1,
      Gender.Female => 2,
      Gender.Other => 3,
      Gender.Unknown => 0,
    };
  }

  Gender genderIdToGender(int? genderId) {
    switch (genderId) {
      case 1:
        return Gender.Male;
      case 2:
        return Gender.Female;
      case 3:
        return Gender.Other;
      default:
        return Gender.Unknown;
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
          FTextField(
            enabled: true,
            label: const Text('Họ'),
            hint: "Ví dụ: Nguyễn",
            initialValue: userInfo.firstName,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.none,
            maxLines: 1,
            onChange: (value) {
              fromBloc.add(ProfileFormFirstNameChangedEvent(value));
            },
          ),
          10.hS,
          FTextField(
            enabled: true,
            label: const Text('Tên'),
            hint: "Ví dụ: A",
            initialValue: userInfo.lastName,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.none,
            maxLines: 1,
            onChange: (value) {
              fromBloc.add(ProfileFormLastNameChangedEvent(value));
            },
          ),
          10.hS,
          FDatePicker(
            label: const Text('Ngày sinh'),
            onSubmit: (value) {
              fromBloc.add(ProfileFormBirthDateChangedEvent(value));
            },
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
            initialValue: userInfo.gender != null
                ? {genderIdToGender(userInfo.gender)}
                : null,
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
            onSaved: (value) {
              final gender = value!.firstOrNull;
              if (gender != null) {
                final genderId = genderToGenderId(gender);
                fromBloc.add(ProfileFormGenderChangedEvent(genderId));
              }
            },
          ),
          10.hS,
          FTextField(
            enabled: true,
            label: const Text('Địa chỉ'),
            initialValue: userInfo.address,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.none,
            maxLines: 1,
            onChange: (value) {
              fromBloc.add(ProfileFormAddressChangedEvent(value));
            },
          ),
          10.hS,
          FTextField(
            enabled: true,
            label: const Text('Số điện thoại'),
            initialValue: userInfo.phoneNumber,
            keyboardType: TextInputType.phone,
            textCapitalization: TextCapitalization.none,
            maxLines: 1,
            onChange: (value) {
              fromBloc.add(ProfileFormPhoneNumberChangedEvent(value));
            },
          ),
          10.hS,
          FTextField(
            enabled: true,
            label: const Text('Tiểu sử '),
            keyboardType: TextInputType.text,
            initialValue: userInfo.bio,
            textCapitalization: TextCapitalization.none,
            maxLines: 3,
            onChange: (value) {
              fromBloc.add(ProfileFormBioChangedEvent(value));
            },
          ),
        ],
      ),
    );
  }
}
