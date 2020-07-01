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

  // Overridden methods and properties

  @override
  BasketState get initialState => BasketStateLoading();

  @override
  Stream<BasketState> mapEventToState(BasketEvent event) async* {
    if (event is ReloadBasketEvent) {
      yield* _handleReload();
    }
  }

  // Internal methods

  Stream<BasketState> _handleReload() async* {
    yield BasketStateLoaded(_storeRepository.getBasket());
  }

  // Internal fields

  StoreRepository _storeRepository;

}