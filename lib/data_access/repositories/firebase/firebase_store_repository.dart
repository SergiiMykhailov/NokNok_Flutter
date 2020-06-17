import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:nok_nok/data_access/repositories/base/store_repository.dart';
import 'package:nok_nok/models/store_category_item.dart';
import 'package:nok_nok/models/store_product_base.dart';

import 'package:built_collection/built_collection.dart';

class FirebaseStoreRepository extends StoreRepository {

  // Public methods and properties

  FirebaseStoreRepository({
    @required DatabaseReference storeNode
  }) :
    _storeNode = storeNode {
    assert(_storeNode != null);
  }

  // Overridden methods

  @override
  Future<BuiltList<StoreCategoryItem>> fetchAllCategories() async {
    final categories = <StoreCategoryItem>[];
    return BuiltList<StoreCategoryItem>.from(categories);
  }

  @override
  Future<BuiltList<StoreProductBase>> fetchBaseProductsForCategory(StoreCategoryItem productsCategory) async {
    var result = <StoreProductBase>[];

    final productsNode = _storeNode.child(_ProductsNodeName);
    if (productsCategory == null) {
      final allProductNodesSnapshot = await productsNode.once();
      final List<dynamic> allProductNodes = allProductNodesSnapshot.value;

      for (var productNode in allProductNodes) {
        final Map<dynamic, dynamic> nodeMap = productNode;
        final parsedProduct = StoreProductBase.fromJSON(nodeMap);

        if (parsedProduct != null) {
          final imageSnapshot =  _storage.child(_ProductsNodeName).child(parsedProduct.imageUrl);
          final resolvedImageUrl = await imageSnapshot.getDownloadURL();
          final productWithResolvedImageUrl = StoreProductBase(id: parsedProduct.id,
            title: parsedProduct.title,
            description: parsedProduct.description,
            price: parsedProduct.price,
            imageUrl: resolvedImageUrl);

          result.add(productWithResolvedImageUrl);
        }
      }
    }

    return BuiltList<StoreProductBase>.from(result);
  }

  // Internal methods

  // Internal fields

  final DatabaseReference _storeNode;
  final _storage = FirebaseStorage.instance.ref();

  static const _ProductsNodeName = 'products';

}