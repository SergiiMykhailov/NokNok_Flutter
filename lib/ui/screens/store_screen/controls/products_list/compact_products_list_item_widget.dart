import 'package:nok_nok/models/store_product_base.dart';

import 'package:nok_nok/ui/theme/nok_nok_colors.dart';
import 'package:nok_nok/ui/theme/nok_nok_images.dart';
import 'package:nok_nok/ui/theme/nok_nok_theme.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nok_nok/ui/utils/utils.dart';

class CompactProductsListItemWidget extends StatefulWidget {

  // Public methods and properties

  static const PreferredHeight = 52.0;

  CompactProductsListItemWidget(StoreProductBase product)
    : _product = product, super();

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
    return Container(
      height: CompactProductsListItemWidget.PreferredHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          // Title / Description
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Just to push text a little bit down
                SizedBox(
                  height: 6,
                ),

                // Title
                Text(_product.title,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.caption.copyWith(fontSize: NokNokFonts.productTitle,
                    color: NokNokColors.productTitle),
                ),

                // Description
                Text(_product.description,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.caption.copyWith(fontSize: NokNokFonts.productDescription,
                    color: NokNokColors.productDescription),
                ),
              ],
            ),
          ),

          // Add / Remove / Items Count / Detail
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: DefaultHorizontalPadding, right: DefaultHorizontalPadding * 2),
                  child: Image(image: NokNokImages.basketRemove),
                ),
                Image(image: NokNokImages.basketAdd),
                SizedBox(
                  width: CounterLabelWidth,
                  child: Text(count > 0 ? "$count" : ""),),
                Container(
                  padding: EdgeInsets.only(left: DefaultHorizontalPadding),
                  child: Icon(CupertinoIcons.right_chevron),
                ),
              ],
            ),
          ),
        ]
      )
    );
  }

  // Internal fields

  final StoreProductBase _product;

  int count = 0;

  static const CounterLabelWidth = 15.0;

}