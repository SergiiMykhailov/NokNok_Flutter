abstract class SignInState {
}

class SignInStateLoading extends SignInState {

}

class SignInStateEmpty extends SignInState {

}

class SignInStateSignedIn extends SignInState {

  // Public methods and properties

  String get phoneNumber => _phoneNumber;
  String get userName => _userName;

  SignInStateSignedIn(this._phoneNumber,
                      this._userName);

  // Internal fields

  final String _phoneNumber;
  final String _userName;

}
