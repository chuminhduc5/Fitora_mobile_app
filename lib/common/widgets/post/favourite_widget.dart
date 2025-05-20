import 'package:flutter/material.dart';

class FavouriteWidget extends StatelessWidget {
  final String postId;
  final int? userVoteType;
  final int? favouriteCount;
  final Color? upVoteColor;
  final Color? downVoteColor;
  final void Function(String)? upVote;
  final void Function(String)? unVote;
  final void Function(String)? downVote;

  const FavouriteWidget({
    super.key,
    required this.postId,
    this.userVoteType,
    this.favouriteCount,
    this.upVoteColor,
    this.downVoteColor,
    this.upVote,
    this.unVote,
    this.downVote
  });

  @override
  Widget build(BuildContext context) {
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
            // onPressed: () => upVote?.call(postId),
            onPressed: () {
              if (userVoteType == null) {
                return upVote?.call(postId);
              } else if (userVoteType == 1) {
                return unVote?.call(postId);
              } else if (userVoteType == 2) {
                // unVote?.call(postId);
                upVote?.call(postId);
              }
            },
            padding: EdgeInsets.zero,
            icon: Icon(Icons.arrow_upward, size: 20, color: upVoteColor),
          ),
          InkWell(
            onTap: () {},
            child: Container(
                padding: const EdgeInsets.only(right: 8),
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(color: Colors.grey, width: 0),
                  ),
                ),
                child: Text(favouriteCount.toString())),
          ),
          IconButton(
            // onPressed: () => downVote?.call(postId),
            onPressed: () {
              if (userVoteType == null) {
                return downVote?.call(postId);
              } else if (userVoteType == 2) {
                return unVote?.call(postId);
              } else if (userVoteType == 1) {
                // unVote?.call(postId);
                downVote?.call(postId);
              }
            },
            padding: EdgeInsets.zero,
            icon: Icon(Icons.arrow_downward, size: 20, color: downVoteColor),
          ),
        ],
      ),
    );
  }
}
