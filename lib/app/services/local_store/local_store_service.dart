import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/account.dart';
import 'local_store.dart';

class LocalStoreService extends LocalStore {
  static const PREF_ACCESS_TOKEN = 'PREF_ACCESS_TOKEN';
  static const PREF_LOGGED_ACCOUNT = 'PREF_LOGGED_ACCOUNT';
  static const SAVE_OR_NOT_CREDENTIALS = 'SAVE_OR_NOT_CREDENTIALS';
  static const SHOW_BG_LOCATION_ACCESS = 'SHOW_BG_LOCATION_ACCESS';

  @override
  Future<bool> hasAuthenticated() async {
    String accessToken = await getAccessToken();
    Account? account = await getLoggedAccount();
    return accessToken.isNotEmpty && account != null && account.id != null;
  }

  @override
  Future setAccessToken(String sessionId) async {
    (await SharedPreferences.getInstance())
        .setString(PREF_ACCESS_TOKEN, sessionId);
  }

  @override
  Future<String> getAccessToken() async {
    return (await SharedPreferences.getInstance())
            .getString(PREF_ACCESS_TOKEN) ??
        '';
  }

  @override
  Future setLoggedAccount(Account user) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(PREF_LOGGED_ACCOUNT, jsonEncode(user));
  }

  @override
  Future<Account?> getLoggedAccount() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return Account.fromJson(
        jsonDecode(preferences.getString(PREF_LOGGED_ACCOUNT) ?? '{}'));
  }

  @override
  Future saveCredentials(String accessToken, Account account) async {
    await Future.wait([
      setAccessToken(accessToken),
      setLoggedAccount(account),
    ]);
  }

  @override
  Future removeCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Future.wait([
      prefs.remove(PREF_ACCESS_TOKEN),
      prefs.remove(PREF_LOGGED_ACCOUNT),
    ]);
  }

  @override
  Future<bool> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.wait(
        [prefs.remove(PREF_ACCESS_TOKEN), prefs.remove(PREF_LOGGED_ACCOUNT)]);
    return true;
  }

  @override
  Future<bool> containsKey(String key) async =>
      (await SharedPreferences.getInstance()).containsKey(key);

  @override
  Future<bool> removeKey(String key) async =>
      (await SharedPreferences.getInstance()).remove(key);

  @override
  Future reload() async => (await SharedPreferences.getInstance()).reload();
}
