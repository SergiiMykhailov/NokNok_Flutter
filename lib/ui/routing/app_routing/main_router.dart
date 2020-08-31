import 'package:nok_nok/data_access/repositories/base/store_repository.dart';
import 'package:nok_nok/ui/routing/base_router.dart';
import 'package:nok_nok/ui/routing/router_factory.dart';
import 'package:nok_nok/ui/screens/basket_screen/basket_screen.dart';
import 'package:nok_nok/ui/screens/delivery_screen/delivery_screen.dart';
import 'package:nok_nok/ui/screens/delivery_time_screen/delivery_time_screen.dart';
import 'package:nok_nok/ui/screens/order_confirmation/order_confirmation_screen.dart';
import 'package:nok_nok/ui/screens/sign_in_screen/sign_in_screen.dart';
import 'package:nok_nok/ui/screens/store_screen/store_screen.dart';
import 'package:nok_nok/ui/screens/stores_list_screen/stores_list_screen.dart';

import 'package:nok_nok/data_access/repositories/base/root_repository.dart';
import 'package:nok_nok/data_access/repositories/root_repository_factory.dart';

import 'package:flutter/cupertino.dart';

class MainRouter extends BaseRouter {

  MainRouter(this._routerFactory);

  // Overridden methods

  @override
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case BaseRouter.Root:
        return CupertinoPageRoute(builder: (_) => SignInScreen(_routerFactory.createSignInRouter(_rootRepository)));

      case BaseRouter.StoresList:
        return CupertinoPageRoute(builder: (_) => StoresListScreen(_rootRepository, _routerFactory.createStoresListRouter()));

      case BaseRouter.Store:
        final storeRepository = settings.arguments;
        assert(storeRepository != null && storeRepository is StoreRepository,
               "Store repository is not specified while trying to navigate to store");
        return CupertinoPageRoute(builder: (_) => StoreScreen(storeRepository, _routerFactory.createStoreRouter()));

      case BaseRouter.Basket:
        final storeRepository = settings.arguments;
        assert(storeRepository != null && storeRepository is StoreRepository,
               "Store repository is not specified while trying to navigate to basket");
        return CupertinoPageRoute(builder: (_) => BasketScreen(storeRepository, _routerFactory.createBasketRouter()));

      case BaseRouter.Delivery:
        final storeRepository = settings.arguments;
        assert(storeRepository != null && storeRepository is StoreRepository,
               "Store repository is not specified while trying to navigate to delivery");
        return CupertinoPageRoute(builder: (_) => DeliveryScreen(storeRepository, _routerFactory.createDeliveryRouter()));

      case BaseRouter.DeliveryTime:
        assert(settings.arguments is List<dynamic>);
        final List<dynamic> arguments = settings.arguments;
        assert(arguments.length == 2);

        final address = arguments[0];
        final storeRepository = arguments[1];
        assert(address != null &&
               address is String &&
               storeRepository != null &&
               storeRepository is StoreRepository,
               "Store repository is not specified while trying to navigate to delivery time");
        return CupertinoPageRoute(builder: (_) => DeliveryTimeScreen(storeRepository, address, _routerFactory.createDeliveryTimeRouter()));

      case BaseRouter.OrderConfirmation:
        assert(settings.arguments is String);
        final String orderId = settings.arguments;
        return CupertinoPageRoute(builder: (_) => OrderConfirmationScreen(orderId, _routerFactory.createOrderConfirmationRouter()));

      default:
        return CupertinoPageRoute(builder: (_) {
          return Center(
            child: Text('No route defined for ${settings.name}'),
          );
        });
    }
  }

  static final RootRepository _rootRepository = createRootRepository();
  final RouterFactory _routerFactory;

}