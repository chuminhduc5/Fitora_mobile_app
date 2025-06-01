import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/saved_post/saved_post_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/widgets/profile/saved_post_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedPostScreen extends StatefulWidget {
  const SavedPostScreen({super.key});

  @override
  State<SavedPostScreen> createState() => _SavedPostScreenState();
}

class _SavedPostScreenState extends State<SavedPostScreen> {
  late SavedPostBloc _savedPostBloc;

  @override
  void initState() {
    _savedPostBloc = getIt<SavedPostBloc>()..add(FetchSavedPostEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bài viết đã lưu"),
      ),
      body: BlocProvider(
        create: (context) => _savedPostBloc,
        child: const SavedPostListWidget(),
      ),
    );
  }
}
