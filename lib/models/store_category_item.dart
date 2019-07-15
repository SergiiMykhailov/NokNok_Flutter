import 'package:flutter/cupertino.dart';

class StoreCategoryItem {

  // Public methods and properties

  final String id;
  final String iconPath;
  final String title;

  StoreCategoryItem({@required String id,
                     @required String iconPath,
                     @required String title})
    : this.id = id,
      this.iconPath = iconPath,
      this.title = title;

}