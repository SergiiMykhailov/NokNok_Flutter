import 'package:nok_nok/models/store_category_item.dart';
import 'package:nok_nok/data_access/repositories/base/store_repository.dart';

import 'package:built_collection/built_collection.dart';
import 'package:nok_nok/models/store_product_base.dart';

class MockStoreRepository implements StoreRepository {

  // Public methods

  factory MockStoreRepository() => _instance;

  @override
  Future<BuiltList<StoreCategoryItem>> fetchAllCategories() async {
    final categories = [
      StoreCategoryItem(id: "1",
                        iconPath: 'https://firebasestorage.googleapis.com/v0/b/noknok-c638d.appspot.com/o/stores%2F1%2Ficons%2FgoodsCategories%2Fvegetables.png?alt=media&token=f19a24e3-a691-4ad5-b67a-3cf83ad4568e',
                        title: 'Овощи и фрукты'),
      StoreCategoryItem(id: "2",
                        iconPath: 'https://firebasestorage.googleapis.com/v0/b/noknok-c638d.appspot.com/o/stores%2F1%2Ficons%2FgoodsCategories%2Fbakery.png?alt=media&token=017a155b-3697-492f-a403-711000720902',
                        title: 'Сладости'),
      StoreCategoryItem(id: "3",
                        iconPath: 'https://firebasestorage.googleapis.com/v0/b/noknok-c638d.appspot.com/o/stores%2F1%2Ficons%2FgoodsCategories%2Fgastronomy.png?alt=media&token=b0688a12-97a3-4b5c-8785-f5f2d2dcd269',
                        title: 'Гастрономия'),
      StoreCategoryItem(id: "4",
                        iconPath: 'https://firebasestorage.googleapis.com/v0/b/noknok-c638d.appspot.com/o/stores%2F1%2Ficons%2FgoodsCategories%2Fmilk.png?alt=media&token=862731ac-9dc7-4c0d-85be-9de7fad029ba',
                        title: 'Молочные продукты'),
      StoreCategoryItem(id: "5",
                        iconPath: 'https://firebasestorage.googleapis.com/v0/b/noknok-c638d.appspot.com/o/stores%2F1%2Ficons%2FgoodsCategories%2Fbread.png?alt=media&token=a87eb858-427a-49d3-b73e-295824f92dbb',
                        title: 'Хлеб'),
      StoreCategoryItem(id: "6",
                        iconPath: 'https://firebasestorage.googleapis.com/v0/b/noknok-c638d.appspot.com/o/stores%2F1%2Ficons%2FgoodsCategories%2Fgrocery.png?alt=media&token=47c00d09-17db-4254-ad3f-82edce1c2b07',
                        title: 'Бакалея'),
      StoreCategoryItem(id: "7",
                        iconPath: 'https://firebasestorage.googleapis.com/v0/b/noknok-c638d.appspot.com/o/stores%2F1%2Ficons%2FgoodsCategories%2Fdrinks.png?alt=media&token=c36eb760-7be7-4b6c-abd7-b367e0ee792b',
                        title: 'Напитки'),
      StoreCategoryItem(id: "8",
                        iconPath: 'https://firebasestorage.googleapis.com/v0/b/noknok-c638d.appspot.com/o/stores%2F1%2Ficons%2FgoodsCategories%2Falcohol.png?alt=media&token=2ccfd9bf-7973-45ff-bc4b-0232370d8d11',
                        title: 'Алкоголь')
      ];

    final result = BuiltList<StoreCategoryItem>.from(categories);

    return Future<BuiltList<StoreCategoryItem>>.delayed(Duration(seconds: 2),
                                                        () => result);
  }

  @override
  Future<BuiltList<StoreProductBase>> fetchBaseProductsForCategory(StoreCategoryItem productsCategory) async {
    BuiltList<StoreProductBase> result;

    switch (productsCategory.title) {
      case "Молочные продукты":
        result = BuiltList<StoreProductBase>([
          StoreProductBase(id: "1",
                           title: "Молоко",
                           description: "2.5%, 1л"),
          StoreProductBase(id: "2",
                           title: "Кефир",
                           description: "1%, 1л"),
          StoreProductBase(id: "3",
                           title: "Йогурт",
                           description: "2.5%, 400г"),
          StoreProductBase(id: "4",
                           title: "Сметана",
                           description: "20%, 500г"),
          StoreProductBase(id: "5",
                           title: "Сливки",
                           description: "10%, 10х10г"),
          StoreProductBase(id: "6",
                           title: "Творог",
                           description: "5%, 200г"),
          StoreProductBase(id: "7",
                           title: "Сыр Фета",
                           description: "45%, 200г"),
          StoreProductBase(id: "8",
                           title: "Молоко сгущеное",
                           description: "8.5%, 270г"),
          StoreProductBase(id: "9",
                           title: "Масло сливочное",
                           description: "73%, 250г"),
          StoreProductBase(id: "10",
                           title: "Сыр пармезан",
                           description: "60%, 250г"),
        ]);
        break;

      case "Овощи и фрукты":
        result = BuiltList<StoreProductBase>([
          StoreProductBase(id: "11",
            title: "Банан",
            description: "Испания"),
          StoreProductBase(id: "12",
            title: "Яблоко",
            description: "Черный Принц, Украина"),
          StoreProductBase(id: "13",
            title: "Апельсин",
            description: "Турция"),
          StoreProductBase(id: "14",
            title: "Картофель",
            description: "Украина"),
          StoreProductBase(id: "15",
            title: "Помидор",
            description: "Украина"),
        ]);
        break;
    }

    return Future<BuiltList<StoreProductBase>>.delayed(Duration(seconds: 1),
                                                       () => result);
  }

  // Internal methods

  MockStoreRepository._setup() {
    // Initialization logic here.
  }

  // Internal fields

  static final _instance = new MockStoreRepository._setup();

}