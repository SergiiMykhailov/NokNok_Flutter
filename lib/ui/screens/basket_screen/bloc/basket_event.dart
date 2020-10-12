abstract class BasketEvent {
}

class ReloadBasketEvent extends BasketEvent {
}

class AppendItemEvent extends BasketEvent {

  int itemIndex;

  AppendItemEvent(this.itemIndex);

}

class DecrementItemEvent extends BasketEvent {

  int itemIndex;

  DecrementItemEvent(this.itemIndex);

}

class RemoveItemEvent extends BasketEvent {

  int itemIndex;

  RemoveItemEvent(this.itemIndex);

}
