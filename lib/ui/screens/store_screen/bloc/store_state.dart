import 'package:nok_nok/models/store_category_item.dart';

import 'package:built_collection/built_collection.dart';
import 'package:nok_nok/models/store_product_base.dart';

abstract class StoreState {
}

class StoreStateLoading extends StoreState {

}

class StoreStateCategoriesLoaded extends StoreState {

  // Public methods and properties

  BuiltList<StoreCategoryItem> get categoryItems => _categoryItems;

  StoreStateCategoriesLoaded(BuiltList<StoreCategoryItem> categoryItems)
    : _categoryItems = categoryItems, super();


  // Internal fields

  final BuiltList<StoreCategoryItem> _categoryItems;

}

class StoreStateBaseProductsLoaded extends StoreStateCategoriesLoaded {

  // Public methods and properties

  BuiltList<StoreProductBase> get products => _products;

  StoreStateBaseProductsLoaded(BuiltList<StoreCategoryItem> categoryItems,
                               BuiltList<StoreProductBase> products)
    : _products = products, super(categoryItems);

  // Internal fields

  final BuiltList<StoreProductBase> _products;

}