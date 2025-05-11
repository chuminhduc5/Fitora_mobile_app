import 'package:fitora_mobile_app/common/widgets/textfield/app_text_field_widget.dart';
import 'package:flutter/material.dart';

class GroupIntroductionScreen extends StatefulWidget {
  const GroupIntroductionScreen({super.key});

  @override
  State<GroupIntroductionScreen> createState() =>
      _GroupIntroductionScreenState();
}

class _GroupIntroductionScreenState extends State<GroupIntroductionScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.grey[300],
            padding: const EdgeInsets.all(15),
            child: const Text("Giới thiệu",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              children: [
                const AppTextFieldWidget(
                  hinText: "Bạn đang nghĩ gì",
                  prefixIcon: const Icon(Icons.account_circle, color: Colors.black),
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  borderRadius: 5,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _iconButton(Icons.image, "Ảnh/video", Colors.green),
                    _iconButton(Icons.person_add, "Gắn thẻ người khác",
                        Colors.lightBlueAccent),
                    _iconButton(Icons.emoji_emotions, "Feeling/activity",
                        Colors.orangeAccent),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon, String label, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.black, fontSize: 12)),
      ],
    );
  }
}
