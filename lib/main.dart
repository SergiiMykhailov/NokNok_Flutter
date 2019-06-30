import 'package:flutter/cupertino.dart';
import 'package:nok_nok/ui/screens/store_screen/store_screen.dart';

void main() => runApp(NokNokApp());

class NokNokApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Nok Nok',
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.activeBlue
      ),
      home: StoreScreen(),
    );
  }

}
