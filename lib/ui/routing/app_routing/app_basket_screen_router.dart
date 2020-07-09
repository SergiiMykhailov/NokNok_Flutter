import 'package:flutter/cupertino.dart';
import 'package:nok_nok/ui/screens/basket_screen/routing/basket_router.dart';

class AppBasketScreenRouter extends BasketScreenRouter {

  // Overridden methods

  @override
  void navigateBack(BuildContext context) {
    Navigator.pop(context);
  }

}