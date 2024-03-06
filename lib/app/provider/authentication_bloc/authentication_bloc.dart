import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turtle/app/services/user_service/user_service_api.dart';
import '../../model/account.dart';
import '../../services/auth_service/auth_service_api.dart';
import '../../services/local_store/local_store.dart';
import '../../services/local_store/local_store_service.dart';
import '../../utils/api/response_error.dart';
import '../../utils/base_bloc_state.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc()
      : _localStore = LocalStoreService(),
        super(const AuthenticationState()) {
    on<AuthenticationEvent>(mapEventToState);
    _localStore.hasAuthenticated().then((hasAuthenticated) async {
      add(AuthenticationStatusChanged(hasAuthenticated
          ? AuthenticationStatus.authenticated
          : AuthenticationStatus.unauthenticated));
      if (hasAuthenticated) {
        Account? account = await _localStore.getLoggedAccount();
        add(UpdateUser(account));
      }
    });
  }

  final LocalStore _localStore;
  bool onLoggingOut = false;

  FutureOr<void> mapEventToState(AuthenticationEvent event, emit) async {
    if (event is AuthenticationStatusChanged) {
      await _mapAuthenticationStatusChangedToState(event, emit);
    } else if (event is AuthenticationLogout) {
      await _mapAuthenticationLogoutToState(event, emit);
    } else if (event is Login) {
      await _mapLoginToState(event, emit);
    } else if (event is UpdateUser) {
      await _mapUpdateUserToState(event, emit);
    }
  }

  _mapLoginToState(Login event, emit) async {
    emit(state.copyWith(loginStatus: LoginStateStatus.loading));
    try {
      dynamic data = await AuthServiceApi()
          .login(event.phoneNumber, event.password, event.deviceToken);
      await _localStore.setAccessToken(data['accessToken']);
      Account user = await UserServiceApi().getProfile();
      await _localStore.setLoggedAccount(user);
      emit(state.copyWith(loginStatus: LoginStateStatus.success, user: user));
    } catch (e) {
      emit(state.copyWith(
        loginStatus: LoginStateStatus.failure,
        error: ResponseError.bindResponseError(e),
      ));
    }
  }

  _mapUpdateUserToState(UpdateUser event, emit) async {
    emit(state.copyWith(user: event.user));
  }

  _mapAuthenticationStatusChangedToState(
      AuthenticationStatusChanged event, emit) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        await _localStore.removeCredentials();
        emit(state.copyWith(status: AuthenticationStatus.unauthenticated));
        return;
      case AuthenticationStatus.authenticated:
        emit(state.copyWith(status: AuthenticationStatus.authenticated));
        return;
      default:
        emit(state.copyWith(status: AuthenticationStatus.unknown));
        return;
    }
  }

  _mapAuthenticationLogoutToState(AuthenticationLogout event, emit) async {
    print('logout');
    if (onLoggingOut) {
      return;
    }
    onLoggingOut = true;
    emit(state.copyWith(logoutStatus: LogoutStatus.loading));
    try {
      String accessToken = await _localStore.getAccessToken();
      if (accessToken.isNotEmpty) {
        // await _accountRepos.logout();
      }
      emit(state.copyWith(logoutStatus: LogoutStatus.finish));
    } catch (e) {
      emit(state.copyWith(logoutStatus: LogoutStatus.finish));
    } finally {
      add(AuthenticationStatusChanged(AuthenticationStatus.unauthenticated));
      onLoggingOut = false;
    }
  }
}
