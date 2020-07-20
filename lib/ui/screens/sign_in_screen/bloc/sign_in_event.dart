abstract class SignInEvent {
}

class PerformSignInEvent extends SignInEvent {

  // Public methods and properties

  String get phoneNumber => _phoneNumber;

  PerformSignInEvent(this._phoneNumber);

  // Internal fields

  String _phoneNumber;

}
