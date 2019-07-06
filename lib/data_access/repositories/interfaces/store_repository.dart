import 'package:nok_nok/data_access/models/store_category_item.dart';

import 'package:built_collection/built_collection.dart';

// Interface which declares all methods for working with single store.
abstract class StoreRepository {

  Future<BuiltList<StoreCategoryItem>> fetchAllCategories();

}