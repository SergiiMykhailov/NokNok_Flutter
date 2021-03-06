import 'package:nok_nok/data_access/secure_storage/secure_storage.dart';
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
    if (buildContextProvider == null) {
      print('Build context provider is not set for BasketBloc, Unable to navigate to time slot selection.');
    }
    else {
      final context = buildContextProvider.getContext();
      _router.navigateToTimeSlotSelection(context, _selectedAddress, _storeRepository);
    }
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
    final userName = SecureStorage().userName;
    final phoneNumber = SecureStorage().phoneNumber;

    // TODO: Implement retrieving real user email.
    final email = 'ivan.ivanov@example.com';

    yield DeliveryStateLoaded(_storeRepository.getBasket(), _selectedAddress, userName, phoneNumber, email);
  }

  // Internal fields

  StoreRepository _storeRepository;
  DeliveryScreenRouter _router;
  final String _selectedAddress = 'Мирная, 19';

}