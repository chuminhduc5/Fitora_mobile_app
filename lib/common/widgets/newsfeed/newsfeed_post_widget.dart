import 'dart:io';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:fitora_mobile_app/core/config/assets/app_images.dart';
import 'package:fitora_mobile_app/core/config/assets/app_svg.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NewsfeedPostWidget extends StatefulWidget {
  final dynamic avatar;
  final String? author;
  final String? content;
  final List<dynamic>? images;
  final String? video;
  final DateTime? time;
  final int? favourite;
  final int? comment;
  final int? share;
  final Function()? onPressed;

  const NewsfeedPostWidget({
    super.key,
    this.avatar,
    this.author,
    this.content,
    this.video,
    this.images,
    this.time,
    this.favourite,
    this.comment,
    this.share,
    this.onPressed,
  });

  @override
  State<NewsfeedPostWidget> createState() => _NewsfeedPostWidgetState();
}

class _NewsfeedPostWidgetState extends State<NewsfeedPostWidget> {
  // bool _isLiked = false;
  // bool _isCheckNetwork = true;

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
                    child: _buildAvatarImage(widget.avatar),
                    // child: widget.images != null
                    //     ? Image.file(
                    //         widget.avatar!,
                    //         fit: BoxFit.cover,
                    //       )
                    //     : SizedBox(),
                  ),
                ),
                const SizedBox(width: 5),
                // Text(
                //   widget.author!,
                //   style: const TextStyle(fontSize: 14),
                // ),
                // const SizedBox(width: 8),
                Text(
                  widget.time != null
                      ? DateFormat('yyyy-MM-dd HH:mm').format(widget.time!)
                      : "N/A",
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
            widget.content!,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 5),
          _buildImageLayout(context, widget.images ?? []),
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

Widget _buildAvatarImage(dynamic avatar) {
  if (avatar is String) {
    String avatarPath = avatar.trim(); // Xóa khoảng trắng tránh lỗi

    // Kiểm tra nếu mediaUrl chỉ là một "string" không hợp lệ
    if (avatarPath.isEmpty || avatarPath.toLowerCase() == "string") {
      return Image.asset(AppImages.avatar, fit: BoxFit.cover); // Ảnh mặc định
    }

    // Nếu là URL hợp lệ, hiển thị ảnh từ mạng
    if (avatarPath.startsWith('http')) {
      return Image.network(
        avatarPath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(AppImages.avatar, fit: BoxFit.cover); // Nếu lỗi thì dùng ảnh mặc định
        },
      );
    }

    // Nếu là Asset hợp lệ
    if (avatarPath.startsWith('assets/')) {
      return Image.asset(avatarPath, fit: BoxFit.cover);
    }

    // Nếu không hợp lệ, hiển thị ảnh mặc định
    return Image.asset(AppImages.avatar, fit: BoxFit.cover);
  }

  // Nếu là File từ bộ nhớ
  else if (avatar is File) {
    return Image.file(
      avatar,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(AppImages.avatar, fit: BoxFit.cover); // Nếu lỗi thì fallback ảnh mặc định
      },
    );
  }

  // Trường hợp avatar không hợp lệ
  else {
    return Image.asset(AppImages.avatar, fit: BoxFit.cover);
  }
}

Future<Uint8List?> convertFileToUint8List(String path) async {
  if (kIsWeb) return null; // Web không đọc file trực tiếp
  File file = File(path);
  if (await file.exists()) {
    return await file.readAsBytes();
  }
  return null;
}

Widget _buildImageLayout(BuildContext context, List<dynamic> images) {
  if (images.isEmpty) return const SizedBox.shrink();

  // Hàm để xác định widget hiển thị ảnh dựa trên kiểu dữ liệu
  Widget buildImageWidget(dynamic img) {
    if (img is File) {
      if (kIsWeb) {
        return FutureBuilder<Uint8List?>(
          future: convertFileToUint8List(img.path),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData && snapshot.data != null) {
              return Image.memory(snapshot.data!, fit: BoxFit.cover);
            }
            return const Icon(Icons.broken_image, size: 50, color: Colors.grey);
          },
        );
      }
      return Image.file(img, fit: BoxFit.cover);
    } else if (img is Uint8List) {
      return Image.memory(img, fit: BoxFit.cover);
    } else if (img is String) {
      if (img.startsWith('http') || img.startsWith('https')) {
        return Image.network(img, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.broken_image, size: 50, color: Colors.grey);
        });
      } else if (img.startsWith('/data/user/')) {
        // Chuyển đổi đường dẫn file local thành Uint8List để hiển thị trên Web
        return FutureBuilder<Uint8List?>(
          future: convertFileToUint8List(img),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData && snapshot.data != null) {
              return Image.memory(snapshot.data!, fit: BoxFit.cover);
            }
            return const Icon(Icons.broken_image, size: 50, color: Colors.grey);
          },
        );
      } else {
        return Image.asset(img, fit: BoxFit.cover);
      }
    }
    return const SizedBox.shrink();
  }

  switch (images.length) {
    case 1:
      return SizedBox(
        height: 300,
        width: MediaQuery.of(context).size.width,
        child: buildImageWidget(images[0]),
      );
    case 2:
      return SizedBox(
        height: 300,
        child: Row(
          children: images.map((img) => Expanded(child: buildImageWidget(img))).toList(),
        ),
      );
    case 3:
      return SizedBox(
        height: 300,
        child: Row(
          children: [
            Expanded(child: buildImageWidget(images[0])),
            Column(
              children: images.sublist(1).map((img) => Expanded(child: buildImageWidget(img))).toList(),
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
            childAspectRatio: 1.2,
          ),
          itemCount: images.length,
          itemBuilder: (context, index) => buildImageWidget(images[index]),
        ),
      );
    default:
      return SizedBox(
        height: 300,
        child: Column(
          children: images
              .map((img) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: buildImageWidget(img),
          ))
              .toList(),
        ),
      );
  }
}

// Widget _buildVideoPlayer(String videoUrl) {
//   return SizedBox(
//     width: double.infinity,
//     height: 300,
//     child: VideoPlayerWidget(
//       videoUrl: videoUrl,
//     ),
//   );
// }

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
