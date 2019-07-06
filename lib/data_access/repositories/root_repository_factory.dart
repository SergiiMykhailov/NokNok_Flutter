import 'package:nok_nok/data_access/repositories/dummy/dummy_root_repository.dart';
import 'package:nok_nok/data_access/repositories/interfaces/root_repository.dart';

RootRepository createRootRepository() {
  return DummyRootRepository();
}