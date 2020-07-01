abstract class StoreEvent {
}

class ReloadStoreEvent extends StoreEvent {
}

class AddItemToBasketEvent extends StoreEvent {

  final int itemIndex;

  AddItemToBasketEvent(this.itemIndex);

}