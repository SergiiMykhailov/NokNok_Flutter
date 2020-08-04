import 'package:built_collection/built_collection.dart';
import 'package:nok_nok/models/basket.dart';
import 'package:nok_nok/models/store_delivery_time_slot.dart';

abstract class DeliveryTimeState {
}

class DeliveryTimeStateLoading extends DeliveryTimeState {

}

class DeliveryTimeStateLoaded extends DeliveryTimeState {

  // Public methods and properties

  final Basket basket;
  final BuiltList<DeliveryTimeSlot> timeSlots;

  DeliveryTimeStateLoaded(
    this.basket,
    this.timeSlots);

}
