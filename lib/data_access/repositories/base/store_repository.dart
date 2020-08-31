import 'package:nok_nok/models/basket.dart';
import 'package:nok_nok/models/store_category_item.dart';

import 'package:built_collection/built_collection.dart';
import 'package:nok_nok/models/store_delivery_time_slot.dart';
import 'package:nok_nok/models/store_product_base.dart';

// Interface which declares all methods for working with single store.
abstract class StoreRepository {

  Future<BuiltList<StoreCategoryItem>> fetchAllCategories();

  Future<BuiltList<StoreProductBase>> fetchBaseProductsForCategory(StoreCategoryItem productsCategory);

  Basket getBasket();

  Future<BuiltList<DeliveryTimeSlot>> getDeliveryTimeSlots(String address);

  // Posts order and returns order ID.
  Future<String> postOrder(DeliveryTimeSlot timeSlot,
                           String address,
                           String userName,
                           String userPhoneNumber);

}