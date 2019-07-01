import 'package:flutter/cupertino.dart';

class StoreCategoriesListWidget extends StatefulWidget {

    StoreCategoriesListWidget({Key key})
        : super(key: key);

    @override
    _StoreCategoriesListWidgetState createState() => _StoreCategoriesListWidgetState();

}

class _StoreCategoriesListWidgetState extends State<StoreCategoriesListWidget> {
    @override
    Widget build(BuildContext context) {
        return ListView.builder(
            itemBuilder: (context, itemIndex) {
            },
        );
    }
}