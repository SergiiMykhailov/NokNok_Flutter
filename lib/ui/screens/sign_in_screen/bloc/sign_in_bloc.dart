import 'package:flutter/cupertino.dart';
import 'package:nok_nok/data_access/secure_storage/secure_storage.dart';
import 'package:nok_nok/ui/routing/build_context_provider.dart';
import 'package:nok_nok/ui/screens/sign_in_screen/routing/sign_in_screen_router.dart';

import 'sign_in_event.dart';
import 'sign_in_state.dart';

import 'package:bloc/bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState>
                 with SecureStorageObserver {

  // Public methods and properties

  BuildContextProvider buildContextProvider;

  SignInBloc(this._router)
    : super() {
    assert(_router != null);

    _loadCurrentCredentials();
  }

  void signIn({@required String phoneNumber,
               @required String userName}) {
    dispatch(PerformSignInEvent(phoneNumber, userName));
  }

  // Overridden methods and properties

  @override
  SignInState get initialState => SignInStateLoading();

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is PerformSignInEvent) {
      yield* _handleSignIn(event.phoneNumber, event.userName);
    }
    else if (event is SignInEventRequireSignIn) {
      yield SignInStateEmpty();
    }
  }

  @override
  void onSecureStorageLoaded(SecureStorage sender) {
    _handleSettingsLoaded();
  }

  // Internal methods

  void _loadCurrentCredentials() {
    if (!SecureStorage().isLoaded) {
      SecureStorage().addObserver(this);
    }
    else {
      _handleSettingsLoaded();
    }
  }

  void _handleSettingsLoaded() {
    if (SecureStorage().userName != null &&
        SecureStorage().phoneNumber != null) {
      _navigateToStore();
    }
    else {
      dispatch(SignInEventRequireSignIn());
    }
  }

  void _navigateToStore() {
    if (buildContextProvider == null) {
      print('Build context provider is not set for SignInBloc, Unable to navigate to store.');
    }
    else {
      final context = buildContextProvider.getContext();
      _router.navigateToStore(context);
    }
  }

  Stream<SignInState> _handleSignIn(String phoneNumber, String userName) async* {
    SecureStorage().userName = userName;
    SecureStorage().phoneNumber = phoneNumber;

    _navigateToStore();
  }

  // Internal fields

  final SignInScreenRouter _router;

}