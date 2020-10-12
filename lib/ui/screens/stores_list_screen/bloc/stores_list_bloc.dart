import 'package:nok_nok/ui/routing/build_context_provider.dart';
import 'package:nok_nok/ui/screens/stores_list_screen/routing/stores_list_screen_router.dart';

import 'stores_list_event.dart';
import 'stores_list_state.dart';

import 'package:nok_nok/data_access/repositories/base/root_repository.dart';

import 'package:bloc/bloc.dart';

class StoresListBloc extends Bloc<StoresListEvent, StoresListState> {

  // Public methods and properties

  RootRepository get rootRepository => _rootRepository;
  BuildContextProvider buildContextProvider;

  StoresListBloc(this._rootRepository,
                 this._router)
    : super() {
    assert(_rootRepository != null);
    assert(_router != null);

    reload();
  }

  void reload() {
    dispatch(ReloadStoresListEvent());
  }

  // Overridden methods

  @override
  StoresListState get initialState => StoresListStateLoading();

  @override
  Stream<StoresListState> mapEventToState(StoresListEvent event) async* {
    if (event is ReloadStoresListEvent) {
      yield* _handleReload();
    }
  }

  // Internal methods

  Stream<StoresListState> _handleReload() async* {
    final stores = await _rootRepository.fetchAllStores();

    if (stores.isNotEmpty) {
      if (buildContextProvider == null) {
        print('Build context provider is not set for StoresListBloc, Unable to navigate to store.');
      }
      else {
        final context = buildContextProvider.getContext();
        _router.navigateToStore(context, stores.first);
      }
    }
  }

  // Internal fields

  RootRepository _rootRepository;
  StoresListScreenRouter _router;

}