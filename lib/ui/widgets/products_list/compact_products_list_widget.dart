import 'package:nok_nok/models/store_product_base.dart';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';

import 'compact_products_list_item_widget.dart';

typedef ItemActionCallback = void Function(int itemIndex);

class CompactProductsListWidget extends StatefulWidget {

  // Public methods and properties

  CompactProductsListWidget(
    BuiltList<StoreProductBase> products,
    {ItemActionCallback onItemAppended})
    : _products = products,
      _onItemAppended = onItemAppended,
      super();

  // Overridden methods

  @override
  _CompactProductsListWidgetState createState() =>
    _CompactProductsListWidgetState(
      _products,
      onItemAppended: _onItemAppended
    );

  // Internal fields

  final BuiltList<StoreProductBase> _products;
  final ItemActionCallback _onItemAppended;

}

class _CompactProductsListWidgetState extends State<CompactProductsListWidget> {

  // Public methods and properties

  _CompactProductsListWidgetState(
    BuiltList<StoreProductBase> products,
    {ItemActionCallback onItemAppended})
    : _products = products,
      _onItemAppended = onItemAppended,
      super();

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
              CompactProductsListItemWidget(
                currentItem,
                onPlusButtonClicked: () {
                  if (_onItemAppended != null) {
                    _onItemAppended(index);
                  }
                },
              ),
              SizedBox(height: 3,),
            ],
          )
        );
      }
    );
  }

  // Internal fields

  final BuiltList<StoreProductBase> _products;
  final ItemActionCallback _onItemAppended;

}