import 'package:nok_nok/models/basket.dart';

abstract class DeliveryState {
}

class DeliveryStateLoading extends DeliveryState {

}

class DeliveryStateLoaded extends DeliveryState {

  // Public methods and properties

  Basket get basket => _basket;

  DeliveryStateLoaded(Basket basket)
    : _basket = basket, super();


  // Internal fields

  final Basket _basket;

}
