import 'package:flutter/cupertino.dart';

abstract class BaseRouter {

  static const StoresList = 'storesList';
  static const Store = 'store';
  static const Root = '/';
  static const Basket = 'basket';

  Route<dynamic> generateRoute(RouteSettings settings);

}