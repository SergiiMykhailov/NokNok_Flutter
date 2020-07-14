import 'package:flutter/cupertino.dart';

abstract class BaseRouter {

  static const StoresList = 'storesList';
  static const Store = 'store';
  static const Root = '/';
  static const Basket = 'store/basket';
  static const Delivery = 'store/delivery';

  Route<dynamic> generateRoute(RouteSettings settings);

}