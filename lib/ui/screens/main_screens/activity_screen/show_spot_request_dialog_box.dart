import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spott/blocs/activity_screen_cubit/activity_screen_cubit.dart';
import 'package:spott/models/data_models/app_notification.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/ui_components/app_button.dart';
import 'package:spott/ui/ui_components/app_dialog_box.dart';
import 'package:spott/utils/constants/app_colors.dart';
import 'package:spott/models/api_responses/get_app_notifications_model.dart'
    as notifcation;

void showSpotRequestDialogBox(
    BuildContext context, notifcation.Notifications notification) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AppDialogBox(
        title: RichText(
          text: TextSpan(children: [
            TextSpan(
              text: '${LocaleKeys.haveYouRecognized.tr()}\n',
              style: Theme.of(context).textTheme.headline5,
            ),
            TextSpan(
                text: notification.modelData?.user?.username ?? '',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: MediaQuery.of(context).size.width * 0.07)),
          ], style: TextStyle(color: Colors.black)),
          textAlign: TextAlign.center,
        ),
        description: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: '${notification.modelData?.user?.username ?? ''} ',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w700)),
            TextSpan(text: LocaleKeys.sentYouASpottRequest.tr()),
          ], style: TextStyle(color: Colors.black)),
          textAlign: TextAlign.center,
        ),
        // Text(
        //   '${notification.modelData?.user?.username ?? ''} ${LocaleKeys.sentYouASpottRequest.tr()}',
        //   style: Theme.of(context).textTheme.subtitle1,
        //   textAlign: TextAlign.center,
        // )
        image: 'assets/icons/you_spotted.svg',
        button: Row(
          children: [
            Expanded(
              child: BlocConsumer<ActivityScreenCubit, ActivityScreenState>(
                listener: (oldState, currentState) {
                  if (currentState is SpotRequestUpdated) {
                    Navigator.of(context).pop();
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    text: LocaleKeys.yes.tr(),
                    backGroundGradient: AppColors.darkPurpleGradient,
                    isLoading: state is UpdatingSpotRequestStatus,
                    onPressed: () {
                      context.read<ActivityScreenCubit>().acceptSpotRequest(
                          notification.id.toString(),
                          notification.modelData?.id.toString(),
                          context);
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: AppButton(
                text: LocaleKeys.decline.tr(),
                backGroundColor: AppColors.greyColor,
                onPressed: () {
                  context.read<ActivityScreenCubit>().rejectSpotRequest(
                        notification.id,
                        notification.modelData!.id,
                      );
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
