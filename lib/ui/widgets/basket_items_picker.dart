import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nok_nok/ui/theme/nok_nok_colors.dart';
import 'package:nok_nok/ui/theme/nok_nok_theme.dart';

class BasketItemsPickerWidget extends StatefulWidget {

  // Public methods and properties

  static const PreferredWidth = 108.0;
  static const PreferredHeight = 36.0;

  int get itemsCount {
    return _state != null ? _state.itemsCount : -1;
  }
  set itemsCount(int updatedValue) {
    if (_state != null) {
      _state.itemsCount = updatedValue;
    }
  }

  BasketItemsPickerWidget(
    this._itemsCount,
    this._onAppendButtonPressed,
    this._onRemoveButtonPressed);

  // Overridden methods

  @override
  State<StatefulWidget> createState() {
    _state = _BasketItemsPickerWidgetState(
      _itemsCount,
      _onAppendButtonPressed,
      _onRemoveButtonPressed);
    return _state;
  }

  // Internal fields

  _BasketItemsPickerWidgetState _state;
  int _itemsCount;
  VoidCallback _onAppendButtonPressed;
  VoidCallback _onRemoveButtonPressed;

}

class _BasketItemsPickerWidgetState extends State<BasketItemsPickerWidget> {

  // Public methods and properties

  int get itemsCount {
    return _itemsCount;
  }
  set itemsCount(int updatedValue) {
    setState(() {
      _itemsCount = updatedValue;
    });
  }

  _BasketItemsPickerWidgetState(
    this._itemsCount,
    this._onAppendButtonPressed,
    this._onRemoveButtonPressed);

  // Overridden methods

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(_ButtonCornerRadius)),
      child: Container(
          color: NokNokColors.buttonColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildPickerButton('-', _onRemoveButtonPressed),
              Container(
                color: CupertinoColors.white,
                width: _SegmentWidth,
                height: _SegmentHeight,
                child: Center(
                  child: Text(
                    '$_itemsCount',
                    style: Theme.of(context).textTheme.caption.copyWith(
                        fontSize: NokNokFonts.caption,
                        color: NokNokColors.mainThemeColor),
                  ),
                ),
              ),
              _buildPickerButton('+', _onAppendButtonPressed)
            ],
          )),
    );
  }

  Widget _buildPickerButton(String title, VoidCallback onPressed) {
    return Container(
      width: _SegmentWidth,
      height: _SegmentHeight,
      child: CupertinoButton(
        padding: EdgeInsets.all(0.0),
        child: Container(
          child: Text(
            title,
            style: Theme.of(context).textTheme.caption.copyWith(
              fontSize: NokNokFonts.productPrice,
              color: CupertinoColors.white),
          ),
        ),
        onPressed: () {
          if (onPressed != null) {
            onPressed();
          }
        },
      ),
    );
  }

  // Internal fields

  int _itemsCount = 0;
  VoidCallback _onAppendButtonPressed;
  VoidCallback _onRemoveButtonPressed;

  static const _ButtonCornerRadius = 6.0;
  static const _SegmentWidth = 36.0;
  static const _SegmentHeight = 34.0;

}