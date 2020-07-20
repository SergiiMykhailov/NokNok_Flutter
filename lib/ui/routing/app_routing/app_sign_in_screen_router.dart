import 'package:flutter/cupertino.dart';
import 'package:nok_nok/ui/screens/sign_in_screen/routing/sign_in_screen_router.dart';

import '../base_router.dart';

class AppSignInScreenRouter extends SignInScreenRouter {

  // Overridden methods

  @override
  void navigateToStore(BuildContext context) {
    Navigator.pushNamed(
      context,
      BaseRouter.Store,
      arguments: null);
  }

}