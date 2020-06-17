import 'package:nok_nok/data_access/repositories/base/root_repository.dart';
import 'package:nok_nok/data_access/repositories/base/store_repository.dart';
import 'package:nok_nok/data_access/repositories/firebase/firebase_store_repository.dart';

import 'package:built_collection/built_collection.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseRootRepository extends RootRepository {

  // Overridden methods

  @override
  Future<BuiltList<StoreRepository>> fetchAllStores() async {
    final storeNode = database.child('stores').child('default');
    final allStores = [FirebaseStoreRepository(storeNode: storeNode)];
    final result = BuiltList<StoreRepository>.from(allStores);

    return Future<BuiltList<StoreRepository>>.delayed(Duration(seconds: 2),
        () => result);
  }

  // Internal fields

  final database = FirebaseDatabase.instance.reference();

}