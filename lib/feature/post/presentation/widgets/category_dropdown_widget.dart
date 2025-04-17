import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CategoryDropdownWidget extends StatelessWidget {
  final String selectedCategoryId;
  final List<Map<String, dynamic>> categories;
  final ValueChanged<String?> onChanged;

  const CategoryDropdownWidget({
    super.key,
    required this.selectedCategoryId,
    required this.categories,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final selectedCategory = categories.firstWhere(
          (cat) => cat['id'] == selectedCategoryId,
      orElse: () => categories.first, // fallback nếu không tìm thấy
    );

    return Container(
      height: 27,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCategory['id'],
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
          items: categories.map((category) {
            return DropdownMenuItem<String>(
              value: category['id'],
              child: Row(
                children: [
                  const Icon(Icons.photo_album, size: 16, color: AppColors.bgPink),
                  const SizedBox(width: 4),
                  Text(category['name']),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

