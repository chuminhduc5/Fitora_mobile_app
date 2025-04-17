import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SearchFieldWidget extends StatefulWidget {
  final double size;
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const SearchFieldWidget({
    super.key,
    required this.hintText,
    this.controller,
    required this.size,
    this.onChanged,
  });

  @override
  State<SearchFieldWidget> createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  late TextEditingController _controller;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _search() {}

  void _deleteSearchContent() {
    setState(() {
      widget.controller?.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      child: TextField(
        focusNode: focusNode,
        onTapOutside: (events) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onChanged: widget.onChanged,
        controller: widget.controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          prefixIcon: IconButton(
            onPressed: _search,
            icon: const Icon(Icons.search),
          ),
          prefixIconColor: AppColors.black,
          suffixIcon: IconButton(
           onPressed: _deleteSearchContent,
            icon: const Icon(Icons.close),
          ),
          suffixIconColor: AppColors.black,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.black,
              width: 0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.bgPink, width: 1),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: AppColors.grey, fontSize: 13),
        ),
      ),
    );
  }
}
