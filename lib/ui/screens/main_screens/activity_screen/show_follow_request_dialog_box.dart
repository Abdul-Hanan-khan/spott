import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spott/blocs/activity_screen_cubit/activity_screen_cubit.dart';
import 'package:spott/models/api_responses/get_app_notifications_model.dart'
as notifcation;
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/ui_components/app_button.dart';
import 'package:spott/utils/constants/app_colors.dart';
import 'package:spott/utils/enums.dart';

void showFollowRequestDialogBox(
    BuildContext context,notifcation.Notifications _notification,) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Dialog(
          insetPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  LocaleKeys.doYouWantFollow.tr(),
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(.2),
                        borderRadius: BorderRadius.circular(100)),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(.5),
                          borderRadius: BorderRadius.circular(100)),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(100)),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: _notification.refUser?.profilePicture.toString() != null
                              ? CachedNetworkImageProvider(_notification.refUser!.profilePicture.toString())
                              : null,
                          foregroundColor: Theme.of(context).primaryColor,
                          child: (_notification.refUser!.profilePicture == null &&
                              _notification.refUser!.username != null && _notification.refUser!.username.toString().isNotEmpty)
                              ? Text(
                            _notification.refUser!.username.toString()[0].toUpperCase(),
                            style: const TextStyle(fontSize: 55, color: Colors.white),
                          )
                              : const SizedBox(),
                        )
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  _notification.refUser?.username.toString()?? '',
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  LocaleKeys.wantsToFollowYou.tr(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<ActivityScreenCubit, ActivityScreenState>(
                  listener: (context, state) {
                    if (state is FollowRequestUpdated) {
                      Navigator.of(context).pop();
                    }
                  },
                  builder: (context, state) {
                    return Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            text: LocaleKeys.accept.tr(),
                            isLoading: state is UpdatingFollowRequest &&
                                state.status ==
                                    FollowRequestUpdateStatus.accept,
                            onPressed: () {
                              context
                                  .read<ActivityScreenCubit>()
                                  .updateFollowRequest(
                                  _notification.id,
                                      _notification.refModelId,
                                      FollowRequestUpdateStatus.accept,);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: AppButton(
                            text: LocaleKeys.decline.tr(),
                            isLoading: state is UpdatingFollowRequest &&
                                state.status ==
                                    FollowRequestUpdateStatus.reject,
                            backGroundColor: AppColors.greyColor,
                            onPressed: () {
                              context
                                  .read<ActivityScreenCubit>()
                                  .updateFollowRequest(
                                      _notification.id,
                                      _notification.refModelId,
                                      FollowRequestUpdateStatus.reject);
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
