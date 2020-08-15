import 'package:flutter/widgets.dart';
import 'package:nok_nok/ui/screens/delivery_time_screen/routing/delivery_time_router.dart';

class AppDeliveryTimeScreenRouter extends DeliveryTimeScreenRouter {

  // Overridden methods

  @override
  void navigateBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  void navigateToOrderConfirmation(BuildContext context, String orderId) {
  }

}