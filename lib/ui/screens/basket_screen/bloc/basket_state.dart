import 'package:nok_nok/models/basket.dart';

abstract class BasketState {
}

class BasketStateLoading extends BasketState {

}

class BasketStateLoaded extends BasketState {

  // Public methods and properties

  Basket get basket => _basket;

  BasketStateLoaded(Basket basket)
    : _basket = basket, super();


  // Internal fields

  final Basket _basket;

}