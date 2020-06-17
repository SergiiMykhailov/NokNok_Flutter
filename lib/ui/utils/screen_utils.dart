import 'package:flutter/cupertino.dart';
import 'package:nok_nok/ui/theme/nok_nok_colors.dart';

typedef Widget BuildScreenSectionCallback(BuildContext context);

const CornerRadiusLarge = 15.0;
const HeaderFirstRowOffset = 5.0;
const FooterFirstRowOffset = 11.0;

Widget buildScreenWidget({@required BuildContext buildContext,
                          @required double headerHeight,
                          @required double footerHeight,
                          @required BuildScreenSectionCallback buildHeaderCallback,
                          @required BuildScreenSectionCallback buildBodyCallback,
                          @required BuildScreenSectionCallback buildFooterCallback}) {
  assert(buildHeaderCallback != null);
  assert(buildBodyCallback != null);
  assert(buildFooterCallback != null);

  return Container(
    color: NokNokColors.backgroundColor,
    child: Column (
      children: [

        // Header with content

        ClipRRect(
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
        ),

        // Body

        Expanded(
          child: buildBodyCallback(buildContext)
        ),

        // Footer

        ClipRRect(
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
        ),
      ],
    )
  );
}