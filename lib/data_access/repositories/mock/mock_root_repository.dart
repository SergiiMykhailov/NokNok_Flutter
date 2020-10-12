import 'package:nok_nok/data_access/repositories/mock/mock_store_repository.dart';
import 'package:nok_nok/data_access/repositories/base/root_repository.dart';
import 'package:nok_nok/data_access/repositories/base/store_repository.dart';

import 'package:built_collection/built_collection.dart';

class MockRootRepository implements RootRepository {

  @override
  Future<BuiltList<StoreRepository>> fetchAllStores() async {
    final allStores = [MockStoreRepository()];
    final result = BuiltList<StoreRepository>.from(allStores);

    return Future<BuiltList<StoreRepository>>.delayed(Duration(seconds: 2),
                                                      () => result);
  }

}