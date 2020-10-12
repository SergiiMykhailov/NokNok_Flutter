import 'package:nok_nok/models/basket.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nok_nok/ui/theme/nok_nok_colors.dart';
import 'package:nok_nok/ui/theme/nok_nok_images.dart';
import 'package:nok_nok/ui/theme/nok_nok_theme.dart';
import 'package:nok_nok/ui/utils/screen_utils.dart';
import 'package:nok_nok/ui/utils/utils.dart';
import 'package:nok_nok/ui/widgets/basket_items_picker.dart';

class BasketListItemWidget extends StatefulWidget {

  // Public methods and properties

  static const PreferredHeight = 130.0;

  BasketListItemWidget(
    BasketItem basketItem,
    {Key key,
     VoidCallback onPlusButtonClicked,
     VoidCallback onMinusButtonClicked,
     VoidCallback onRemoveButtonClicked})
    : _basketItem = basketItem,
      _onPlusButtonClicked = onPlusButtonClicked,
      _onMinusButtonClicked = onMinusButtonClicked,
      _onRemoveButtonClicked = onRemoveButtonClicked,
      super(key: key) {
    assert(_basketItem != null);
  }

  // Overridden methods

  @override
  _BasketListItemWidgetState createState() =>
    _BasketListItemWidgetState(
      _basketItem,
      onPlusButtonClicked: _onPlusButtonClicked,
      onMinusButtonClicked: _onMinusButtonClicked,
      onRemoveButtonClicked: _onRemoveButtonClicked
    );

  // Internal fields

  final BasketItem _basketItem;
  final VoidCallback _onPlusButtonClicked;
  final VoidCallback _onMinusButtonClicked;
  final VoidCallback _onRemoveButtonClicked;

}

class _BasketListItemWidgetState extends State<BasketListItemWidget> {

  // Public methods and properties

  _BasketListItemWidgetState(
    BasketItem basketItem,
    {VoidCallback onPlusButtonClicked,
     VoidCallback onMinusButtonClicked,
     VoidCallback onRemoveButtonClicked})
    : _basketItem = basketItem,
      _onPlusButtonClicked = onPlusButtonClicked,
      _onMinusButtonClicked = onMinusButtonClicked,
      _onRemoveButtonClicked = onRemoveButtonClicked,
      super();

  // Overridden methods

  @override
  Widget build(BuildContext context) {
    final imageContent = _basketItem.product.imageUrl != null
      ? Image.network(_basketItem.product.imageUrl)
      : Container();

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(CornerRadiusLarge)),
      child: Container(
        height: BasketListItemWidget.PreferredHeight,
        color: CupertinoColors.white,
        child: Row(
          children: [
            Container(
              width: BasketListItemWidget.PreferredHeight,
              child: imageContent
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 9,),
                  Text(
                    _basketItem.product.title,
                    style: Theme.of(context).textTheme.caption.copyWith(
                      fontSize: NokNokFonts.caption,
                      color: NokNokColors.mainThemeColor),
                  ),
                  SizedBox(height: 2,),
                  Text(
                    _basketItem.product.description,
                    style: Theme.of(context).textTheme.caption.copyWith(
                      fontSize: NokNokFonts.caption,
                      color: NokNokColors.mainThemeColor),
                  ),
                  Expanded(child: Container()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: BasketItemsPickerWidget.PreferredWidth,
                        height: BasketItemsPickerWidget.PreferredHeight,
                        child: BasketItemsPickerWidget(
                          _basketItem.quantity,
                          _onPlusButtonClicked,
                          _onMinusButtonClicked
                        ),
                      ),
                      SizedBox(width: 7,),
                      Text(
                        _basketItem.product.description,
                        style: Theme.of(context).textTheme.caption.copyWith(
                          fontSize: NokNokFonts.caption,
                          color: NokNokColors.mainThemeColor),
                      )
                    ],
                  ),
                  SizedBox(height: 8)
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CupertinoButton(
                  child: Container(
                      width: 21,
                      height: 24,
                      child: ImageIcon(NokNokImages.trashBin,
                          color: NokNokColors.mainThemeColor)
                  ),
                  onPressed: () {
                    if (_onRemoveButtonClicked != null) {
                      _onRemoveButtonClicked();
                    }
                  },
                ),
                Expanded(child: Container()),
                Text(
                  formatPrice(_basketItem.product.price),
                  style: Theme.of(context).textTheme.caption.copyWith(
                    fontSize: NokNokFonts.productPrice,
                    fontWeight: FontWeight.bold,
                    color: NokNokColors.mainThemeColor),
                ),
                SizedBox(height: 15,)
              ],
            ),
            SizedBox(width: 13,)
          ],
        ),
      ),
    );
  }

  // Internal fields

  final BasketItem _basketItem;
  final VoidCallback _onPlusButtonClicked;
  final VoidCallback _onMinusButtonClicked;
  final VoidCallback _onRemoveButtonClicked;

}