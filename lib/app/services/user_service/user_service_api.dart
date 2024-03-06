import 'package:dio/dio.dart';
import '../../model/account.dart';
import '../../utils/api/api.dart';
import 'user_service.dart';

class UserServiceApi extends UserService {
  Dio api = BaseApi().dio;

  @override
  Future<Account> getProfile() async {
    Response result = await api.get('/users/me');
    return Account.fromJson(result.data);
  }

  @override
  Future update(String name, String? img, String? imgUrl) async {
    return await api.patch('/users/me',
        data: {'name': name, 'image': img, 'imageUrl': imgUrl});
  }

  @override
  Future changePassword(String currentPassword, String password) async {
    return await api.patch('/users/me',
        data: {'currentPassword': currentPassword, 'newPassword': password});
  }
}
