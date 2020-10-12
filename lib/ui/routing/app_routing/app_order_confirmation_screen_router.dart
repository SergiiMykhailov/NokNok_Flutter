import 'package:flutter/cupertino.dart';
import 'package:nok_nok/ui/screens/order_confirmation/routing/order_confirmation_router.dart';

class AppOrderConfirmationScreenRouter extends OrderConfirmationScreenRouter {

  // Overridden methods

  @override
  void navigateToMain(BuildContext context) {
    var remainingScreensCount = 5;

    Navigator.of(context).popUntil((route) {
      remainingScreensCount--;
      return remainingScreensCount == 0;
    });
  }

}