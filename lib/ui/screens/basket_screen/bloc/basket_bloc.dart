import 'package:nok_nok/data_access/repositories/base/store_repository.dart';

import 'package:bloc/bloc.dart';
import 'package:nok_nok/ui/screens/basket_screen/bloc/basket_event.dart';
import 'package:nok_nok/ui/screens/basket_screen/bloc/basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {

  // Public methods and properties

  StoreRepository get storeRepository => _storeRepository;

  BasketBloc(this._storeRepository)
    : super() {
    reload();
  }

  void reload() {
    dispatch(ReloadBasketEvent());
  }

  void appendItemWithIndex(int itemIndex) {
    dispatch(AppendItemEvent(itemIndex));
  }

  void decrementItemWithIndex(int itemIndex) {
    dispatch(DecrementItemEvent(itemIndex));
  }

  void removeItemWithIndex(int itemIndex) {
    dispatch(RemoveItemEvent(itemIndex));
  }

  // Overridden methods and properties

  @override
  BasketState get initialState => BasketStateLoading();

  @override
  Stream<BasketState> mapEventToState(BasketEvent event) async* {
    if (event is ReloadBasketEvent) {
      yield* _handleReload();
    }
    else if (event is AppendItemEvent) {
      yield* _handleAppendItemWithIndex(event.itemIndex);
    }
    else if (event is DecrementItemEvent) {
      yield* _handleDecrementItemWithIndex(event.itemIndex);
    }
    else if (event is RemoveItemEvent) {
      yield* _handleRemoveItemWithIndex(event.itemIndex);
    }
  }

  // Internal methods

  Stream<BasketState> _handleReload() async* {
    yield BasketStateLoaded(_storeRepository.getBasket());
  }

  Stream<BasketState> _handleAppendItemWithIndex(int itemIndex) async* {
    final basket = _storeRepository.getBasket();
    if (itemIndex < basket.items.length) {
      final basketItem = basket.items[itemIndex];
      basket.insertProduct(basketItem.product);
    }

    yield BasketStateLoaded(_storeRepository.getBasket());
  }

  Stream<BasketState> _handleDecrementItemWithIndex(int itemIndex) async* {
    final basket = _storeRepository.getBasket();
    if (itemIndex < basket.items.length) {
      final basketItem = basket.items[itemIndex];
      basket.decrementProduct(basketItem.product);
    }

    yield BasketStateLoaded(_storeRepository.getBasket());
  }

  Stream<BasketState> _handleRemoveItemWithIndex(int itemIndex) async* {
    final basket = _storeRepository.getBasket();
    if (itemIndex < basket.items.length) {
      final basketItem = basket.items[itemIndex];
      basket.removeProduct(basketItem.product);
    }

    yield BasketStateLoaded(_storeRepository.getBasket());
  }

  // Internal fields

  StoreRepository _storeRepository;

}