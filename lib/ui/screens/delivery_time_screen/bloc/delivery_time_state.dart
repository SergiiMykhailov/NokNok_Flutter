import 'package:built_collection/built_collection.dart';
import 'package:nok_nok/models/basket.dart';
import 'package:nok_nok/models/store_delivery_time_slot.dart';

class DeliveryTimeSlotRowInfo {

  // Public methods and properties

  final BuiltList<DeliveryTimeSlot> timeSlots;
  final String title;

  DeliveryTimeSlotRowInfo(this.timeSlots, this.title);

}

abstract class DeliveryTimeState {
}

class DeliveryTimeStateLoading extends DeliveryTimeState {

}

class DeliveryTimeStateLoaded extends DeliveryTimeState {

  // Public methods and properties

  final Basket basket;
  final BuiltList<DeliveryTimeSlotRowInfo> timeSlotRows;

  DeliveryTimeStateLoaded(
    this.basket,
    this.timeSlotRows);

}

class DeliveryTimeStatePublishingOrder extends DeliveryTimeState {

}