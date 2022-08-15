import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/ui_components/app_button.dart';
import 'package:spott/ui/ui_components/app_dialog_box.dart';
import 'package:spott/utils/constants/api_constants.dart';
import 'package:spott/utils/constants/app_colors.dart';
import 'package:spott/utils/show_snack_bar.dart';

class LanguageSelectionView extends StatefulWidget {
  const LanguageSelectionView({Key? key}) : super(key: key);

  @override
  _LanguageSelectionViewState createState() => _LanguageSelectionViewState();
}

class _LanguageSelectionViewState extends State<LanguageSelectionView> {
  void _setLanguage(Locale locale) {
    context.setLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 280,
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 20),
        children: [
          _selectLanguage('English', 'en'),
          _selectLanguage('Italian', 'it'),
          _selectLanguage('Spanish', 'es'),
          _selectLanguage('French', 'fr'),
          _selectLanguage('Portuguese', 'pt'),
        ],
      ),
    );
  }

  Widget _selectLanguage(String title, String en) {
    return InkWell(
      onTap: () {
        bool updateStatus=false;
        updateLanguageApi(en).then((value) {
          if(value == true){
            _setLanguage(Locale(en));
            GetStorage().write('Language', en);
          }
          else{showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AppDialogBox(
                title: Text('Error'),
                // image: 'assets/icons/you_spotted.svg',
                button: AppButton(
                  text: LocaleKeys.ok.tr(),
                  backGroundGradient: AppColors.darkPurpleGradient,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                description: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Something went wrong. you do following things.\n   * Try again  \n   * Try checking your internet\n   * Try again later',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),

                  ], style: TextStyle(color: Colors.black)),
                  textAlign: TextAlign.left,
                ),
              );
            },
          );

          }

        });
        print(updateStatus);

      },
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            if (context.locale == Locale(en))
              Icon(
                Icons.check_circle_rounded,
                color: Theme.of(context).primaryColor,
                size: 22,
              ),
          ],
        ),
      ),
    );
  }

 Future<bool?> updateLanguageApi(String key) async {
    try {
      final Dio dio = Dio();
      dio.options.headers["Authorization"] = "Bearer ${AppData.accessToken}";
      final Response response = await dio.post(
        "https://app.spottat.com/api/auth/update-language",
        data: FormData.fromMap({"language": key}),
      );
      if (response.statusCode == 200) {
        print("status code ${response.statusCode}");
        return true;
        debugPrint('add post data ${response.data}');
      } else {
        return false;
      }
    } catch (e) {
      if (e is DioError) {
        print(e);
      }
      return false;
    }
  }
}
