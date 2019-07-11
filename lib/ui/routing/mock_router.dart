import 'package:nok_nok/ui/routing/base_router.dart';
import 'package:flutter/cupertino.dart';

class MockRouter extends BaseRouter {

  @override
  Route<dynamic> generateRoute(RouteSettings settings) {
    return CupertinoPageRoute(builder: (_) {
      return Center(
        child: Text('Mock route'),
      );
    });
  }

}