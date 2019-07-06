import 'package:nok_nok/data_access/repositories/dummy/dummy_store_repository.dart';
import 'package:nok_nok/data_access/repositories/interfaces/root_repository.dart';
import 'package:nok_nok/data_access/repositories/interfaces/store_repository.dart';

import 'package:built_collection/built_collection.dart';

class DummyRootRepository implements RootRepository {

  @override
  Future<BuiltList<StoreRepository>> fetchAllStores() async {
    final allStores = [DummyStoreRepository()];
    final result = BuiltList<StoreRepository>.from(allStores);

    return Future<BuiltList<StoreRepository>>.value(result);
  }

}