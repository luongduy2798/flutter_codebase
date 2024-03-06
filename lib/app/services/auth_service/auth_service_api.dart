import 'package:dio/dio.dart';
import '../../utils/api/api.dart';
import 'auth_service.dart';

class AuthServiceApi extends AuthService {
  Dio api = BaseApi().dio;

  @override
  Future login(String phoneNumber, String password, String deviceToken) async {
    Response response = await api.post('/auth/sign-in', data: {
      'id': phoneNumber,
      'password': password,
      'deviceToken': deviceToken
    });
    return response.data;
  }

  @override
  Future sendVerify(String phoneNumber) async {
    return await api
        .post('/auth/send-confirmation', data: {'phone': phoneNumber});
  }

  @override
  Future resetPassword(String phoneNumber) async {
    return await api.post('/auth/reset-password', data: {'phone': phoneNumber});
  }

  @override
  Future confirmRegister(String phoneNumber, String confirmationNumber) async {
    return await api.post('/auth/confirm-sign-up',
        data: {'phone': phoneNumber, 'confirmationNumber': confirmationNumber});
  }

  @override
  Future signUp(String name, String phoneNumber, String password, String img,
      String imgUrl) async {
    return await api.post('/auth/sign-up', data: {
      'phone': phoneNumber,
      'password': password,
      'name': name,
      'image': img,
      'imageUrl': imgUrl
    });
  }
}
