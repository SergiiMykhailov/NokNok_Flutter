import 'package:nok_nok/data_access/repositories/base/root_repository.dart';
import 'package:nok_nok/ui/routing/base_router.dart';
import 'package:nok_nok/ui/screens/basket_screen/routing/basket_router.dart';
import 'package:nok_nok/ui/screens/delivery_screen/routing/delivery_screen_router.dart';
import 'package:nok_nok/ui/screens/delivery_time_screen/routing/delivery_time_router.dart';
import 'package:nok_nok/ui/screens/order_confirmation/routing/order_confirmation_router.dart';
import 'package:nok_nok/ui/screens/sign_in_screen/routing/sign_in_screen_router.dart';
import 'package:nok_nok/ui/screens/store_screen/routing/store_screen_router.dart';
import 'package:nok_nok/ui/screens/stores_list_screen/routing/stores_list_screen_router.dart';

abstract class RouterFactory {

  BaseRouter createMainRouter(RouterFactory routerFactory);
  SignInScreenRouter createSignInRouter(RootRepository rootRepository);
  StoresListScreenRouter createStoresListRouter();
  StoreScreenRouter createStoreRouter();
  BasketScreenRouter createBasketRouter();
  DeliveryScreenRouter createDeliveryRouter();
  DeliveryTimeScreenRouter createDeliveryTimeRouter();
  OrderConfirmationScreenRouter createOrderConfirmationRouter();

}