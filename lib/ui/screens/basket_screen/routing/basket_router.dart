import 'package:flutter/cupertino.dart';
import 'package:nok_nok/data_access/repositories/base/store_repository.dart';

abstract class BasketScreenRouter {

  void navigateBack(BuildContext context);
  void navigateToDeliverySettings(BuildContext context, StoreRepository storeRepository);

}