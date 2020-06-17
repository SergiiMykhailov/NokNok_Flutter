import 'package:nok_nok/ui/routing/base_router.dart';
import 'package:nok_nok/ui/routing/router_factory.dart';

import 'package:flutter/cupertino.dart';

void main() => runApp(NokNokApp());

class NokNokApp extends StatelessWidget {

  // Overridden methods

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Nok Nok',
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.activeBlue,
      ),
      onGenerateRoute: _router.generateRoute,
    );
  }

  // Internal fields

  final BaseRouter _router = createRouter();

}
