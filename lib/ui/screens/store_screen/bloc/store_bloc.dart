import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:nok_nok/models/store_category_item.dart';
import 'package:nok_nok/models/store_product_base.dart';

import 'store_event.dart';
import 'store_state.dart';
import 'package:nok_nok/data_access/repositories/base/store_repository.dart';

import 'package:bloc/bloc.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {

  // Public methods and properties

  StoreRepository get storeRepository => _storeRepository;

  StoreBloc(this._storeRepository)
    : super() {
    reload();
  }

  void reload() {
    dispatch(ReloadStoreEvent());
  }

  void addItemToBasket({@required int itemIndex}) {
    dispatch(AddItemToBasketEvent(itemIndex));
  }

  void purchase() {
    dispatch(PurchaseEvent());
  }

  // Overridden methods and properties

  @override
  StoreState get initialState => StoreStateLoading();

  @override
  Stream<StoreState> mapEventToState(StoreEvent event) async* {
    if (event is ReloadStoreEvent) {
      yield* _handleReload();
    }
    else if (event is AddItemToBasketEvent) {
      yield* _handleAddItem(event.itemIndex);
    }
    else if (event is PurchaseEvent) {
      yield StoreStatePurchase(_storeRepository);
    }
  }

  // Internal methods

  Stream<StoreState> _handleReload() async* {
    _currentCategories = await _storeRepository.fetchAllCategories();
    yield StoreStateCategoriesLoaded(_currentCategories);

    if (_currentCategories.isNotEmpty) {
      _currentProductsList = await _storeRepository.fetchBaseProductsForCategory(_currentCategories.first);
      yield StoreStateLoaded(
        categoryItems: _currentCategories,
        products: _currentProductsList,
        totalItemsInBasket: 0,
        totalCost: 0);
    }
    else {
      _currentProductsList = await _storeRepository.fetchBaseProductsForCategory(null);
      yield StoreStateLoaded(
        categoryItems: _currentCategories,
        products: _currentProductsList,
        totalItemsInBasket: 0,
        totalCost: 0);
    }
  }

  Stream<StoreState> _handleAddItem(int itemIndex) async* {
    if (_currentProductsList == null ||
      itemIndex >= _currentProductsList.length) {
      return;
    }

    final productAtIndex = _currentProductsList[itemIndex];
    final basket = _storeRepository.getBasket();
    basket.insertProduct(productAtIndex);

    final totalItemsCount = basket.totalItemsCount;
    final totalCost = basket.totalCost;

    yield StoreStateLoaded(
      categoryItems: _currentCategories,
      products: _currentProductsList,
      totalItemsInBasket: totalItemsCount,
      totalCost: totalCost);
  }

  // Internal fields

  StoreRepository _storeRepository;
  BuiltList<StoreCategoryItem> _currentCategories;
  BuiltList<StoreProductBase> _currentProductsList;

}