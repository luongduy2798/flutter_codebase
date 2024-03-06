part of 'authentication_bloc.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

enum LogoutStatus { initial, loading, finish }

enum LoginStateStatus { initial, loading, success, failure }

@immutable
class AuthenticationState extends BaseBlocState {
  const AuthenticationState({
    this.loginStatus = LoginStateStatus.initial,
    this.status = AuthenticationStatus.unknown,
    this.logoutStatus = LogoutStatus.initial,
    this.user,
    ResponseError? error = const ResponseError(),
  }) : super(error: error);

  final LoginStateStatus loginStatus;
  final AuthenticationStatus status;
  final LogoutStatus logoutStatus;
  final Account? user;

  AuthenticationState copyWith({
    LoginStateStatus? loginStatus,
    AuthenticationStatus? status,
    LogoutStatus? logoutStatus,
    Account? user,
    ResponseError? error,
  }) {
    return AuthenticationState(
      user: user ?? this.user,
      loginStatus: loginStatus ?? this.loginStatus,
      status: status ?? this.status,
      logoutStatus: logoutStatus ?? this.logoutStatus,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        user,
        status,
        loginStatus,
        logoutStatus,
      ];
}
