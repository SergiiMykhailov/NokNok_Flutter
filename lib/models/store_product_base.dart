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

    final title = json[_KeyTitle];
    final description = json[_KeyDescription];
    final imageUrl = json[_KeyImageUrl];
    final price = json[_KeyPrice];

    if (title != null &&
        description != null &&
        imageUrl != null &&
        price != null) {
      return StoreProductBase(
        id: '',
        title: title,
        description: description,
        price: price,
        imageUrl: imageUrl
      );
    }

    return null;
  }

  // Internal fields

  static const _KeyTitle = "title";
  static const _KeyDescription = "description";
  static const _KeyImageUrl = "imageUrl";
  static const _KeyPrice = "price";

}