import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const DefaultVerticalPadding = 8.0;
const DefaultHorizontalPadding = 8.0;
const DefaultCornerRadius = 8.0;

Widget buildLoadingWidget(BuildContext context, String message) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // Text
      Container(
        padding: EdgeInsets.only(top: DefaultVerticalPadding, bottom: DefaultVerticalPadding),
        child: Text(message,
          style: Theme.of(context).textTheme.subtitle),
      ),
      // Spinner
      Container(
        padding: EdgeInsets.only(top: DefaultVerticalPadding, bottom: DefaultVerticalPadding),
        child: CupertinoActivityIndicator(),
      ),
    ],
  );
}

Widget buildInvalidStateWidget() {
  return Center(
    child: Text("Invalid screen state"),
  );
}

String formatPrice(double price) {
  String result = price.toStringAsFixed(2);
  result += " ₴";

  return result;
}