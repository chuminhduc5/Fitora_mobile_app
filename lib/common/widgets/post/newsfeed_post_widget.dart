import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/common/widgets/avatar/app_avatar_widget.dart';
import 'package:fitora_mobile_app/common/widgets/post/comment_widget.dart';
import 'package:fitora_mobile_app/common/widgets/post/favourite_widget.dart';
import 'package:fitora_mobile_app/common/widgets/post/image_view_widget.dart';
import 'package:fitora_mobile_app/common/widgets/post/share_widget.dart';
import 'package:fitora_mobile_app/core/config/assets/app_svg.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/post_entity.dart';
import 'package:fitora_mobile_app/feature/post/presentation/screens/comment_screen.dart';
import 'package:fitora_mobile_app/feature/post/presentation/widgets/post/post_delete_confirm_widget.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/user_profile_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class NewsfeedPostWidget extends StatefulWidget {
  final PostEntity post;
  final String? category;
  final UserProfileEntity? userInfo;
  final void Function(String)? upVote;
  final void Function(String)? unVote;
  final void Function(String)? downVote;
  final void Function(String)? savePost;

  const NewsfeedPostWidget({
    super.key,
    required this.post,
    this.category,
    this.userInfo,
    this.upVote,
    this.unVote,
    this.downVote,
    this.savePost,
  });

  @override
  State<NewsfeedPostWidget> createState() => _NewsfeedPostWidgetState();
}

