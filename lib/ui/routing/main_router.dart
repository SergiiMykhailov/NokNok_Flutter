import 'package:nok_nok/ui/routing/base_router.dart';
import 'package:nok_nok/ui/screens/store_screen/store_screen.dart';
import 'package:nok_nok/ui/screens/stores_list_screen/stores_list_screen.dart';

import 'package:nok_nok/data_access/repositories/base/root_repository.dart';
import 'package:nok_nok/data_access/repositories/root_repository_factory.dart';

import 'package:flutter/cupertino.dart';

class MainRouter extends BaseRouter {

  @override
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case BaseRouter.Root:
        return CupertinoPageRoute(builder: (_) => StoresListScreen(rootRepository: _rootRepository));

      case BaseRouter.StoresList:
        return CupertinoPageRoute(builder: (_) => StoresListScreen(rootRepository: _rootRepository));

      case BaseRouter.Store:
        return CupertinoPageRoute(builder: (_) => StoreScreen());

      default:
        return CupertinoPageRoute(builder: (_) {
          return Center(
            child: Text('No route defined for ${settings.name}'),
          );
        });
    }
  }

  static final RootRepository _rootRepository = createRootRepository();

}