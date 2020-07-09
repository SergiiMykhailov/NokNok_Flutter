import 'package:nok_nok/models/store_product_base.dart';

class Basket {

  // Public methods and properties

  List<BasketItem> get items => _items;

  void insertProduct(StoreProductBase product) {
    final existingItemIndex =
      _items.indexWhere((currentElement) => currentElement._product.id == product.id);

    if (existingItemIndex >= 0) {
      _items[existingItemIndex].increment();
    }
    else {
      final itemToInsert = BasketItem(product);
      _items.add(itemToInsert);
    }
  }

  void decrementProduct(StoreProductBase product) {
    final existingItemIndex =
      _items.indexWhere((currentElement) => currentElement._product.id == product.id);

    if (existingItemIndex >= 0) {
      final existingItem = _items[existingItemIndex];
      existingItem.decrement();

      if (existingItem.quantity == 0) {
        _items.removeAt(existingItemIndex);
      }
    }
  }

  void removeProduct(StoreProductBase product) {
    final existingItemIndex =
      _items.indexWhere((currentElement) => currentElement._product.id == product.id);

    if (existingItemIndex >= 0) {
      _items.removeAt(existingItemIndex);
    }
  }

  int get totalItemsCount {
    int result = 0;

    for (var basketItem in _items) {
      result += basketItem.quantity;
    }

    return result;
  }

  double get totalCost {
    double result = 0;

    for (var basketItem in _items) {
      final currentItemTotalCost = basketItem.product.price * basketItem.quantity;
      result += currentItemTotalCost;
    }

    return result;
  }

  // Internal fields

  var _items = List<BasketItem>();

}

class BasketItem {

  StoreProductBase get product => _product;
  int get quantity => _quantity;

  BasketItem(this._product);

  void increment() {
    _quantity++;
  }

  void decrement() {
    if (quantity > 0) {
      _quantity--;
    }
  }

  StoreProductBase _product;
  int _quantity = 1;

}