
String formatPrice(double price) {
  if (price == null) {
    return '';
  }

  String result = price.toStringAsFixed(2);
  result += " ₴";

  return result;
}