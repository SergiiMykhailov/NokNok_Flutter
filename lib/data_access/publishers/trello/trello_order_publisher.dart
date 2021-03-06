import 'package:built_collection/built_collection.dart';
import 'package:nok_nok/data_access/publishers/base/order_publisher.dart';
import 'package:nok_nok/data_access/publishers/trello/trello_http_client.dart';
import 'package:nok_nok/models/basket.dart';
import 'package:nok_nok/models/store_delivery_time_slot.dart';

class TrelloOrderPublisher extends OrderPublisher {

  // Overridden methods

  @override
  Future<String> publishOrder(String dayOfWeek,
                              DeliveryTimeSlot timeSlot,
                              Basket basket,
                              String address,
                              String userName,
                              String userPhoneNumber) async {
    final deliveryTime = '${timeSlot.timeSlotStart} - ${timeSlot.timeSlotEnd}';
    final cardTitle = '$address. $dayOfWeek - $deliveryTime. $userName ($userPhoneNumber)';

    var checklistItems = List<String>();
    for (final basketItem in basket.items) {
      checklistItems.add(basketItem.toString());
    }

    final cardId = await TrelloHttpClient.createCard(cardTitle, BuiltList.from(checklistItems));
    return cardId;
  }

}