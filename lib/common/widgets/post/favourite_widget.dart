import 'package:fitora_mobile_app/feature/post/presentation/blocs/interact/interact_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteWidget extends StatelessWidget {
  final Function()? upVote;
  final Function()? unVote;
  final Function()? downVote;

  const FavouriteWidget({
    super.key,
    this.upVote,
    this.unVote,
    this.downVote,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InteractBloc, InteractState>(
      builder: (context, state) {
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
                onPressed: state.userVoteType == 1 ? unVote : upVote,
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.arrow_upward,
                  size: 20,
                  color: state.upVoteColor,
                ),
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
                    child: Text(state.voteCount.toString())),
              ),
              IconButton(
                onPressed: state.userVoteType == 2 ? unVote : downVote,
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.arrow_downward,
                  size: 20,
                  color: state.downVoteColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
