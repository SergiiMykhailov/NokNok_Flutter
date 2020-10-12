import 'package:flutter/cupertino.dart';
import 'package:nok_nok/data_access/repositories/base/store_repository.dart';

abstract class StoreScreenRouter {

  void navigateToBasket(BuildContext context, StoreRepository storeRepository);

}