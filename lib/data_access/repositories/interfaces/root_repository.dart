import 'package:nok_nok/data_access/repositories/interfaces/store_repository.dart';

import 'package:built_collection/built_collection.dart';

// Interface which declares all methods for managing entire system.
abstract class RootRepository {

  Future<BuiltList<StoreRepository>> fetchAllStores();

}