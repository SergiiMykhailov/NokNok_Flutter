abstract class SignInEvent {
}

class SignInEventRequireSignIn extends SignInEvent {

}

class PerformSignInEvent extends SignInEvent {

  // Public methods and properties

  String get phoneNumber => _phoneNumber;
  String get userName => _userName;

  PerformSignInEvent(this._phoneNumber,
                     this._userName);

  // Internal fields

  final String _phoneNumber;
  final String _userName;

}
