import 'package:flutter/material.dart';

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
  });

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  bool _isLiked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 1)
        )
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 12,
                child: Text('H', style: TextStyle(fontSize: 13),),
              ),
              Text(widget.author!),
              Text(widget.time!),
              const Spacer(),
              IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert))
            ],
          ),
          Text(widget.content!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.network(widget.image!),
          ),
          Row(
            children: <Widget>[
              _buildFavourite(widget.favourite),
              _buildComment(widget.comment),
              _buildPremiumBadge(),
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
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      children: <Widget>[
        IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_upward)),
        Text(favouriteCount.toString()),
        IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_downward)),
      ],
    ),
  );
}

Widget _buildComment(int? commentCount) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      children: <Widget>[
        IconButton(onPressed: () {}, icon: const Icon(Icons.comment)),
        Text(commentCount.toString()),
      ],
    ),
  );
}

Widget _buildPremiumBadge(){
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(15),
    ),
    child: IconButton(onPressed: () {}, icon: const Icon(Icons.workspace_premium)),
  );
}

Widget _buildShare(int? shareCount) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      children: <Widget>[
        IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
        Text(shareCount.toString()),
      ],
    ),
  );
}
