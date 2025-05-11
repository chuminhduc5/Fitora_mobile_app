import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostTextFieldWidget<T> extends StatefulWidget {
  final void Function(String)? onChanged;
  const PostTextFieldWidget({super.key, required this.onChanged});

  @override
  State<PostTextFieldWidget<T>> createState() => _PostTextFieldWidgetState<T>();
}

class _PostTextFieldWidgetState<T> extends State<PostTextFieldWidget<T>> {
  @override
  Widget build(BuildContext context) {
    final postBloc = context.read<T>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        onChanged: widget.onChanged,
        decoration: const InputDecoration(
          hintText: 'Bạn đang nghĩ gì?',
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        maxLines: 5,
      ),
    );
  }
}
