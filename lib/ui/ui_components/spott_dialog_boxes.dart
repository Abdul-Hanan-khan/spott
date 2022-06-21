import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spott/blocs/post_card_view_cubit/post_card_view_cubit.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/ui_components/app_button.dart';
import 'package:spott/ui/ui_components/app_dialog_box.dart';
import 'package:spott/utils/constants/app_colors.dart';

//! if postId is null it will just sho tutorial, if postId is not null it will show tutorial and also send the post request
Future showSendSpottRequestDialogBox(BuildContext context, {int? postId}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AppDialogBox(
        title: Text(LocaleKeys.sendASpottedRequest.tr(),style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold)),
        description: Column(
          children: [
            Text(
              LocaleKeys.areYouSpotted.tr(),
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
            Text(
              LocaleKeys.didYouRecognizeYourselfInThisPost.tr(),
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        image: 'assets/icons/send_spotted_request.svg',
        button: AppButton(
          text: LocaleKeys.next.tr(),
          onPressed: () {
            Navigator.of(context).pop();
            _showWaitConfirmationDialogBox(context, postId: postId);
          },
        ),
      );
    },
  );
}

Future _showWaitConfirmationDialogBox(BuildContext context, {int? postId}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AppDialogBox(
        title: Text(LocaleKeys.waitForConfirmation.tr(),style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold)),
        description: Column(
          children: [
            Text(
              LocaleKeys.manyPeopleIdentifiedInThisPost.tr(),
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
            Text(
              LocaleKeys.waitForAuthorToConfirmYourIdentity.tr(),
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
          ],
        ),

        image: 'assets/icons/wait_confirmation.svg',
        button: postId != null
            ? AppButton(
                text: LocaleKeys.next.tr(),
                backGroundGradient: AppColors.greenPurpleGradient,
                onPressed: () {
                  Navigator.of(context).pop();
                  _showSendASpottedDialogBox(context, postId);
                },
              )
            : AppButton(
                text: LocaleKeys.ok.tr(),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
      );
    },
  );
}

Future _showSendASpottedDialogBox(BuildContext context, int postId) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AppDialogBox(
        title: Text(LocaleKeys.sendASpottedRequest.tr()),
        description: Column(
          children: [
            Text(
                LocaleKeys.areYouSpotted.tr(),
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
            Text(
                LocaleKeys.didYouRecognizeYourselfInThisPost.tr(),
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        image: 'assets/icons/send_spotted_request.svg',
        button: Row(
          children: [
            Expanded(
                child: AppButton(
              text: LocaleKeys.yes.tr(),
              onPressed: () {
                context.read<PostCardViewCubit>().requestSpot(postId);
                Navigator.of(context).pop(true);
              },
            )),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: AppButton(
                text: LocaleKeys.cancel.tr(),
                backGroundColor: AppColors.greyColor,
                onPressed: () {
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
