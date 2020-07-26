import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nok_nok/ui/theme/nok_nok_colors.dart';
import 'package:nok_nok/ui/theme/nok_nok_theme.dart';
import 'package:nok_nok/ui/utils/screen_utils.dart';

// ignore: must_be_immutable
class NokNokTextField extends StatelessWidget {

  // Public methods and properties

  NokNokTextField({@required bool supportsTextInput,
                   @required String placeholderOrTitle,
                   @required ImageProvider image,
                   VoidCallback onPressed,
                   List<TextInputFormatter> formatters,
                   FocusNode focusNode,
                   TextInputType keyboardType = TextInputType.text})
    : _supportsTextInput = supportsTextInput,
      _placeholderOrTitle = placeholderOrTitle,
      _image = image,
      _onPressed = onPressed,
      _formatters = formatters,
      _focusNode = focusNode,
      _keyboardType = keyboardType;

  String get text {
    if (_supportsTextInput) {
      return _textFieldController.text;
    }
    else {
      return _placeholderOrTitle;
    }
  }

  @override
  Widget build(BuildContext context) {
    _initializeTextWidgets(context);

    return Container(
      height: _DefaultHeight,
      padding: EdgeInsets.only(left: _DefaultInset),
      decoration: BoxDecoration(
        color: NokNokColors.searchBarBackground,
        borderRadius: BorderRadius.all(Radius.circular(CornerRadiusLarge)),
        border: Border.all(
          color: NokNokColors.searchBarBorder,
          width: 1.0
        )
      ),
      child: Row(
        children: [
          ImageIcon(_image,
            color: NokNokColors.mainThemeColor,
          ),
          Expanded(
            child: this._textWidget,
          ),
          SizedBox(width: 8)
        ],
      ),
    );
  }

  // Internal methods

  Widget get _textWidget {
    if (_supportsTextInput) {
      return _textField;
    }
    else {
      return _button;
    }
  }

  void _initializeTextWidgets(BuildContext context) {
    if (_supportsTextInput) {
      _textFieldController = TextEditingController();

      _textField = CupertinoTextField(
        placeholder: _placeholderOrTitle,
        placeholderStyle: Theme.of(context).textTheme.caption.copyWith(
          fontSize: NokNokFonts.searchBar,
          color: NokNokColors.mainThemeColor.withAlpha(127)),
        style: Theme.of(context).textTheme.caption.copyWith(
          fontSize: NokNokFonts.searchBar,
          color: NokNokColors.mainThemeColor),
        textAlign: TextAlign.left,
        decoration: null,
        keyboardType: _keyboardType,
        inputFormatters: _formatters,
        controller: _textFieldController,
        focusNode: _focusNode,
      );
    }
    else {
      _button = CupertinoButton(
        child: Text(
          _placeholderOrTitle,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.caption.copyWith(
            fontSize: NokNokFonts.searchBar,
            color: NokNokColors.mainThemeColor),
        ),
        onPressed: () {
          if (_onPressed != null) {
            _onPressed();
          }
        },
      );
    }
  }

  // Internal fields

  final bool _supportsTextInput;
  final String _placeholderOrTitle;
  final ImageProvider _image;
  final List<TextInputFormatter> _formatters;
  final VoidCallback _onPressed;
  final FocusNode _focusNode;
  final TextInputType _keyboardType;

  CupertinoTextField _textField;
  TextEditingController _textFieldController;
  CupertinoButton _button;

  static const _DefaultHeight = 50.0;
  static const _DefaultInset = 19.0;

}