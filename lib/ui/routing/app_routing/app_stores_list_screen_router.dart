import 'package:flutter/cupertino.dart';
import 'package:nok_nok/data_access/repositories/base/store_repository.dart';
import 'package:nok_nok/ui/screens/stores_list_screen/routing/stores_list_screen_router.dart';

import '../base_router.dart';

class AppStoresListScreenRouter extends StoresListScreenRouter {

  // Overridden methods

  @override
  void navigateToStore(BuildContext context, StoreRepository storeRepository) {
    Navigator.pushNamed(
      context,
      BaseRouter.Store,
      arguments: storeRepository);
  }}