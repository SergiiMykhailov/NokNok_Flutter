import 'package:nok_nok/data_access/repositories/base/store_repository.dart';

abstract class StoresListState {
}

class StoresListStateLoading extends StoresListState {
}

class StoresListStateNavigatingToStore extends StoresListState {

  // Public methods and properties

  StoreRepository get storeRepository => _storeRepository;

  StoresListStateNavigatingToStore(StoreRepository storeRepository)
    : _storeRepository = storeRepository, super();

  // Internal fields.

  StoreRepository _storeRepository;

}