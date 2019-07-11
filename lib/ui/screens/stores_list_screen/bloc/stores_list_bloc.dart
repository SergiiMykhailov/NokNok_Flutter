import 'stores_list_event.dart';
import 'stores_list_state.dart';

import 'package:nok_nok/data_access/repositories/base/root_repository.dart';

import 'package:bloc/bloc.dart';

class StoresListBloc extends Bloc<StoresListEvent, StoresListState> {

  // Public methods and properties

  RootRepository get rootRepository => _rootRepository;

  StoresListBloc(this._rootRepository)
    : super() {
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
    yield StoresListStateNavigatingToStore(stores.first);
  }

  // Internal fields

  RootRepository _rootRepository;

}