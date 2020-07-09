import 'package:nok_nok/data_access/repositories/base/store_repository.dart';
import 'package:nok_nok/ui/routing/base_router.dart';
import 'package:nok_nok/ui/routing/router_factory.dart';
import 'package:nok_nok/ui/screens/basket_screen/basket_screen.dart';
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
        return CupertinoPageRoute(builder: (_) => StoresListScreen(_rootRepository, _routerFactory.createStoresListRouter()));

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