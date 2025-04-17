import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FavouriteWidget extends StatelessWidget {
  final int? favouriteCount;
  final Color? colorVote;
  final Color? colorUnVote;
  final Function()? vote;
  final Function()? unVote;

  const FavouriteWidget({
    super.key,
    this.favouriteCount,
    required this.colorVote,
    required this.colorUnVote,
    required this.vote,
    required this.unVote,
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
            onPressed: vote,
            icon: Icon(Icons.arrow_upward, size: 20, color: colorVote),
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
            onPressed: unVote,
            icon: Icon(Icons.arrow_downward, size: 20, color: colorUnVote),
          ),
        ],
      ),
    );
  }
}
