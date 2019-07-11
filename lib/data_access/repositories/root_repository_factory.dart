import 'package:nok_nok/data_access/repositories/mock/mock_root_repository.dart';
import 'package:nok_nok/data_access/repositories/base/root_repository.dart';

RootRepository createRootRepository() {
  return MockRootRepository();
}