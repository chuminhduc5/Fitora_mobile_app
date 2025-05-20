import 'dart:async';

import 'package:fitora_mobile_app/common/dialog/app_error_widget.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/common/widgets/avatar/app_avatar_widget.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/feature/search/presentation/blocs/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _controller = TextEditingController();
  late final SearchBloc _searchBloc;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchBloc = getIt<SearchBloc>();
  }

  void _search(String keySearch) {
    if (keySearch.trim().isNotEmpty) {
      _searchBloc.add(SearchUserEvent(keySearch: keySearch.trim()));
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.trim().isNotEmpty) {
        _searchBloc.add(SearchUserEvent(keySearch: query.trim()));
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    _searchBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FTextField(
          enabled: true,
          controller: _controller,
          hint: "Tìm kiếm",
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          //onSubmit: _search,
          onChange: _onSearchChanged,
          textCapitalization: TextCapitalization.none,
          maxLines: 1,
        ),
      ),
      body: BlocProvider.value(
        value: _searchBloc,
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchUserLoadingState) {
              return const AppLoadingWidget();
            } else if (state is SearchUserFailureState) {
              return AppErrorWidget(state.message);
            } else if (state is SearchUserSuccessState) {
              final users = state.data;
              if (users.isEmpty) {
                return const Center(child: Text("Không tìm thấy kết quả."));
              }
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return InkWell(
                    onTap: () => context.pushNamed(
                      AppRoute.personal.name,
                      extra: user.id,
                    ),
                    child: ListTile(
                      leading: AppAvatarWidget(
                        imagePath: user.profilePictureUrl,
                        size: 40,
                      ),
                      title: Text(user.username),
                    ),
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
