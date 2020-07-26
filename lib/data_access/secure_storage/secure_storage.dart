import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorageObserver {

  void onSecureStorageLoaded(SecureStorage sender);

}

typedef ObserverIterationBlock = void Function(SecureStorageObserver observer);

class SecureStorage {

  // Public methods and properties

  factory SecureStorage() {
    return _instance;
  }

  bool get isLoaded => _isLoaded;

  void addObserver(SecureStorageObserver observer) {
    _observers.add(observer);
  }

  void removeObserver(SecureStorageObserver observer) {
    _observers.remove(observer);
  }

  String get userName {
    final result = _cache[_KeyUserName];
    return result;
  }

  set userName(String newValue) {
    _cache[_KeyUserName] = newValue;
    _storage.write(key: _KeyUserName, value: newValue);
  }

  String get phoneNumber {
    final result = _cache[_KeyPhoneNumber];
    return result;
  }

  set phoneNumber(String newValue) {
    _cache[_KeyPhoneNumber] = newValue;
    _storage.write(key: _KeyPhoneNumber, value: newValue);
  }

  // Internal methods

  SecureStorage._internal() {
    _storage.readAll().then((Map<String, String> loadedValues) {
      _cache = loadedValues;

      _notifyWithBlock((SecureStorageObserver observer) {
        observer.onSecureStorageLoaded(this);
      });
    });
  }

  void _notifyWithBlock(ObserverIterationBlock block) {
    for (final observer in _observers) {
      block(observer);
    }
  }

  // Internal fields

  static final _instance = new SecureStorage._internal();

  final _storage = new FlutterSecureStorage();
  Map<String, String> _cache = Map<String, String>();
  var _isLoaded = false;
  var _observers = List<SecureStorageObserver>();

  // ignore: non_constant_identifier_names
  static final _KeyUserName = "UserName";
  // ignore: non_constant_identifier_names
  static final _KeyPhoneNumber = "PhoneNumber";

}