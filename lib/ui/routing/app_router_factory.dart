import 'package:nok_nok/ui/routing/app_stores_list_screen_router.dart';
import 'package:nok_nok/ui/routing/base_router.dart';
import 'package:nok_nok/ui/routing/main_router.dart';
import 'package:nok_nok/ui/routing/router_factory.dart';
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

}