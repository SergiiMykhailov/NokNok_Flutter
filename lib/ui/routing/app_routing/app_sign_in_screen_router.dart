import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:nok_nok/data_access/repositories/base/root_repository.dart';
import 'package:nok_nok/data_access/repositories/base/store_repository.dart';
import 'package:nok_nok/ui/screens/sign_in_screen/routing/sign_in_screen_router.dart';

import '../base_router.dart';

class AppSignInScreenRouter extends SignInScreenRouter {

  AppSignInScreenRouter(this._rootRepository);

  // Overridden methods

  @override
  void navigateToStore(BuildContext context) {
    _rootRepository.fetchAllStores()
      .then((BuiltList<StoreRepository> stores) {
        if (stores.isNotEmpty) {
          Navigator.pushNamed(
            context,
            BaseRouter.Store,
            arguments: stores.first);
        }
    });
  }

  // Internal fields

  final RootRepository _rootRepository;

}