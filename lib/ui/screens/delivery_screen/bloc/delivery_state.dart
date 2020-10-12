import 'package:nok_nok/models/basket.dart';

abstract class DeliveryState {
}

class DeliveryStateLoading extends DeliveryState {

}

class DeliveryStateLoaded extends DeliveryState {

  // Public methods and properties

  final Basket basket;
  final String address;
  final String userName;
  final String phoneNumber;
  final String email;

  DeliveryStateLoaded(
    this.basket,
    this.address,
    this.userName,
    this.phoneNumber,
    this.email);

}
