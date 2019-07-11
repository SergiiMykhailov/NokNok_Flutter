import 'package:nok_nok/data_access/models/store_category_item.dart';
import 'package:nok_nok/data_access/repositories/base/store_repository.dart';

import 'package:built_collection/built_collection.dart';

class MockStoreRepository implements StoreRepository {

  // Public methods

  factory MockStoreRepository() => _instance;

  @override
  Future<BuiltList<StoreCategoryItem>> fetchAllCategories() {
    final categories = [
      StoreCategoryItem(iconPath: 'https://firebasestorage.googleapis.com/v0/b/noknok-c638d.appspot.com/o/stores%2F1%2Ficons%2FgoodsCategories%2Fvegetables.png?alt=media&token=8d4d9f23-fc13-411f-9bb1-3185f84ab99a',
                        title: 'Овощи и фрукты'),
      StoreCategoryItem(iconPath: 'https://firebasestorage.googleapis.com/v0/b/noknok-c638d.appspot.com/o/stores%2F1%2Ficons%2FgoodsCategories%2Fbakery.png?alt=media&token=b649044c-43a3-4b90-895d-e16420b06fd9',
                        title: 'Сладости'),
      StoreCategoryItem(iconPath: 'https://firebasestorage.googleapis.com/v0/b/noknok-c638d.appspot.com/o/stores%2F1%2Ficons%2FgoodsCategories%2Fgastronomy.png?alt=media&token=046c3f85-c9ae-412d-adba-933b1c6c5d7e',
                        title: 'Гастрономия'),
      StoreCategoryItem(iconPath: 'https://firebasestorage.googleapis.com/v0/b/noknok-c638d.appspot.com/o/stores%2F1%2Ficons%2FgoodsCategories%2Fmilk.png?alt=media&token=53e3497d-29b9-49df-9f14-327cddfe9272',
                        title: 'Молочные продукты'),
      StoreCategoryItem(iconPath: 'https://firebasestorage.googleapis.com/v0/b/noknok-c638d.appspot.com/o/stores%2F1%2Ficons%2FgoodsCategories%2Fbread.png?alt=media&token=12870401-0199-4834-b6b0-30f8d6eff82e',
                        title: 'Хлеб'),
      StoreCategoryItem(iconPath: 'https://firebasestorage.googleapis.com/v0/b/noknok-c638d.appspot.com/o/stores%2F1%2Ficons%2FgoodsCategories%2Fgrocery.png?alt=media&token=28a1b79a-cafd-436c-b544-e62d6b11b67a',
                        title: 'Бакалея'),
      StoreCategoryItem(iconPath: 'https://firebasestorage.googleapis.com/v0/b/noknok-c638d.appspot.com/o/stores%2F1%2Ficons%2FgoodsCategories%2Fdrinks.png?alt=media&token=9c6fb401-a1ff-4785-b905-dd2c28548e22',
                        title: 'Напитки'),
      StoreCategoryItem(iconPath: 'https://firebasestorage.googleapis.com/v0/b/noknok-c638d.appspot.com/o/stores%2F1%2Ficons%2FgoodsCategories%2Falcohol.png?alt=media&token=4f95ab81-796a-4d30-965a-9044559ff672',
                        title: 'Алкоголь')
      ];

    final result = BuiltList<StoreCategoryItem>.from(categories);

    return Future<BuiltList<StoreCategoryItem>>.value(result);
  }

  // Internal methods

  MockStoreRepository._setup() {
    // Initialization logic here.
  }

  // Internal fields

  static final _instance = new MockStoreRepository._setup();

}