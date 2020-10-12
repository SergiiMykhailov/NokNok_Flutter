import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:nok_nok/data_access/publishers/base/order_publisher.dart';
import 'package:nok_nok/data_access/repositories/base/store_repository.dart';
import 'package:nok_nok/models/basket.dart';
import 'package:nok_nok/models/store_category_item.dart';
import 'package:nok_nok/models/store_delivery_time_slot.dart';
import 'package:nok_nok/models/store_product_base.dart';

import 'package:built_collection/built_collection.dart';

class FirebaseStoreRepository extends StoreRepository {

  // Public methods and properties

  FirebaseStoreRepository({
    @required DatabaseReference storeNode,
    @required OrderPublisher orderPublisher
  }) :
    _storeNode = storeNode,
    _orderPublisher = orderPublisher {
    assert(_storeNode != null);
    assert(_orderPublisher != null);
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

      for (var nodeIndex = 0;
           nodeIndex < allProductNodes.length;
           ++nodeIndex) {
        final productNode = allProductNodes[nodeIndex];
        final Map<dynamic, dynamic> nodeMap = productNode;
        final parsedProduct = StoreProductBase.fromJSON(nodeMap);

        if (parsedProduct != null) {
          if (parsedProduct.resolvedImageUrl != null) {
            result.add(parsedProduct);
          }
          else {
            final imageSnapshot = _storage.child(_ProductsNodeName).child(
              parsedProduct.imageUrl);
            var resolvedImageUrl = '';

            try {
              resolvedImageUrl = await imageSnapshot.getDownloadURL();
            }
            catch (exception) {}

            final productWithResolvedImageUrl = StoreProductBase(
              id: parsedProduct.id,
              title: parsedProduct.title,
              description: parsedProduct.description,
              price: parsedProduct.price,
              imageUrl: parsedProduct.imageUrl,
              resolvedImageUrl: resolvedImageUrl
            );

            result.add(productWithResolvedImageUrl);
            
            // Store resolved image URL so it can be reused in the next session
            final productNodeName = '$nodeIndex';
            final productJSON = productWithResolvedImageUrl.toJSON();
            _storeNode.child(_ProductsNodeName)
                      .child(productNodeName)
                      .set(productJSON);
          }
        }
      }
    }

    return BuiltList<StoreProductBase>.from(result);
  }

  @override
  Basket getBasket() {
    return _basket;
  }

  @override
  Future<BuiltList<DeliveryTimeSlot>> getDeliveryTimeSlots(String address) async {
    var result = <DeliveryTimeSlot>[];

    final deliveryTimeNode = _storeNode.child(_DeliveryTimeNodeName);
    if (deliveryTimeNode != null) {
      final allDeliveryTimeSlotsSnapshot = await deliveryTimeNode.once();
      final List<dynamic> allDeliveryTimeNodes = allDeliveryTimeSlotsSnapshot.value;

      for (var deliveryTimeNode in allDeliveryTimeNodes) {
        final Map<dynamic, dynamic> nodeMap = deliveryTimeNode;
        final parsedTimeSlot = DeliveryTimeSlot.fromJSON(nodeMap);

        if (parsedTimeSlot != null &&
            parsedTimeSlot.address == address) {
          result.add(parsedTimeSlot);
        }
      }
    }

    return BuiltList<DeliveryTimeSlot>.from(result);
  }

  @override
  Future<String> postOrder(String dayOfWeek,
                           DeliveryTimeSlot timeSlot,
                           String address,
                           String userName,
                           String userPhoneNumber) async {
    final orderId = await _orderPublisher.publishOrder(dayOfWeek,
                                                       timeSlot,
                                                       _basket,
                                                       address,
                                                       userName,
                                                       userPhoneNumber);
    return orderId;
  }

  // Internal fields

  final _basket = Basket();

  final DatabaseReference _storeNode;
  final OrderPublisher _orderPublisher;
  final _storage = FirebaseStorage.instance.ref();

  static const _ProductsNodeName = 'products';
  static const _DeliveryTimeNodeName = 'deliverySlots';

}