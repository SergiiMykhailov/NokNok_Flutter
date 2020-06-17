import 'package:nok_nok/models/store_product_base.dart';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';

import 'compact_products_list_item_widget.dart';

class CompactProductsListWidget extends StatefulWidget {

  // Public methods and properties

  CompactProductsListWidget(BuiltList<StoreProductBase> products)
    : _products = products, super();

  // Overridden methods

  @override
  _CompactProductsListWidgetState createState() => _CompactProductsListWidgetState(_products);

  // Internal fields

  final BuiltList<StoreProductBase> _products;

}

class _CompactProductsListWidgetState extends State<CompactProductsListWidget> {

  // Public methods and properties

  _CompactProductsListWidgetState(BuiltList<StoreProductBase> products)
    : _products = products, super();

  // Overridden methods

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _products.length,
      itemBuilder: (BuildContext context, int index) {
        final currentItem = _products[index];

        return Container(
          child: Column(
            children: [
              SizedBox(height: 3,),
              CompactProductsListItemWidget(currentItem),
              SizedBox(height: 3,),
            ],
          )
        );
      }
    );
  }

  // Internal fields

  final BuiltList<StoreProductBase> _products;

}