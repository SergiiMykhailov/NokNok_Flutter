import 'package:nok_nok/models/store_product_base.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nok_nok/ui/theme/nok_nok_colors.dart';
import 'package:nok_nok/ui/theme/nok_nok_images.dart';
import 'package:nok_nok/ui/theme/nok_nok_theme.dart';
import 'package:nok_nok/ui/utils/screen_utils.dart';
import 'package:nok_nok/ui/utils/utils.dart';

class CompactProductsListItemWidget extends StatefulWidget {

  // Public methods and properties

  static const PreferredHeight = 130.0;

  CompactProductsListItemWidget(StoreProductBase product)
    : _product = product, super() {
    assert(_product != null);
  }

  // Overridden methods

  @override
  _CompactProductsListItemWidgetState createState() => _CompactProductsListItemWidgetState(_product);

  // Internal fields

  final StoreProductBase _product;

}

class _CompactProductsListItemWidgetState extends State<CompactProductsListItemWidget> {

  // Public methods and properties

  _CompactProductsListItemWidgetState(StoreProductBase product)
    : _product = product, super();

  // Overridden methods

  @override
  Widget build(BuildContext context) {
    final imageContent = _product.imageUrl != null
                         ? Image.network(_product.imageUrl)
                         : Container();

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(CornerRadiusLarge)),
      child: Container(
        height: CompactProductsListItemWidget.PreferredHeight,
        color: CupertinoColors.white,
        child: Row(
          children: [
            Container(
              width: CompactProductsListItemWidget.PreferredHeight,
              child: imageContent
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 9,),
                  Text(
                    _product.title,
                    style: Theme.of(context).textTheme.caption.copyWith(
                      fontSize: NokNokFonts.caption,
                      color: NokNokColors.mainThemeColor),
                  ),
                  SizedBox(height: 2,),
                  Text(
                    _product.description,
                    style: Theme.of(context).textTheme.caption.copyWith(
                      fontSize: NokNokFonts.caption,
                      color: NokNokColors.mainThemeColor),
                  ),
                  Expanded(child: Container()),
                  Text(
                    formatPrice(_product.price),
                    style: Theme.of(context).textTheme.caption.copyWith(
                      fontSize: NokNokFonts.productPrice,
                      fontWeight: FontWeight.bold,
                      color: NokNokColors.mainThemeColor)
                  ),
                  SizedBox(height: 8,)
                ],
              ),
            ),
            Column(
              children: [
                Expanded(child: Container(),),
                Container(
                  width: _ButtonDimension,
                  height: _ButtonDimension,
                  child: CupertinoButton(
                    borderRadius: BorderRadius.all(Radius.circular(_ButtonDimension / 2)),
                    color: NokNokColors.addToBasket,
                    padding: EdgeInsets.zero,
                    child: Container(
                      width: _ButtonDimension,
                      height: _ButtonDimension,
                      child: ImageIcon(
                        NokNokImages.addToBasket,
                        color: CupertinoColors.white),
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: 13,)
              ],
            ),
            SizedBox(width: 13,)
          ],
        ),
      ),
    );
  }

  // Internal fields

  final StoreProductBase _product;

  static const _ButtonDimension = 34.0;

}