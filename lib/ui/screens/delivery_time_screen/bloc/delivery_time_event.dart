import 'package:nok_nok/models/store_delivery_time_slot.dart';

abstract class DeliveryTimeEvent {
}

class ReloadDeliveryTimeEvent extends DeliveryTimeEvent {
}

class PostOrderDeliveryTimeEvent extends DeliveryTimeEvent {

  // Public methods and properties

  final DeliveryTimeSlot timeSlot;

  PostOrderDeliveryTimeEvent(this.timeSlot);

}
