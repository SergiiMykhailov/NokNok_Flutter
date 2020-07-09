import 'package:nok_nok/ui/routing/base_router.dart';
import 'package:nok_nok/ui/screens/stores_list_screen/routing/stores_list_screen_router.dart';

abstract class RouterFactory {
  BaseRouter createMainRouter(RouterFactory routerFactory);
  StoresListScreenRouter createStoresListRouter();
}