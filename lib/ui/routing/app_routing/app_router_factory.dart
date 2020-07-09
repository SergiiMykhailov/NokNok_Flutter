import 'package:nok_nok/ui/routing/app_routing/app_basket_screen_router.dart';
import 'package:nok_nok/ui/routing/app_routing/app_store_screen_router.dart';
import 'package:nok_nok/ui/routing/app_routing/app_stores_list_screen_router.dart';
import 'package:nok_nok/ui/routing/base_router.dart';
import 'package:nok_nok/ui/routing/app_routing/main_router.dart';
import 'package:nok_nok/ui/routing/router_factory.dart';
import 'package:nok_nok/ui/screens/basket_screen/routing/basket_router.dart';
import 'package:nok_nok/ui/screens/store_screen/routing/store_screen_router.dart';
import 'package:nok_nok/ui/screens/stores_list_screen/routing/stores_list_screen_router.dart';

class AppRouterFactory extends RouterFactory {

  // Overridden methods

  @override
  BaseRouter createMainRouter(RouterFactory routerFactory) {
    return MainRouter(routerFactory);
  }

  @override
  StoresListScreenRouter createStoresListRouter() {
    return AppStoresListScreenRouter();
  }

  @override
  StoreScreenRouter createStoreRouter() {
    return AppStoreScreenRouter();
  }

  @override
  BasketScreenRouter createBasketRouter() {
    return AppBasketScreenRouter();
  }

}