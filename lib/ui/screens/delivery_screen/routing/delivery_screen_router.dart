import 'package:flutter/cupertino.dart';
import 'package:nok_nok/data_access/repositories/base/store_repository.dart';

abstract class DeliveryScreenRouter {

  void navigateBack(BuildContext context);
  void navigateToTimeSlotSelection(BuildContext context, String address, StoreRepository storeRepository);

}