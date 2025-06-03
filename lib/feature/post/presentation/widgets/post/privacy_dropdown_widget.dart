import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PrivacyDropdownWidget extends StatelessWidget {
  final String selectedPrivacyId;
  final List<Map<String, dynamic>> privacy;
  final ValueChanged<String?> onChanged;

  const PrivacyDropdownWidget({
    super.key,
    required this.selectedPrivacyId,
    required this.privacy,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final selectedPrivacy = privacy.firstWhere(
          (cat) => cat['id'] == selectedPrivacyId,
      orElse: () => privacy.first,
    );

    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedPrivacy['id'],
          onChanged: onChanged,
          icon: const Icon(
            Icons.unfold_more,
            size: 16,
            color: AppColors.bgPink,
          ),
          dropdownColor: Colors.white,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.bgPink,
            fontWeight: FontWeight.w500,
          ),
          items: privacy.map((privacy) {
            return DropdownMenuItem<String>(
              value: privacy['id'],
              child: Row(
                children: [
                  Icon(privacy['icon'], size: 16, color: AppColors.black),
                  const SizedBox(width: 4),
                  Text(privacy['privacy'], style: const TextStyle(color: AppColors.black),),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
