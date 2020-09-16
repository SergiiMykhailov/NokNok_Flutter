import 'package:flutter/cupertino.dart';
import 'package:nok_nok/ui/utils/utils.dart';

class StoreProductBase {

  // Public methods and properties

  static const KeyResolvedImageUrl = "resolvedImageUrl";

  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String resolvedImageUrl;
  final double price;

  StoreProductBase({@required this.id,
                    @required this.title,
                    @required this.description,
                    this.price,
                    this.imageUrl,
                    this.resolvedImageUrl});

  static StoreProductBase fromJSON(Map<dynamic, dynamic> json) {
    if (json == null) {
      return null;
    }

    final id = json[_KeyId];
    final title = json[_KeyTitle];
    final description = json[_KeyDescription];
    final imageUrl = json[_KeyImageUrl];
    final price = json[_KeyPrice];
    final resolvedImageUrl = json[KeyResolvedImageUrl];

    if (id != null &&
        title != null &&
        description != null &&
        imageUrl != null &&
        price != null) {
      var priceToAssign = price;

      if (price is int) {
        priceToAssign = price.toDouble();
      }

      return StoreProductBase(
        id: id,
        title: title,
        description: description.toString(),
        price: priceToAssign,
        imageUrl: imageUrl,
        resolvedImageUrl: resolvedImageUrl
      );
    }

    return null;
  }

  String toString() {
    final priceText = formatPrice(price);
    final result = '$title, ($description), $priceText';

    return result;
  }

  Map<String, dynamic> toJSON() {
    return {
      _KeyId : id,
      _KeyTitle :  title,
      _KeyDescription : description,
      _KeyImageUrl : imageUrl,
      KeyResolvedImageUrl : resolvedImageUrl,
      _KeyPrice : price
    };
  }

  // Internal fields

  static const _KeyId = "id";
  static const _KeyTitle = "title";
  static const _KeyDescription = "description";
  static const _KeyImageUrl = "imageUrl";
  static const _KeyPrice = "price";

}