import 'package:nok_nok/ui/controls/categories_list/store_categories_list_item_widget.dart';

import 'package:nok_nok/data_access/models/store_category_item.dart';

import 'package:flutter/cupertino.dart';

class StoreCategoriesListWidget extends StatelessWidget {

  // Public methods and properties

  static const PreferredCellWidth = 79.0;
  static const PreferredCellHeight = 73.0;

  StoreCategoriesListWidget({Key key, List<StoreCategoryItem> categoryItems})
   : _categoryItems = categoryItems,
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _categoryItems.length,
      itemBuilder: (BuildContext context, int index) {
        StoreCategoryItem currentItem = _categoryItems[index];

        return Container(
          width: PreferredCellWidth,
          height: PreferredCellHeight,
          child: StoreCategoriesListItemWidget(categoryItem: currentItem),
        );
      }
    );
  }

  // Internal fields

  final List<StoreCategoryItem> _categoryItems;

}