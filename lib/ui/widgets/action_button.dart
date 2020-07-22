import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nok_nok/ui/theme/nok_nok_colors.dart';
import 'package:nok_nok/ui/theme/nok_nok_theme.dart';
import 'package:nok_nok/ui/utils/screen_utils.dart';

const ButtonHeight = 50.0;
const ButtonCornerRadius = ButtonHeight / 2;

class ActionButton extends StatelessWidget {

  // Public methods and properties

  ActionButton({@required String title,
                @required VoidCallback onPressed})
    : _title = title,
      _onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  _title,
                  style: Theme.of(context).textTheme.caption.copyWith(
                    fontSize: NokNokFonts.caption,
                    color: CupertinoColors.white),
                ),
              ),
              onPressed: () {
                if (_onPressed != null) {
                  _onPressed();
                }
              },
            ),
          ),
          SizedBox(width: _ButtonInsets)
        ],
      )
    );
  }

  // Internal fields

  final String _title;
  final VoidCallback _onPressed;

  static const _ButtonInsets = 50.0;

}