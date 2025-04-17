import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:fitora_mobile_app/common/widgets/post/comment_widget.dart';
import 'package:fitora_mobile_app/common/widgets/post/favourite_widget.dart';
import 'package:fitora_mobile_app/common/widgets/post/premium_badge_widget.dart';
import 'package:fitora_mobile_app/common/widgets/post/share_widget.dart';
import 'package:fitora_mobile_app/core/config/assets/app_svg.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/feature/home/presentation/screens/comment_screen.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/post_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forui/forui.dart';

class NewsfeedPostWidget extends StatefulWidget {
  final PostEntity post;
  final String? category;
  final Function()? onPressed;

  const NewsfeedPostWidget({
    super.key,
    required this.post,
    this.category,
    this.onPressed,
  });

  @override
  State<NewsfeedPostWidget> createState() => _NewsfeedPostWidgetState();
}

class _NewsfeedPostWidgetState extends State<NewsfeedPostWidget>
    with SingleTickerProviderStateMixin {
  // bool _isLiked = false;
  // bool _isCheckNetwork = true;
  Color _colorVote = Colors.black;
  Color _colorUnVote = Colors.black;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // void _showBottomSheet(BuildContext context) {
  //   showBottomSheet(
  //     context: context,
  //     shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
  //     builder: (BuildContext context) {
  //       return CommentScreen();
  //       // return Container(
  //       //   height: MediaQuery.of(context).size.height,
  //       //   width: MediaQuery.of(context).size.width,
  //       //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
  //       //   child: const Column(
  //       //     children: <Widget>[],
  //       //   ),
  //       // );
  //     },
  //   );
  // }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (BuildContext context) {
        return CommentScreen();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = widget.post.user;
    final post = widget.post;
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(
          color: Colors.grey,
          width: 0,
        ),
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                FAvatar(
                    image: (userInfo.profilePictureUrl != null && userInfo.profilePictureUrl.isNotEmpty)
                        ? FileImage(File(userInfo.profilePictureUrl))
                        : const NetworkImage(""),
                    size: 25),
                const SizedBox(width: 5),
                Text(
                  widget.post.user.lastName ?? "",
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(width: 8),
                Text(
                  post.createAt != null
                      ? DateFormat('yyyy-MM-dd HH:mm').format(post.createAt!)
                      : "N/A",
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
                const Spacer(),
                // IconButton(
                //   onPressed: widget.onPressed,
                //   icon: const Icon(Icons.more_vert),
                //   style: const ButtonStyle(
                //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                //   ),
                //   padding: EdgeInsets.zero,
                //   constraints: const BoxConstraints(),
                // )
                if(post.categoryName != null && post.categoryName.isNotEmpty)...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.bgPink.withOpacity(0.2), Colors.white],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.bgPink.withOpacity(0.6)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.local_offer_rounded, size: 14, color: Colors.yellow),
                        const SizedBox(width: 4),
                        Text(
                          post.categoryName ?? "Chủ đề",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.bgPink,
                          ),
                        ),
                      ],
                    ),
                  )
                ]
              ],
            ),
          ),
          Text(
            post.content!,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 5),
          if (post.mediaUrl != null && post.mediaUrl!.isNotEmpty) ...[
            Image.file(
              File(post.mediaUrl),
              height: 300,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ],
          const SizedBox(height: 10),
          Row(
            spacing: 5,
            children: <Widget>[
              FavouriteWidget(
                favouriteCount: post.votesCount,
                colorVote: _colorVote,
                colorUnVote: _colorUnVote,
                vote: () {
                  setState(() {
                    _colorVote = AppColors.bgPink;
                  });
                },
                unVote: () {
                  setState(() {
                    _colorVote = Colors.black;
                  });
                },
              ),
              CommentWidget(
                  commentCount: post.commentsCount,
                  onPressed: () {
                    _showBottomSheet(context);
                  }),
              const Spacer(),
              const PremiumBadgeWidget(),
              ShareWidget(shareCount: 0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageLayout(BuildContext context, List<dynamic> images) {
    if (images.isEmpty) return const SizedBox.shrink();

    switch (images.length) {
      case 1:
        return Image.network(
          images[0],
          height: 300,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        );
      case 2:
        return SizedBox(
          height: 300,
          child: Row(
            children: images
                .map((img) =>
                    Expanded(child: Image.network(img, fit: BoxFit.cover)))
                .toList(),
          ),
        );
      case 3:
        return SizedBox(
          height: 300,
          child: Row(
            children: [
              Expanded(child: Image.network(images[0], fit: BoxFit.cover)),
              Column(
                children: images
                    .sublist(1)
                    .map((img) =>
                        Expanded(child: Image.network(img, fit: BoxFit.cover)))
                    .toList(),
              ),
            ],
          ),
        );
      case 4:
        return SizedBox(
          height: 300,
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              childAspectRatio: 1.5,
            ),
            itemCount: images.length,
            itemBuilder: (context, index) =>
                Image.network(images[index], fit: BoxFit.cover),
          ),
        );
      default:
        return SizedBox(
          height: 300,
          child: Column(
            children: images
                .map((img) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Image.network(img, fit: BoxFit.cover),
                    ))
                .toList(),
          ),
        );
    }
  }

  Widget _buildFavourite(int? favouriteCount) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_upward, size: 20),
          ),
          Container(
              padding: const EdgeInsets.only(right: 8),
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(color: Colors.grey, width: 0),
                ),
              ),
              child: Text(favouriteCount.toString())),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_downward, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildComment(int? commentCount) {
    return Container(
      height: 35,
      padding: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              AppSvg.comment,
              height: 20,
              width: 20,
              color: Colors.black,
            ),
          ),
          Text(commentCount.toString()),
        ],
      ),
    );
  }

  Widget _buildPremiumBadge() {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.workspace_premium, size: 20),
      ),
    );
  }

  Widget _buildShare(int? shareCount) {
    return Container(
      height: 35,
      padding: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                AppSvg.share,
                height: 20,
                width: 20,
                color: Colors.black,
              )),
          Text(shareCount.toString()),
        ],
      ),
    );
  }
}
