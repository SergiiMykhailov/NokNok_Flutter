import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const DefaultVerticalPadding = 8.0;

Widget buildLoadingWidget(String message) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        padding: EdgeInsets.only(top: DefaultVerticalPadding, bottom: DefaultVerticalPadding),
        child: Text(message),
      ),
      Container(
        padding: EdgeInsets.only(top: DefaultVerticalPadding, bottom: DefaultVerticalPadding),
        child: CircularProgressIndicator(),
      ),
    ],
  );
}

Widget buildInvalidStateWidget() {
  return Center(
    child: Text("Invalid screen state"),
  );
}