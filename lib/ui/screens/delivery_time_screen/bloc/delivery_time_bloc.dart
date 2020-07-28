import 'package:nok_nok/ui/routing/build_context_provider.dart';
import 'package:nok_nok/ui/screens/delivery_time_screen/routing/delivery_time_router.dart';

import 'delivery_time_event.dart';
import 'delivery_time_state.dart';
import 'package:nok_nok/data_access/repositories/base/store_repository.dart';

import 'package:bloc/bloc.dart';

class DeliveryTimeBloc extends Bloc<DeliveryTimeEvent, DeliveryTimeState> {

  // Public methods and properties

  BuildContextProvider buildContextProvider;
  StoreRepository get storeRepository => _storeRepository;

  DeliveryTimeBloc(this._storeRepository,
    this._router)
    : super() {
    assert(_router != null);

    reload();
  }

  void reload() {
    dispatch(ReloadDeliveryTimeEvent());
  }

  void navigateBack() {
    if (buildContextProvider == null) {
      print('Build context provider is not set for DeliveryTimeBlock, Unable to navigate to basket.');
    }
    else {
      final context = buildContextProvider.getContext();
      _router.navigateBack(context);
    }
  }

  void purchase() {

  }

  // Overridden methods and properties

  @override
  DeliveryTimeState get initialState => DeliveryTimeStateLoading();

  @override
  Stream<DeliveryTimeState> mapEventToState(DeliveryTimeEvent event) async* {
    if (event is ReloadDeliveryTimeEvent) {
      yield* _handleReload();
    }
  }

  // Internal methods

  Stream<DeliveryTimeState> _handleReload() async* {
    yield DeliveryTimeStateLoaded(_storeRepository.getBasket());
  }

  // Internal fields

  StoreRepository _storeRepository;
  DeliveryTimeScreenRouter _router;

}