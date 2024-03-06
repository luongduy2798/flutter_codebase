import '../../model/account.dart';

abstract class LocalStore {
  Future<bool> hasAuthenticated();

  Future setAccessToken(String accessToken);

  Future<String> getAccessToken();

  Future setLoggedAccount(Account account);

  Future<Account?> getLoggedAccount();

  Future removeCredentials();

  Future<bool> containsKey(String key);

  Future<bool> removeKey(String key);

  Future<bool> clear();

  Future reload();

  Future saveCredentials(String accessToken, Account account);
}
