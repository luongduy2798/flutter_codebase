part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {}

class AuthenticationStatusChanged extends AuthenticationEvent {
  AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;

  @override
  List<Object?> get props => [status];
}

class AuthenticationLogout extends AuthenticationEvent {
  AuthenticationLogout(this.context);

  final BuildContext context;

  @override
  List<Object?> get props => [
        context,
      ];
}

class Login extends AuthenticationEvent {
  Login(this.phoneNumber, this.password, this.deviceToken);

  final String phoneNumber;
  final String password;
  final String deviceToken;

  @override
  List<Object?> get props => [phoneNumber, password, deviceToken];
}

class UpdateUser extends AuthenticationEvent {
  UpdateUser(this.user);

  final Account? user;

  @override
  List<Object?> get props => [user];
}
