import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildLoadingWidget(String message) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(message),
      CircularProgressIndicator(),
    ],
  );
}

Widget buildInvalidStateWidget() {
  return Center(
    child: Text("Invalid screen state"),
  );
}