import 'package:flutter/cupertino.dart';
import 'package:nok_nok/ui/routing/build_context_provider.dart';
import 'package:nok_nok/ui/screens/sign_in_screen/routing/sign_in_screen_router.dart';

import 'sign_in_event.dart';
import 'sign_in_state.dart';

import 'package:bloc/bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {

  // Public methods and properties

  BuildContextProvider buildContextProvider;

  SignInBloc(this._router)
    : super() {
    assert(_router != null);
  }

  void signIn({@required String phoneNumber}) {
  }

  // Overridden methods and properties

  @override
  SignInState get initialState => SignInStateLoading();

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is PerformSignInEvent) {
      yield* _handleSignIn(event.phoneNumber);
    }
  }

  // Internal methods

  Stream<SignInState> _handleSignIn(String phoneNumber) async* {

  }

  // Internal fields

  final SignInScreenRouter _router;

}