import 'package:flutter/widgets.dart';
import 'package:nok_nok/data_access/repositories/base/store_repository.dart';
import 'package:nok_nok/ui/screens/delivery_screen/routing/delivery_screen_router.dart';

import '../base_router.dart';

class AppDeliveryScreenRouter extends DeliveryScreenRouter {

  // Overridden methods

  @override
  void navigateBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  void navigateToTimeSlotSelection(BuildContext context, StoreRepository storeRepository) {
    Navigator.pushNamed(
      context,
      BaseRouter.DeliveryTime,
      arguments: storeRepository);
  }

}