import 'package:flutter/material.dart';

import '../../../../core/config/theme/app_colors.dart';

class PersonalScreen extends StatelessWidget {
  const PersonalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: Column(
        children: [
          Container(
              color: AppColors.bgWhite,
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(height: 200, color: AppColors.bgOrange),
                      const Positioned(
                        top: 110,
                        left: 20,
                        child: const CircleAvatar(
                          radius: 65,
                          backgroundImage:
                          AssetImage('assets/images/dainam.jpg'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60), // Space for profile picture
                  const Text(
                    'Chử Minh Đức',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'MSV: 1571020064    Lớp: CNTT 15-05',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                ],
              )),
        ],
      ),
    );
  }
}
