import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

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
        _setLanguage(Locale(en));
        GetStorage().write('Language', en);
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
}
