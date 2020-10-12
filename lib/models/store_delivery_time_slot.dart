import 'package:flutter/cupertino.dart';

class DeliveryTimeSlot {

  // Public methods and properties

  int dayOfWeek;
  String address;
  String timeSlotStart;
  String timeSlotEnd;

  DeliveryTimeSlot({@required int dayOfWeek,
                    @required String address,
                    @required String timeSlotStart,
                    @required String timeSlotEnd})
    : dayOfWeek = dayOfWeek
    , address = address
    , timeSlotStart = timeSlotStart
    , timeSlotEnd = timeSlotEnd;

  static DeliveryTimeSlot fromJSON(Map<dynamic, dynamic> json) {
    if (json == null) {
      return null;
    }

    final dayOfWeek = json[_KeyDayOfWeek];
    final address = json[_KeyAddress];
    final timeSlotStart = json[_KeyTimeSlotStart];
    final timeSlotEnd = json[_KeyTimeSlotEnd];

    if (address != null &&
        address is String &&
        timeSlotStart != null &&
        timeSlotStart is String &&
        timeSlotEnd != null &&
        timeSlotEnd is String &&
        dayOfWeek != null &&
        dayOfWeek is int) {
      return DeliveryTimeSlot(dayOfWeek: dayOfWeek,
                              address: address,
                              timeSlotStart: timeSlotStart,
                              timeSlotEnd: timeSlotEnd);
    }

    return null;
  }

  // Internal fields

  static const _KeyDayOfWeek = 'dayOfWeek';
  static const _KeyAddress = 'address';
  static const _KeyTimeSlotStart = 'from';
  static const _KeyTimeSlotEnd = 'to';
}