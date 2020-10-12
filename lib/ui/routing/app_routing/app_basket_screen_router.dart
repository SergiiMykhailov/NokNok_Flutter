import 'package:flutter/cupertino.dart';
import 'package:nok_nok/data_access/repositories/base/store_repository.dart';
import 'package:nok_nok/ui/screens/basket_screen/routing/basket_router.dart';

import '../base_router.dart';

class AppBasketScreenRouter extends BasketScreenRouter {

  // Overridden methods

  @override
  void navigateBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  void navigateToDeliverySettings(BuildContext context, StoreRepository storeRepository) {
    Navigator.pushNamed(
      context,
      BaseRouter.Delivery,
      arguments: storeRepository);
  }

}