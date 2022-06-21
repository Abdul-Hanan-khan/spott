import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spott/blocs/settings_cubits/view_blocked_users_screen_cubit/view_blocked_users_screen_cubit.dart';
import 'package:spott/models/data_models/user.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/ui_components/loading_screen_view.dart';
import 'package:spott/ui/ui_components/user_profile_image_view.dart';
import 'package:spott/utils/show_snack_bar.dart';

class ViewBlockedUsersScreen extends StatefulWidget {
  const ViewBlockedUsersScreen({Key? key}) : super(key: key);

  @override
  _ViewBlockedUsersScreenState createState() => _ViewBlockedUsersScreenState();
}

class _ViewBlockedUsersScreenState extends State<ViewBlockedUsersScreen> {
  final List<User> _users = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViewBlockedUsersScreenCubit()..getBlockedUsers(),
      child: BlocConsumer<ViewBlockedUsersScreenCubit,
          ViewBlockedUsersScreenCubitState>(
        listener: (context, state) {
          if (state is ErrorState) {
            showSnackBar(context: context, message: state.message);
          }
          if (state is UsersFetched) {
            _users.clear();
            _users.addAll(state.users);
          }
          if (state is UserUnblocked) {
            _users.remove(
              _users.firstWhereOrNull((element) => element.id == state.userId),
            );
            if (state.message != null) {
              showSnackBar(context: context, message: state.message!);
            }
          }
        },
        builder: (context, state) {
          return LoadingScreenView(
            isLoading: state is LoadingState,
            child: Scaffold(
              appBar: AppBar(
                title: Text(LocaleKeys.blockUser.tr(),style: const TextStyle(
                  color: Colors.black,
                )),
              ),
              body: ListView.separated(
                itemCount: _users.length,
                itemBuilder: (context, index) => ListTile(
                  leading: UserProfileImageView(_users[index]),
                  title: Text(_users.elementAt(index).name ?? ''),
                  subtitle: Text(_users.elementAt(index).username ?? ''),
                  trailing: OutlinedButton(
                    onPressed: () =>
                        _unBlockUser(context, _users.elementAt(index).id),
                    child: Text(
                      LocaleKeys.unblock.tr(),
                    ),
                  ),
                ),
                separatorBuilder: (_, __) => const SizedBox(
                  height: 10,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _unBlockUser(BuildContext context, int? _id) {
    context.read<ViewBlockedUsersScreenCubit>().unBlockUsers(_id);
  }
}
