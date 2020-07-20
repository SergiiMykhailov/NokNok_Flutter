abstract class SignInState {
}

class SignInStateLoading extends SignInState {

}

class SignInStateSignedIn extends SignInState {

  // Public methods and properties

  String get phoneNumber => _phoneNumber;

  SignInStateSignedIn(this._phoneNumber);

  // Internal fields

  final String _phoneNumber;

}
