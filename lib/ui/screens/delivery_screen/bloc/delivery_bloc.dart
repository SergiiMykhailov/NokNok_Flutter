import 'package:nok_nok/ui/routing/build_context_provider.dart';
import 'package:nok_nok/ui/screens/delivery_screen/routing/delivery_screen_router.dart';

import 'delivery_event.dart';
import 'delivery_state.dart';
import 'package:nok_nok/data_access/repositories/base/store_repository.dart';

import 'package:bloc/bloc.dart';

class DeliveryBloc extends Bloc<DeliveryEvent, DeliveryState> {

  // Public methods and properties

  BuildContextProvider buildContextProvider;
  StoreRepository get storeRepository => _storeRepository;

  DeliveryBloc(this._storeRepository,
    this._router)
    : super() {
    assert(_router != null);

    reload();
  }

  void reload() {
    dispatch(ReloadDeliveryEvent());
  }

  void navigateBack() {
    if (buildContextProvider == null) {
      print('Build context provider is not set for BasketBloc, Unable to navigate to basket.');
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
  DeliveryState get initialState => DeliveryStateLoading();

  @override
  Stream<DeliveryState> mapEventToState(DeliveryEvent event) async* {
    if (event is ReloadDeliveryEvent) {
      yield* _handleReload();
    }
  }

  // Internal methods

  Stream<DeliveryState> _handleReload() async* {
    // TODO: Implement retrieving real user contact info.
    final userName = 'Иван Иванов';
    final phoneNumber = '0501234567';
    final email = 'ivan.ivanov@example.com';

    yield DeliveryStateLoaded(_storeRepository.getBasket(), userName, phoneNumber, email);
  }

  // Internal fields

  StoreRepository _storeRepository;
  DeliveryScreenRouter _router;

}