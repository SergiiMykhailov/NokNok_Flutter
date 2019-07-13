import 'package:nok_nok/ui/utils/utils.dart';

import 'package:nok_nok/data_access/models/store_category_item.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoreCategoriesListItemWidget extends StatefulWidget {

  // Public methods and properties

  static const PreferredIconWidth = 64.0;
  static const PreferredIconHeight = 64.0;

  StoreCategoriesListItemWidget({Key key, StoreCategoryItem categoryItem})
    : _categoryItem = categoryItem,
      super(key: key);

  // Overridden methods

  @override
  _StoreCategoriesListItemWidgetState createState() => _StoreCategoriesListItemWidgetState(_categoryItem);

  // Internal fields

  final StoreCategoryItem _categoryItem;
}

class _StoreCategoriesListItemWidgetState extends State<StoreCategoriesListItemWidget> {

  // Public methods and properties

  _StoreCategoriesListItemWidgetState(StoreCategoryItem categoryItem)
    : _categoryItem = categoryItem, super();

  // Overridden methods

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Icon
        Container(
          padding: EdgeInsets.only(top: DefaultVerticalPadding),
          child: Center(
            child: SizedBox(
              width: StoreCategoriesListItemWidget.PreferredIconWidth,
              height: StoreCategoriesListItemWidget.PreferredIconHeight,
              child: Image.network(_categoryItem.iconPath),
            ),
          ),
        ),

        // Label
        Center(
          child: Text(
            _categoryItem.title,
            style: Theme.of(context).textTheme.caption.copyWith(fontSize: 10),
            textAlign: TextAlign.center,),
        )
      ],
    );
  }

  // Internal fields

  final StoreCategoryItem _categoryItem;

}