import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nok_nok/ui/theme/nok_nok_colors.dart';
import 'package:nok_nok/ui/theme/nok_nok_images.dart';
import 'package:nok_nok/ui/theme/nok_nok_theme.dart';
import 'package:nok_nok/ui/utils/screen_utils.dart';

// ignore: must_be_immutable
class BasketButton extends StatefulWidget {

  // Public methods and properties

  int get itemsCount {
    return _state != null ? _state.itemsCount : -1;
  }
  set itemsCount(int updatedValue) {
    if (_state != null) {
      _state.itemsCount = updatedValue;
    }
  }

  VoidCallback get onPressed {
    return _state != null ? _state.onPressed : null;
  }
  set onPressed(VoidCallback callback) {
    if (_state != null) {
      _state.onPressed = callback;
    }
  }

  // Overridden methods

  @override
  State<StatefulWidget> createState() {
    _state = _BasketButtonState();
    return _state;
  }

  // Internal fields

  _BasketButtonState _state;

}

class _BasketButtonState extends State<BasketButton> {

  // Public methods and properties

  int get itemsCount {
    return _itemsCount;
  }
  set itemsCount(int updatedValue) {
    setState(() {
      _itemsCount = updatedValue;
    });
  }

  VoidCallback onPressed;

  // Overridden methods

  @override
  Widget build(BuildContext context) {
    final labelText = _itemsCount.toString();

    var widgets = List<Widget>();

    final basketButton = Center(
      child: Container(
        width: DefaultButtonSize,
        height: DefaultButtonSize,
        child: FittedBox(
          child: CupertinoButton(
            padding: EdgeInsets.all(0),
            child: FittedBox(
              child: ImageIcon(NokNokImages.basket,
                color: NokNokColors.mainThemeColor),
            ),
            onPressed: () {
              if (onPressed != null) {
                onPressed();
              }
            },
          ),
        ),
      ),
    );

    final itemsCountWidget = Align(
      alignment: Alignment.topRight,
      child: Container(
        width: 18,
        height: 18,
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(9)
          ),
          child: Container(
            color: NokNokColors.buttonColor,
            child: Center(
              child: Text(
                labelText,
                style: Theme.of(context).textTheme.caption.copyWith(
                  fontSize: NokNokFonts.subtitle,
                  color: CupertinoColors.white),
              ),
            )
          ),
        ),
      ),
    );

    widgets.add(basketButton);
    if (_itemsCount > 0) {
      widgets.add(itemsCountWidget);
    }

    return Container(
      width: DefaultButtonSize,
      height: DefaultButtonSize,
      child: Stack(
        children: widgets,
      ),
    );
  }

  // Internal fields

  int _itemsCount = 0;

}