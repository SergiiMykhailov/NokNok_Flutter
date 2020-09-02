import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nok_nok/ui/localization/nok_nok_localization.dart';
import 'package:nok_nok/ui/screens/order_confirmation/routing/order_confirmation_router.dart';
import 'package:nok_nok/ui/theme/nok_nok_colors.dart';
import 'package:nok_nok/ui/theme/nok_nok_theme.dart';
import 'package:nok_nok/ui/utils/screen_utils.dart';
import 'package:nok_nok/ui/widgets/action_button.dart';

class OrderConfirmationScreen extends StatelessWidget {

  // Public methods and properties

  final String orderId;
  final OrderConfirmationScreenRouter router;

  OrderConfirmationScreen(this.orderId, this.router);

  // Overridden methods

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.white,
      child: SafeArea(
        child: buildScreenWidget(
          buildContext: context,
          headerHeight: DefaultFooterHeight,
          footerHeight: DefaultHeaderHeight,
          buildHeaderCallback: (BuildContext context) {
            return _buildHeader(context);
          },
          buildBodyCallback: (BuildContext context) {
            return _buildBody(context);
          },
          buildFooterCallback: (BuildContext context) {
            return _buildFooter(context);
          }
        )
      ),
    );
  }

  // Internal methods

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 34,),
            Text(
              translate(context, "Order details"),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption.copyWith(
                fontSize: NokNokFonts.caption,
                fontWeight: FontWeight.bold,
                color: NokNokColors.mainThemeColor),
            )
          ],
        )
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CupertinoButton(
          child: Text(
            translate(context, "Order ID") + ': $orderId',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption.copyWith(
              fontSize: NokNokFonts.caption,
              color: NokNokColors.mainThemeColor)
          ),
          onPressed: () {

          },
        )
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ActionButton(
              title: translate(context, "To main screen"),
              onPressed: () {
                router.navigateToMain(context);
              }
            )
          ],
        )
      ],
    );
  }

}