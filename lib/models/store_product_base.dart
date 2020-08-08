import 'package:flutter/cupertino.dart';

class StoreProductBase {

  // Public methods and properties

  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;

  StoreProductBase({@required this.id,
                    @required this.title,
                    @required this.description,
                    this.price,
                    this.imageUrl});

  static StoreProductBase fromJSON(Map<dynamic, dynamic> json) {
    if (json == null) {
      return null;
    }

    final id = json[_KeyId];
    final title = json[_KeyTitle];
    final description = json[_KeyDescription];
    final imageUrl = json[_KeyImageUrl];
    final price = json[_KeyPrice];

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
        imageUrl: imageUrl
      );
    }

    return null;
  }

  // Internal fields

  static const _KeyId = "id";
  static const _KeyTitle = "title";
  static const _KeyDescription = "description";
  static const _KeyImageUrl = "imageUrl";
  static const _KeyPrice = "price";

}