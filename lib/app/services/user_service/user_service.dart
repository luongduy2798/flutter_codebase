abstract class UserService {
  Future<dynamic> getProfile();
  Future update(String name, String? img, String? imgUrl);
  Future changePassword(String currentPassword, String password);
}
