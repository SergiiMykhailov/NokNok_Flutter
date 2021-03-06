import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nok_nok/ui/theme/nok_nok_colors.dart';

typedef Widget BuildScreenSectionCallback(BuildContext context);

const CornerRadiusLarge = 15.0;
const HeaderFirstRowOffset = 5.0;
const FooterFirstRowOffset = 11.0;

const DefaultVerticalPadding = 8.0;
const DefaultHorizontalPadding = 8.0;
const DefaultCornerRadius = 8.0;

const DefaultHeaderHeight = 130.0;
const DefaultFooterHeight = 95.0;
const DefaultBodyHorizontalInset = 10.0;

const DefaultButtonSize = 44.0;

const DefaultAnimationDuration = 500; // milliseconds

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

Widget buildScreenWidget({@required BuildContext buildContext,
                          @required double headerHeight,
                          @required double footerHeight,
                          @required BuildScreenSectionCallback buildHeaderCallback,
                          @required BuildScreenSectionCallback buildBodyCallback,
                          @required BuildScreenSectionCallback buildFooterCallback}) {
  var screenElements = List<Widget>();

  if (buildHeaderCallback != null) {
    screenElements.add(ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(CornerRadiusLarge),
        bottomRight: Radius.circular(CornerRadiusLarge)
      ),
      child: Container(
        color: CupertinoColors.white,
        height: headerHeight,
        child: Column(
          children: [
            SizedBox(height: HeaderFirstRowOffset),
            Container(
              child: buildHeaderCallback(buildContext),
            )
          ],
        )
      )
    ));
  }

  if (buildBodyCallback != null) {
    screenElements.add(Expanded(
      child: buildBodyCallback(buildContext)
    ));
  }

  if (buildFooterCallback != null) {
    screenElements.add(ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(CornerRadiusLarge),
        topRight: Radius.circular(CornerRadiusLarge)
      ),
      child: Container(
        color: CupertinoColors.white,
        height: footerHeight,
        child: Column(
          children: [
            SizedBox(height: FooterFirstRowOffset),
            Container(
              child: buildFooterCallback(buildContext),
            )
          ],
        )
      )
    ));
  }

  return Container(
    color: NokNokColors.backgroundColor,
    child: Column (
      children: screenElements
    )
  );
}