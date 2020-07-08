import 'package:nok_nok/models/basket.dart';

import 'package:flutter/cupertino.dart';

import 'basket_list_item_widget.dart';


typedef ItemActionCallback = void Function(int itemIndex);

class BasketListWidget extends StatefulWidget {

  // Public methods and properties

  BasketListWidget(
    Basket basket,
    {ItemActionCallback onItemAppended,
     ItemActionCallback onItemDecreased,
     ItemActionCallback onItemRemoved})
    : _basket = basket,
      _onItemAppended = onItemAppended,
      _onItemDecreased = onItemDecreased,
      _onItemRemoved = onItemRemoved,
      super() {
    assert(_basket != null);
  }

  // Overridden methods

  @override
  _BasketListWidgetState createState() =>
    _BasketListWidgetState(
      _basket,
      onItemAppended: _onItemAppended,
      onItemDecreased: _onItemDecreased,
      onItemRemoved: _onItemRemoved
    );

  // Internal fields

  final Basket _basket;
  final ItemActionCallback _onItemAppended;
  final ItemActionCallback _onItemDecreased;
  final ItemActionCallback _onItemRemoved;

}

class _BasketListWidgetState extends State<BasketListWidget> {

  // Public methods and properties

  _BasketListWidgetState(
    Basket basket,
    {ItemActionCallback onItemAppended,
     ItemActionCallback onItemDecreased,
     ItemActionCallback onItemRemoved})
    : _basket = basket,
      _onItemAppended = onItemAppended,
      _onItemDecreased = onItemDecreased,
      _onItemRemoved = onItemRemoved,
      super();

  // Overridden methods

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _basket.items.length,
      itemBuilder: (BuildContext context, int index) {
        final currentItem = _basket.items[index];

        return Container(
          child: Column(
            children: [
              SizedBox(height: 3,),
              BasketListItemWidget(
                currentItem,
                key: UniqueKey(),
                onPlusButtonClicked: () {
                  if (_onItemAppended != null) {
                    _onItemAppended(index);
                  }
                },
                onMinusButtonClicked: () {
                  if (_onItemDecreased != null) {
                    _onItemDecreased(index);
                  }
                },
                onRemoveButtonClicked: () {
                  if (_onItemRemoved != null) {
                    _onItemRemoved(index);
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

  final Basket _basket;
  final ItemActionCallback _onItemAppended;
  final ItemActionCallback _onItemDecreased;
  final ItemActionCallback _onItemRemoved;

}