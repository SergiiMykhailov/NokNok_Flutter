import 'package:built_collection/built_collection.dart';
import 'package:nok_nok/ui/screens/store_screen/controls/categories_list/store_categories_list_item_widget.dart';

import 'package:nok_nok/data_access/models/store_category_item.dart';

import 'package:flutter/cupertino.dart';
import 'package:nok_nok/ui/utils/utils.dart';

class StoreCategoriesListWidget extends StatelessWidget {

  // Public methods and properties

  static const PreferredWidth = StoreCategoriesListItemWidget.PreferredIconWidth + 2 * DefaultHorizontalPadding;

  StoreCategoriesListWidget(BuiltList<StoreCategoryItem> categoryItems, {Key key})
   : _categoryItems = categoryItems,
      super(key: key);

  // Overridden methods

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _categoryItems.length,
      itemBuilder: (BuildContext context, int index) {
        StoreCategoryItem currentItem = _categoryItems[index];

        return Container(
          child: StoreCategoriesListItemWidget(categoryItem: currentItem),
        );
      }
    );
  }

  // Internal fields

  final BuiltList<StoreCategoryItem> _categoryItems;

}