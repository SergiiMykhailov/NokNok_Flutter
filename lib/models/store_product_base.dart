import 'package:flutter/cupertino.dart';

class StoreProductBase {

  // Public methods and properties

  final String id;
  final String title;
  final String description;

  StoreProductBase({@required String id,
                    @required String title,
                    @required String description})
    : this.id = id,
      this.title = title,
      this.description = description;

}