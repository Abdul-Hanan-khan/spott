import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spott/models/data_models/place_category.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/utils/constants/ui_constants.dart';

import 'place_categories_screen.dart';

class PlaceCategorySelectionView extends StatefulWidget {
  final Function(PlaceCategory _selectedCategory) _onCategorySelection;
  const PlaceCategorySelectionView(this._onCategorySelection, {Key? key})
      : super(key: key);

  @override
  _PlaceCategorySelectionViewState createState() =>
      _PlaceCategorySelectionViewState();
}

class _PlaceCategorySelectionViewState
    extends State<PlaceCategorySelectionView> {
  PlaceCategory? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openCategoriesSelection,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: UiConstants.textFieldBorderRadius,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (_selectedCategory != null)
                Text(_selectedCategory?.name ?? '')
              else
                Text(
                  LocaleKeys.category.tr(),
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
              Text(
                LocaleKeys.points.tr(),
                // '+5 POINTS',
                style: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontSize: Theme.of(context).textTheme.subtitle1!.fontSize),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openCategoriesSelection() async {
    final PlaceCategory? _newCategory = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PlaceCategoriesScreen(),
      ),
    );
    if (_newCategory != null) {
      setState(() {
        _selectedCategory = _newCategory;
      });
      widget._onCategorySelection.call(_newCategory);
    }
  }
}
