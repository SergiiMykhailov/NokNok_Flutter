import 'package:nok_nok/models/basket.dart';

abstract class DeliveryTimeState {
}

class DeliveryTimeStateLoading extends DeliveryTimeState {

}

class DeliveryTimeStateLoaded extends DeliveryTimeState {

  // Public methods and properties

  final Basket basket;

  DeliveryTimeStateLoaded(
    this.basket);

}
