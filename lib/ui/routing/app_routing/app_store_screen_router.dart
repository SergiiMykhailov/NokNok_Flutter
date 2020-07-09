import 'package:flutter/cupertino.dart';
import 'package:nok_nok/data_access/repositories/base/store_repository.dart';
import 'package:nok_nok/ui/screens/store_screen/routing/store_screen_router.dart';

import '../base_router.dart';

class AppStoreScreenRouter extends StoreScreenRouter {

  // Overridden methods

  @override
  void navigateToBasket(BuildContext context, StoreRepository storeRepository) {
    Navigator.pushNamed(
      context,
      BaseRouter.Basket,
      arguments: storeRepository);
  }

}