import 'package:flutter/cupertino.dart';

abstract class BaseRouter {

  static const StoresList = 'storesList';
  static const Store = 'store';
  static const Root = '/';
  static const Basket = 'store/basket';
  static const Delivery = 'store/delivery';
  static const DeliveryTime = 'store/delivery/time';
  static const OrderConfirmation = 'store/orderConfirmation';

  Route<dynamic> generateRoute(RouteSettings settings);

}