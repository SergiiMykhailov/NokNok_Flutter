import 'package:flutter/cupertino.dart';
import 'package:nok_nok/data_access/repositories/base/store_repository.dart';
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

class StoreStateLoaded extends StoreStateCategoriesLoaded {

  // Public methods and properties

  BuiltList<StoreProductBase> get products => _products;
  int get totalItemsInBasket => _totalItemsInBasket;
  double get totalCost => _totalCost;

  StoreStateLoaded({@required BuiltList<StoreCategoryItem> categoryItems,
                    @required BuiltList<StoreProductBase> products,
                    @required int totalItemsInBasket,
                    @required double totalCost})
    : _products = products,
      _totalItemsInBasket = totalItemsInBasket,
      _totalCost = totalCost,
      super(categoryItems);

  bool get canPurchase {
    return totalCost > 0.0;
  }

  // Internal fields

  final BuiltList<StoreProductBase> _products;
  final int _totalItemsInBasket;
  final double _totalCost;

}

class StoreStatePurchase extends StoreState {

  // Public methods and properties

  StoreRepository get repository => _repository;
  BuiltList<StoreProductBase> get products => _products;
  int get totalItemsInBasket => _totalItemsInBasket;
  double get totalCost => _totalCost;

  StoreStatePurchase(
    this._repository,
    {@required BuiltList<StoreProductBase> products,
     @required int totalItemsInBasket,
     @required double totalCost})
    : _products = products,
      _totalItemsInBasket = totalItemsInBasket,
      _totalCost = totalCost,
      super();

  // Internal fields

  final StoreRepository _repository;
  final BuiltList<StoreProductBase> _products;
  final int _totalItemsInBasket;
  final double _totalCost;

}