import 'store_event.dart';
import 'store_state.dart';
import 'package:nok_nok/data_access/repositories/base/store_repository.dart';

import 'package:bloc/bloc.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {

  // Public methods and properties

  StoreRepository get storeRepository => _storeRepository;

  StoreBloc(this._storeRepository)
    : super() {
    reload();
  }

  void reload() {
    dispatch(ReloadStoreEvent());
  }

  // Overridden methods and properties

  @override
  StoreState get initialState => StoreStateLoading();

  @override
  Stream<StoreState> mapEventToState(StoreEvent event) async* {
    if (event is ReloadStoreEvent) {
      yield* _handleReload();
    }
  }

  // Internal methods

  Stream<StoreState> _handleReload() async* {
    final storeCategories = await _storeRepository.fetchAllCategories();
    yield StoreStateCategoriesLoaded(storeCategories);

    if (storeCategories.isNotEmpty) {
      final firstCategoryProducts = await _storeRepository.fetchBaseProductsForCategory(storeCategories.first);
      yield StoreStateBaseProductsLoaded(storeCategories, firstCategoryProducts);
    }
    else {
      final firstCategoryProducts = await _storeRepository.fetchBaseProductsForCategory(null);
      yield StoreStateBaseProductsLoaded(storeCategories, firstCategoryProducts);
    }
  }

  // Internal fields

  StoreRepository _storeRepository;

}