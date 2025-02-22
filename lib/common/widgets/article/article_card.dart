import 'package:fitora_mobile_app/common/widgets/article/video_player_widget.dart';
import 'package:fitora_mobile_app/core/config/assets/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ArticleCard extends StatefulWidget {
  final String? avatar;
  final String? author;
  final String? title;
  final String? content;
  final String? image;
  final List<String> images;
  final String? video;
  final String? description;
  final String? time;
  final int? favourite;
  final int? comment;
  final int? share;
  final Function()? onPressed;

  const ArticleCard({
    super.key,
    this.avatar,
    this.author,
    this.title,
    this.content,
    this.image,
    this.video,
    required this.images,
    this.description,
    this.time,
    this.favourite,
    this.comment,
    this.share,
    this.onPressed,
  });

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  bool _isLiked = false;
  bool _isCheckNetwork = true;

  @override
  Widget build(BuildContext context) {
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: SizedBox(
                    height: 25,
                    child: Image.asset(
                      widget.avatar!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  widget.author!,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(width: 8),
                Text(
                  widget.time!,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
                const Spacer(),
                IconButton(
                  onPressed: widget.onPressed,
                  icon: const Icon(Icons.more_vert),
                  style: const ButtonStyle(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                )
              ],
            ),
          ),
          Text(
            widget.title!,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 5),
          _buildImageLayout(context, widget.images),
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(10),
          //   child: _isCheckNetwork
          //       ? (widget.image == null || widget.image!.isEmpty)
          //           ? const SizedBox.shrink()
          //           : Image.network(
          //               widget.image!,
          //               width: MediaQuery.of(context).size.width,
          //               height: 300,
          //               fit: BoxFit.cover,
          //             )
          //       : SizedBox(
          //           width: MediaQuery.of(context).size.width,
          //           height: 300,
          //           child: const Center(
          //             child: Text('Error'),
          //           ),
          //         ),
          // ),

          // // Trường hợp bài đăng chỉ có video
          // if (widget.video != null && (widget.images == null || widget.images!.isEmpty))...[
          //   _buildVideoPlayer(widget.video!),
          // ],
          //
          // // Trường hợp bài đăng có nhiều ảnh
          // if (widget.video == null && widget.images != null && widget.images!.isNotEmpty)...[
          //
          // ],
          //
          // // Trường hợp bài đăng có cả ảnh và video
          // if (widget.video != null && widget.images != null && widget.images!.isNotEmpty)...[
          //   Row(
          //     children: [
          //       _buildVideoPlayer(widget.video!),
          //     ],
          //   )
          // ],

          const SizedBox(height: 10),
          Row(
            spacing: 5,
            children: <Widget>[
              _buildFavourite(widget.favourite),
              _buildComment(widget.comment),
              const Spacer(),
              _buildPremiumBadge(),
              _buildShare(widget.share),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildImageLayout(BuildContext context, List<String> images) {
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

Widget _buildVideoPlayer(String videoUrl) {
  return SizedBox(
    width: double.infinity,
    height: 300,
    child: VideoPlayerWidget(
      videoUrl: videoUrl,
    ),
  );
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
            AppSvg.commentSvg,
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
              AppSvg.shareSvg,
              height: 20,
              width: 20,
              color: Colors.black,
            )),
        Text(shareCount.toString()),
      ],
    ),
  );
}
