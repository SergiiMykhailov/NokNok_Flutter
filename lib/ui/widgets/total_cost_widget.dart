import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nok_nok/ui/utils/utils.dart';
import 'package:nok_nok/ui/widgets/action_button.dart';

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

    return ActionButton(
      title: buttonText,
      onPressed: _onPurchaseClicked,
    );
  }

  // Internal fields

  final double _totalCost;
  final VoidCallback _onPurchaseClicked;

}