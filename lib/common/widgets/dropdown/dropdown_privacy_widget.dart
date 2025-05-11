import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DropdownPrivacyWidget extends StatefulWidget {
  const DropdownPrivacyWidget({super.key});

  @override
  State<DropdownPrivacyWidget> createState() => _DropdownPrivacyWidgetState();
}

class _DropdownPrivacyWidgetState extends State<DropdownPrivacyWidget> {
  final Map<String, String> bankNamesWithIds = {
    "Công khai": "1",
    "Riêng tư": "2",
  };

  bool _isLocked = false;
  String? selectedValue = "Công khai"; // ✅ Mặc định là Công khai

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double dropdownWidth = constraints.maxWidth;

      return DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: const Text(
            '',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
          items: bankNamesWithIds.keys
              .map((name) => DropdownMenuItem<String>(
            value: name,
            child: Text(
              name,
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ))
              .toList(),
          value: selectedValue,
          onChanged: _isLocked
              ? null
              : (String? value) {
            setState(() {
              selectedValue = value;
            });
            //widget.onChanged(bankNamesWithIds[value]);
          },
          buttonStyleData: ButtonStyleData(
            height: 45,
            width: dropdownWidth,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.grey,
                width: 1,
              ),
              color: Colors.white,
            ),
            elevation: 10,
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.unfold_more,
              size: 14,
              color: AppColors.black,
            ),
            iconSize: 14,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 180,
            width: dropdownWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            offset: const Offset(0, -10),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),

          /// ✅ BỎ phần tìm kiếm
          dropdownSearchData: null,
        ),
      );
    });
  }
}
