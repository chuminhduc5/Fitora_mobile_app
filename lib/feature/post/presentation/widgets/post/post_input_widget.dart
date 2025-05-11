import 'package:fitora_mobile_app/feature/post/presentation/blocs/post_form/post_form_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/widgets/post/post_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostInputWidget extends StatefulWidget {
  const PostInputWidget({super.key});

  @override
  State<PostInputWidget> createState() => _PostInputWidgetState();
}

class _PostInputWidgetState extends State<PostInputWidget> {
  @override
  Widget build(BuildContext context) {
    final postBloc = context.read<PostFormBloc>();
    return PostTextFieldWidget<PostFormBloc>(
      onChanged: (val) {
        postBloc.add(PostContentChangedEvent(val));
      },
    );
  }
}
