import 'package:flutter/cupertino.dart';

abstract class BaseRouter {

  static const StoresList = 'storesList';
  static const Store = 'store';
  static const Root = '/';

  Route<dynamic> generateRoute(RouteSettings settings);

}