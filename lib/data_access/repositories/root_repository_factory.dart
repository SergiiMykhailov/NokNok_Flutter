import 'package:nok_nok/data_access/repositories/firebase/firebase_root_repository.dart';
import 'package:nok_nok/data_access/repositories/base/root_repository.dart';

RootRepository createRootRepository() {
  return FirebaseRootRepository();
}