import 'package:nok_nok/ui/localization/localization_configurator.dart';
import 'package:nok_nok/ui/routing/app_routing/app_router_factory.dart';
import 'package:nok_nok/ui/routing/base_router.dart';
import 'package:nok_nok/ui/routing/router_factory.dart';

import 'package:flutter/cupertino.dart';

void main() {
  runApp(NokNokApp());
}

// ignore: must_be_immutable
class NokNokApp extends StatelessWidget {

  // Overridden methods

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (_routerFactory == null) {
      _routerFactory = AppRouterFactory();
      _router = _routerFactory.createMainRouter(_routerFactory);
    }

    return CupertinoApp(
      title: 'Nok Nok',
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.activeBlue,
      ),
      onGenerateRoute: (RouteSettings settings) {
        return _router.generateRoute(settings);
      },
      supportedLocales: LocalizationConfigurator.supportedLocales,
      localizationsDelegates: LocalizationConfigurator.localizationDelegates,
      localeListResolutionCallback: (requestedLocales, supportedLocales) {
        return LocalizationConfigurator.resolveLocale(requestedLocales, supportedLocales);
      },
      debugShowCheckedModeBanner: false,
    );
  }

  // Internal fields

  RouterFactory _routerFactory;
  BaseRouter _router;

}
