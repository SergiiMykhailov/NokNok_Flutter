import 'package:nok_nok/data_access/models/store_category_item.dart';
import 'package:nok_nok/data_access/repositories/base/store_repository.dart';

import 'package:built_collection/built_collection.dart';

class MockStoreRepository implements StoreRepository {

  // Public methods

  factory MockStoreRepository() => _instance;

  @override
  Future<BuiltList<StoreCategoryItem>> fetchAllCategories() {
    final categories = [
      StoreCategoryItem(iconPath: 'https://firebasestorage.googleapis.com/v0/b/noknok-c638d.appspot.com/o/stores%2F1%2Ficons%2FgoodsCategories%2Fvegetables.png?alt=media&token=f19a24e3-a691-4ad5-b67a-3cf83ad4568e',
                        title: 'Овощи и фрукты'),
      StoreCategoryItem(iconPath: 'https://firebasestorage.googleapis.com/v0/b/noknok-c638d.appspot.com/o/stores%2F1%2Ficons%2FgoodsCategories%2Fbakery.png?alt=media&token=017a155b-3697-492f-a403-711000720902',
                        title: 'Сладости'),
      StoreCategoryItem(iconPath: 'https://firebasestorage.googleapis.com/v0/b/noknok-c638d.appspot.com/o/stores%2F1%2Ficons%2FgoodsCategories%2Fgastronomy.png?alt=media&token=b0688a12-97a3-4b5c-8785-f5f2d2dcd269',
                        title: 'Гастрономия'),
      StoreCategoryItem(iconPath: 'https://firebasestorage.googleapis.com/v0/b/noknok-c638d.appspot.com/o/stores%2F1%2Ficons%2FgoodsCategories%2Fmilk.png?alt=media&token=862731ac-9dc7-4c0d-85be-9de7fad029ba',
                        title: 'Молочные продукты'),
      StoreCategoryItem(iconPath: 'https://firebasestorage.googleapis.com/v0/b/noknok-c638d.appspot.com/o/stores%2F1%2Ficons%2FgoodsCategories%2Fbread.png?alt=media&token=a87eb858-427a-49d3-b73e-295824f92dbb',
                        title: 'Хлеб'),
      StoreCategoryItem(iconPath: 'https://firebasestorage.googleapis.com/v0/b/noknok-c638d.appspot.com/o/stores%2F1%2Ficons%2FgoodsCategories%2Fgrocery.png?alt=media&token=47c00d09-17db-4254-ad3f-82edce1c2b07',
                        title: 'Бакалея'),
      StoreCategoryItem(iconPath: 'https://firebasestorage.googleapis.com/v0/b/noknok-c638d.appspot.com/o/stores%2F1%2Ficons%2FgoodsCategories%2Fdrinks.png?alt=media&token=c36eb760-7be7-4b6c-abd7-b367e0ee792b',
                        title: 'Напитки'),
      StoreCategoryItem(iconPath: 'https://firebasestorage.googleapis.com/v0/b/noknok-c638d.appspot.com/o/stores%2F1%2Ficons%2FgoodsCategories%2Falcohol.png?alt=media&token=2ccfd9bf-7973-45ff-bc4b-0232370d8d11',
                        title: 'Алкоголь')
      ];

    final result = BuiltList<StoreCategoryItem>.from(categories);

    return Future<BuiltList<StoreCategoryItem>>.delayed(Duration(seconds: 2),
                                                        () => result);
  }

  // Internal methods

  MockStoreRepository._setup() {
    // Initialization logic here.
  }

  // Internal fields

  static final _instance = new MockStoreRepository._setup();

}