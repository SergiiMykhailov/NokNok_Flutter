import 'package:nok_nok/data_access/models/store_category_item.dart';

import 'package:built_collection/built_collection.dart';

abstract class StoreState {
}

class StoreStateLoading extends StoreState {

}

class StoreStateLoaded extends StoreState {

  // Public methods and properties

  BuiltList<StoreCategoryItem> get categoryItems => _categoryItems;

  StoreStateLoaded(this._categoryItems)
    : super();


  // Internal fields

  BuiltList<StoreCategoryItem> _categoryItems;

}