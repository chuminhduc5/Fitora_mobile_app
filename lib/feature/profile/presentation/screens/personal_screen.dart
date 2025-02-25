import 'package:fitora_mobile_app/common/widgets/button/app_button_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/config/assets/app_images.dart';
import '../../../../core/config/theme/app_colors.dart';

class PersonalScreen extends StatelessWidget {
  const PersonalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
        backgroundColor: AppColors.bgWhite,
        title: const Center(child: Text('Minh Đức')),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                child: Image.asset(AppImages.logoLogin),
              ),
              const Positioned(
                top: 110,
                left: 20,
                child: CircleAvatar(
                    radius: 65, backgroundImage: AssetImage(AppImages.avatar)),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                const Text(
                  'Chử Minh Đức',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text(
                  '1000 người bạn',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                AppButtonWidget(label: 'Thêm vào tin', callback: () {},)
              ],
            ),
          )
        ],
      )),
    );
  }
}
