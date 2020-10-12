
import 'package:flutter/cupertino.dart';
import 'package:nok_nok/ui/localization/nok_nok_localization.dart';

const int DayOfWeekMondayIndex = 1;
const int DayOfWeekTuesdayIndex = DayOfWeekMondayIndex + 1;
const int DayOfWeekWednesdayIndex = DayOfWeekTuesdayIndex + 1;
const int DayOfWeekThursdayIndex = DayOfWeekWednesdayIndex + 1;
const int DayOfWeekFridayIndex = DayOfWeekThursdayIndex + 1;
const int DayOfWeekSaturdayIndex = DayOfWeekFridayIndex + 1;
const int DayOfWeekSundayIndex = DayOfWeekSaturdayIndex + 1;

String titleForDayOfWeek(BuildContext context, int dayOfWeek) {
  if (dayOfWeek == DayOfWeekMondayIndex) {
    return translate(context, "Monday");
  }
  if (dayOfWeek == DayOfWeekTuesdayIndex) {
    return translate(context, "Tuesday");
  }
  if (dayOfWeek == DayOfWeekWednesdayIndex) {
    return translate(context, "Wednesday");
  }
  if (dayOfWeek == DayOfWeekThursdayIndex) {
    return translate(context, "Thursday");
  }
  if (dayOfWeek == DayOfWeekFridayIndex) {
    return translate(context, "Friday");
  }
  if (dayOfWeek == DayOfWeekSaturdayIndex) {
    return translate(context, "Saturday");
  }
  if (dayOfWeek == DayOfWeekSundayIndex) {
    return translate(context, "Sunday");
  }

  return '';
}

String formatPrice(double price) {
  if (price == null) {
    return '';
  }

  String result = price.toStringAsFixed(2);
  result += " ₴";

  return result;
}