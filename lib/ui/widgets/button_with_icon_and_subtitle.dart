import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nok_nok/ui/theme/nok_nok_colors.dart';
import 'package:nok_nok/ui/theme/nok_nok_theme.dart';

const ButtonDimension = 24.0;

class ButtonWithIconAndSubtitle extends StatelessWidget {

  // Public methods and properties

  final ImageProvider icon;
  final String subtitle;
  final Color color;

  ButtonWithIconAndSubtitle({
    @required this.icon,
    @required this.subtitle,
    @required this.color,
    @required VoidCallback onPressed,
  })
    : _onPressed = onPressed,
      super() {
    assert(icon != null);
    assert(_onPressed != null);
  }

  // Overridden methods

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: Column(
        children: [
          Container(
            width: ButtonDimension,
            height: ButtonDimension,
            child: ImageIcon(
              icon,
              color: color
            ),
          ),
          SizedBox(height: 4,),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.caption.copyWith(
              fontSize: NokNokFonts.subtitle,
              color: NokNokColors.mainThemeColor),
          ),
        ],
      ),
      onPressed: _onPressed,
    );
  }

  // Internal fields

  final VoidCallback _onPressed;

}