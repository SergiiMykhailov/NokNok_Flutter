import 'package:flutter/widgets.dart';
import 'package:nok_nok/ui/screens/delivery_screen/routing/delivery_screen_router.dart';

class AppDeliveryScreenRouter extends DeliveryScreenRouter {

  // Overridden methods

  @override
  void navigateBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  void navigateToPayment(BuildContext context) {
    // TODO: implement navigateToPayment
  }

}