class _NewsfeedPostWidgetState extends State<NewsfeedPostWidget>
    with SingleTickerProviderStateMixin {
  late int voteCount = widget.post.votesCount;
  int? userVoteType;
  Color _upVoteColor = Colors.black;
  Color _downVoteColor = Colors.black;
  bool _actionSavedPost = false;

  bool isExpanded = false;

  bool _isLongText(String text) {
    return text.length > 200;
  }

  bool _isValidNetwork(String? path) =>
      path != null && path.trim().isNotEmpty && path.startsWith('https');

  bool _isValidFile(String? path) =>
      path != null && path.trim().isNotEmpty && File(path).existsSync();

  @override
  void initState() {
    userVoteType = widget.post.userVoteType;
    _upVoteColor =
        widget.post.userVoteType == 1 ? AppColors.bgPink : Colors.black;
    _downVoteColor =
        widget.post.userVoteType == 2 ? AppColors.bgPink : Colors.black;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showBottomSheet(BuildContext context, PostEntity post) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (BuildContext context) {
        return CommentScreen(post: post);
      },
    );
  }

  void _handleUpVote() {
    setState(() {
      if (userVoteType == 1) {
        voteCount -= 1;
        _upVoteColor = Colors.black;
        userVoteType = null;
        widget.unVote?.call(widget.post.id);
      } else {
        if (userVoteType == 2) voteCount += 2;
        if (userVoteType == null) voteCount += 1;
        _upVoteColor = AppColors.bgPink;
        _downVoteColor = Colors.black;
        userVoteType = 1;
        widget.upVote?.call(widget.post.id);
      }
    });
  }

  void _handleDownVote() {
    setState(() {
      if (userVoteType == 2) {
        voteCount += 1;
        _downVoteColor = Colors.black;
        userVoteType = null;
        widget.unVote?.call(widget.post.id);
      } else {
        if (userVoteType == 1) voteCount -= 2;
        if (userVoteType == null) voteCount -= 1;
        _downVoteColor = AppColors.bgPink;
        _upVoteColor = Colors.black;
        userVoteType = 2;
        widget.downVote?.call(widget.post.id);
      }
    });
  }

  void _handleUnVote() {
    setState(() {
      if (userVoteType == 1) {
        voteCount -= 1;
      } else if (userVoteType == 2) {
        voteCount += 1;
      }
      _upVoteColor = Colors.black;
      _downVoteColor = Colors.black;
      userVoteType = null;
      widget.unVote?.call(widget.post.id);
    });
  }

  void _savedPost() {
    setState(() {
      _actionSavedPost = true;
      widget.savePost?.call(widget.post.id);
    });
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
                AppAvatarWidget(
                    imagePath: userInfo.profilePictureUrl, size: 35),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.user.username ?? "",
                      style: const TextStyle(fontSize: 14),
                    ),
                    Row(
                      children: [
                        Text(
                          post.createAt != null
                              ? DateFormat('yyyy-MM-dd HH:mm')
                                  .format(post.createAt!)
                              : "N/A",
                          style:
                              const TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                        const SizedBox(width: 5),
                        const Icon(Icons.circle, size: 5, color: Colors.grey),
                        const SizedBox(width: 5),
                        if (post.privacy == 0)
                          const Icon(Icons.lock, size: 11, color: Colors.grey),
                        if (post.privacy == 1)
                          const Icon(Icons.people,
                              size: 11, color: Colors.grey),
                        if (post.privacy == 2)
                          const Icon(
                            Icons.public,
                            size: 11,
                            color: Colors.grey,
                          ),
                        if (post.privacy == 3)
                          const Icon(Icons.groups,
                              size: 11, color: Colors.grey),
                        if (post.privacy == 4)
                          const Icon(Icons.tune, size: 11, color: Colors.grey),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                if (post.categoryName != null &&
                    post.categoryName.isNotEmpty) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.bgGreen,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // const Icon(Icons.local_offer_rounded,
                        //     size: 14, color: Colors.yellow),
                        const Icon(Icons.star_outlined,
                            size: 14, color: Colors.yellow),
                        const SizedBox(width: 4),
                        Text(
                          post.categoryName ?? "Chủ đề",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
                const SizedBox(width: 5),
                if (widget.post.user.id == widget.userInfo?.userInfo.userId)
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: PopupMenuButton<String>(
                      padding: EdgeInsets.zero,
                      color: AppColors.bgWhite,
                      icon: const Icon(Icons.more_vert),
                      onSelected: (value) {
                        if (value == 'edit') {
                          context.pushNamed(
                            AppRoute.updatePost.name,
                            extra: widget.post,
                          );
                        } else if (value == 'delete') {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return PostDeleteConfirmWidget(postId: widget.post.id);
                              });
                        } else if (value == 'add-category') {
                        } else if (value == 'save') {
                          _savedPost();
                        } else if (value == 'report-post') {
                        } else if (value == 'report-user') {}
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Text('Chỉnh sửa'),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('Xóa bài viết'),
                        ),
                        const PopupMenuItem(
                          value: 'add-category',
                          child: Text('Thêm danh mục'),
                        ),
                        const PopupMenuItem(
                          value: 'save',
                          child: Text('Lưu bài viết'),
                        ),
                        const PopupMenuItem(
                          value: 'report-post',
                          child: Text('Báo cáo bài viết'),
                        ),
                        const PopupMenuItem(
                          value: 'report-user',
                          child: Text('Báo cáo người dùng'),
                        ),
                      ],
                    ),
                  )
                else
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: PopupMenuButton<String>(
                      padding: EdgeInsets.zero,
                      color: AppColors.bgWhite,
                      icon: const Icon(Icons.more_vert),
                      onSelected: (value) {
                        if (value == 'follow') {
                          // Theo dõi
                        } else if (value == 'save') {
                          _savedPost();
                        } else if (value == 'report-post') {
                        } else if (value == 'report-user') {}
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'follow',
                          child: Text('Theo dõi danh mục'),
                        ),
                        const PopupMenuItem(
                          value: 'save',
                          child: Text('Lưu bài viết'),
                        ),
                        const PopupMenuItem(
                          value: 'report-post',
                          child: Text('Báo cáo bài viết'),
                        ),
                        const PopupMenuItem(
                          value: 'report-user',
                          child: Text('Báo cáo người dùng'),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Text(
            post.content,
            style: const TextStyle(fontSize: 14),
            maxLines: isExpanded ? null : 5,
            overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          ),
          if (_isLongText(post.content))
            GestureDetector(
              onTap: () => setState(() => isExpanded = !isExpanded),
              child: Text(
                isExpanded ? 'Ẩn bớt' : 'Xem thêm',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
          const SizedBox(height: 5),
          _buildImage(post.mediaUrl),
          const SizedBox(height: 5),
          Row(
            spacing: 5,
            children: <Widget>[
              FavouriteWidget(
                postId: post.id,
                userVoteType: userVoteType,
                favouriteCount: voteCount,
                upVoteColor: _upVoteColor,
                downVoteColor: _downVoteColor,
                upVote: (_) => _handleUpVote(),
                downVote: (_) => _handleDownVote(),
                unVote: (_) => _handleUnVote(),
              ),
              CommentWidget(
                  commentCount: post.commentsCount,
                  onPressed: () {
                    context.pushNamed(AppRoute.comment.name, extra: post);
                  }),
              const Spacer(),
              const ShareWidget(shareCount: 0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String? imagePath) {
    ImageProvider? imageProvider;

    if (_isValidNetwork(imagePath)) {
      imageProvider = NetworkImage(imagePath!);
    } else if (_isValidFile(imagePath)) {
      imageProvider = FileImage(File(imagePath!));
    }

    if (imageProvider != null) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ImageViewWidget(imageProvider: imageProvider!),
            ),
          );
        },
        // child: Image(
        //   image: imageProvider,
        //   height: 300,
        //   width: MediaQuery.of(context).size.width,
        //   fit: BoxFit.cover,
        // ),
        child: CachedNetworkImage(
          imageUrl: imagePath!,
          placeholder: (context, url) => const SizedBox(
            height: 300,
            child: AppLoadingWidget(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          height: 300,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return const SizedBox();
    }
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
