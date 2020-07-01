import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nok_nok/ui/theme/nok_nok_colors.dart';
import 'package:nok_nok/ui/theme/nok_nok_theme.dart';
import 'package:nok_nok/ui/utils/screen_utils.dart';
import 'package:nok_nok/ui/utils/utils.dart';

const ButtonHeight = 50.0;
const ButtonCornerRadius = ButtonHeight / 2;

class TotalCostWidget extends StatelessWidget {

  // Public methods and properties

  TotalCostWidget(
    this._totalCost,
    {VoidCallback onPurchaseClicked})
    : _onPurchaseClicked = onPurchaseClicked,
      super();

  // Overridden methods

  @override
  Widget build(BuildContext context) {
    final buttonText = "Purchase | ${formatPrice(_totalCost)}";

    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(CornerRadiusLarge),
          topRight: Radius.circular(CornerRadiusLarge)),
        child: Container(
          color: CupertinoColors.white,
          child: Column(
            children: [
              Expanded(child: Container()),
              Container(
                height: ButtonHeight,
                child: Row(
                  children: [
                    SizedBox(width: _ButtonInsets),
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(ButtonCornerRadius)),
                      child: CupertinoButton(
                        color: NokNokColors.buttonColor,
                        child: Center(
                          child: Text(
                            buttonText,
                            style: Theme.of(context).textTheme.caption.copyWith(
                              fontSize: NokNokFonts.caption,
                              color: CupertinoColors.white),
                          ),
                        ),
                        onPressed: () {
                          if (_onPurchaseClicked != null) {
                            _onPurchaseClicked();
                          }
                        },
                      ),
                    ),
                    SizedBox(width: _ButtonInsets)
                  ],
                )
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }

  // Internal fields

  final double _totalCost;
  final VoidCallback _onPurchaseClicked;

  static const _ButtonInsets = 50.0;

}