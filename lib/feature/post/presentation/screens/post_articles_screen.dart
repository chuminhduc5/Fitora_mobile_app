import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/feature/post/presentation/widgets/select_community_widget.dart';
import 'package:flutter/material.dart';

class PostArticlesScreen extends StatelessWidget {
  const PostArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgWhite,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
        actions: <Widget>[
          TextButton(onPressed: (){}, child: const Text('Đăng', style: TextStyle(color: AppColors.bgOrange, fontSize: 15),)),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: <Widget>[
              SelectCommunityWidget(onPressed: (){}, icon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network("https://cdn-media.sforum.vn/storage/app/media/THANHAN/avartar-anime-89.jpg", height: 25, fit: BoxFit.cover,),
                ),
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
