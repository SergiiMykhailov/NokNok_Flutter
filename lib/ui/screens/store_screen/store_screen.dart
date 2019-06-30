import 'package:flutter/cupertino.dart';

class StoreScreen extends StatefulWidget {

  StoreScreen({Key key})
   : super(key: key);

  @override
  _StoreScreenState createState() => _StoreScreenState();

}

class _StoreScreenState extends State<StoreScreen> {
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
                color: CupertinoColors.activeBlue,
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
