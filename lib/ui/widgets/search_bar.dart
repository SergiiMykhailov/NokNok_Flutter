import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nok_nok/ui/theme/nok_nok_colors.dart';
import 'package:nok_nok/ui/theme/nok_nok_theme.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    @required this.controller,
    @required this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: NokNokColors.searchBarBackground,
        border: Border.all(color: NokNokColors.searchBarBorder, width: 1.0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 8,
        ),
        child: Row(
          children: [
            SizedBox(width: 8),
            Icon(
              CupertinoIcons.search,
              color: NokNokColors.mainThemeColor,
            ),
            Expanded(
              child: CupertinoTextField(
                controller: controller,
                focusNode: focusNode,
                decoration: BoxDecoration(color: NokNokColors.searchBarBackground),
                style: Theme.of(context).textTheme.caption.copyWith(
                  fontSize: NokNokFonts.searchBar,
                  color: NokNokColors.mainThemeColor),
                cursorColor: NokNokColors.mainThemeColor,
              ),
            ),
            GestureDetector(
              onTap: controller.clear,
              child: Icon(
                CupertinoIcons.clear_thick_circled,
                color: NokNokColors.mainThemeColor,
              ),
            ),
            SizedBox(width: 8)
          ],
        ),
      ),
    );
  }
}
