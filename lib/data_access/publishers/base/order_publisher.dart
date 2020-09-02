// Interface which declares all methods for working with single store.
import 'package:nok_nok/models/basket.dart';
import 'package:nok_nok/models/store_delivery_time_slot.dart';

abstract class OrderPublisher {

  // Posts order and returns order ID.
  Future<String> publishOrder(String dayOfWeek,
                              DeliveryTimeSlot timeSlot,
                              Basket basket,
                              String address,
                              String userName,
                              String userPhoneNumber);

}