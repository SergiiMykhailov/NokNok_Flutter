
const int DayOfWeekMondayIndex = 1;
const int DayOfWeekTuesdayIndex = DayOfWeekMondayIndex + 1;
const int DayOfWeekWednesdayIndex = DayOfWeekTuesdayIndex + 1;
const int DayOfWeekThursdayIndex = DayOfWeekWednesdayIndex + 1;
const int DayOfWeekFridayIndex = DayOfWeekThursdayIndex + 1;
const int DayOfWeekSaturdayIndex = DayOfWeekFridayIndex + 1;
const int DayOfWeekSundayIndex = DayOfWeekSaturdayIndex + 1;

String titleForDayOfWeek(int dayOfWeek) {
  if (dayOfWeek == DayOfWeekMondayIndex) {
    return 'Monday';
  }
  if (dayOfWeek == DayOfWeekTuesdayIndex) {
    return 'Tuesday';
  }
  if (dayOfWeek == DayOfWeekWednesdayIndex) {
    return 'Wednesday';
  }
  if (dayOfWeek == DayOfWeekThursdayIndex) {
    return 'Thursday';
  }
  if (dayOfWeek == DayOfWeekFridayIndex) {
    return 'Friday';
  }
  if (dayOfWeek == DayOfWeekSaturdayIndex) {
    return 'Saturday';
  }
  if (dayOfWeek == DayOfWeekSundayIndex) {
    return 'Sunday';
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