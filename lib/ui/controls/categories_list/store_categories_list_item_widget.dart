import 'package:nok_nok/data_access/models/store_category_item.dart';

import 'package:flutter/cupertino.dart';

class StoreCategoriesListItemWidget extends StatelessWidget {

  StoreCategoriesListItemWidget({Key key, StoreCategoryItem categoryItem})
    : _categoryItem = categoryItem,
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: SizedBox(
            width: PreferredIconWidth,
          ),
        ),
        Positioned(
          left: 16,
          right: 16,
          top: 3,
            width: PreferredIconWidth,
            height: PreferredIconHeight,
            child: Image.network(_categoryItem.iconPath),
          )
        ],
      );
  }

  // Internal fields

  final StoreCategoryItem _categoryItem;

  static const PreferredIconWidth = 41.0;
  static const PreferredIconHeight = 41.0;
}