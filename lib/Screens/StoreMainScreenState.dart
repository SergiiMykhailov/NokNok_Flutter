import 'StoreMainScreen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class StoreMainScreenState extends State<StoreMainScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Row(
          children: [
            Container(
              color: CupertinoColors.destructiveRed,
              padding: EdgeInsets.only(left: 8, right: 8),
              child:
                Center(
                  child: Text("Left column"),
                ),
            ),
            Expanded(
              child:
                Container(
                  color: CupertinoColors.activeGreen,
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child:
                    Center(
                      child: Text("Right column"),
                    ),
              ),
            )
          ],
        )
      )
    );
  }
}
