abstract class AuthService {
  Future login(String phoneNumber, String password, String deviceToken);
  Future sendVerify(String phoneNumber);
  Future resetPassword(String phoneNumber);
  Future confirmRegister(String phoneNumber, String confirmationNumber);
  Future signUp(String name, String phoneNumber, String password, String img,
      String imgUrl);
}
