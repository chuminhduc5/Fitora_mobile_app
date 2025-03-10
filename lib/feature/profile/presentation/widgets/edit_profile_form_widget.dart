import 'package:easy_localization/easy_localization.dart';
import 'package:fitora_mobile_app/core/enums/user/gender.dart';
import 'package:fitora_mobile_app/core/extensions/integer_sizebox_extension.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class EditProfileFormWidget extends StatelessWidget {
  const EditProfileFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FRadioSelectGroupController(value: Gender.Unknown);
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FTextField(
            enabled: true,
            label: Text('Email'),
            hint: "yourname@gmail.com",
            keyboardType: TextInputType.emailAddress,
            textCapitalization: TextCapitalization.none,
            maxLines: 1,
          ),
          10.hS,
          const FTextField(
            enabled: true,
            label: Text('Họ'),
            hint: "Ví dụ: Nguyễn",
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.none,
            maxLines: 1,
          ),
          10.hS,
          const FTextField(
            enabled: true,
            label: Text('Tên'),
            hint: "Ví dụ: A",
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.none,
            maxLines: 1,
          ),
          10.hS,
          const FDatePicker(
            label: Text('Ngày sinh'),
          ),
          10.hS,
          const Text("Giới tính", style: TextStyle(fontWeight: FontWeight.bold),),
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
              FSelectTile(
                  title: const Text('Nữ'), value: Gender.Female),
              FSelectTile(title: const Text('Khác'), value: Gender.Other),
            ],
          ),
          10.hS,
          const FTextField(
            enabled: true,
            label: Text('Địa chỉ'),
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.none,
            maxLines: 1,
          ),
          10.hS,
          const FTextField(
            enabled: true,
            label: Text('Số điện thoại'),
            keyboardType: TextInputType.phone,
            textCapitalization: TextCapitalization.none,
            maxLines: 1,
          ),
          10.hS,
          const FTextField(
            enabled: true,
            label: Text('Tiểu sử '),
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.none,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}
