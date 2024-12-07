import 'package:fitora_mobile_app/core/config/assets/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ArticleCard extends StatefulWidget {
  final String? avatar;
  final String? author;
  final String? title;
  final String? content;
  final String? image;
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
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 0,),
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(widget.avatar!, height: 25, fit: BoxFit.cover,),
              ),
              const SizedBox(width: 5,),
              Text(widget.author!, style: const TextStyle(fontSize: 14),),
              const SizedBox(width: 8,),
              Text(widget.time!, style: const TextStyle(fontSize: 11, color: Colors.grey),),
              const Spacer(),
              IconButton(onPressed: widget.onPressed, icon: const Icon(Icons.more_vert), padding: EdgeInsets.zero, constraints: const BoxConstraints(),)
            ],
          ),
          Text(widget.title!, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
          const SizedBox(height: 5,),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              widget.image!,
              width: MediaQuery.of(context).size.width,
              height:300,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10,),
          Row(
            children: <Widget>[
              _buildFavourite(widget.favourite),
              const SizedBox(width: 5,),
              _buildComment(widget.comment),
              const Spacer(),
              _buildPremiumBadge(),
              const SizedBox(width: 5,),
              _buildShare(widget.share),
            ],
          ),
        ],
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
        IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_upward, size: 20,)),
        Container(
          padding: const  EdgeInsets.only(right: 8),
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(color: Colors.grey, width: 0),
            )
          ),
            child: Text(favouriteCount.toString())
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_downward, size: 20,)),
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
        IconButton(onPressed: () {}, icon: SvgPicture.asset(AppSvg.commentSvg, height: 20, width: 20, color: Colors.white,)),
        Text(commentCount.toString()),
      ],
    ),
  );
}

Widget _buildPremiumBadge(){
  return Container(
    height: 35,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey, width: 0),
      borderRadius: BorderRadius.circular(10),
    ),
    child: IconButton(onPressed: () {}, icon: const Icon(Icons.workspace_premium, size: 20,)),
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
        IconButton(onPressed: () {}, icon: SvgPicture.asset(AppSvg.shareSvg, height: 20, width: 20, color: Colors.white,)),
        Text(shareCount.toString()),
      ],
    ),
  );
}
