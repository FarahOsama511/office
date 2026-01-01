import 'package:dartz/dartz.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/demo_data/user_demo.dart';
import '../../../../core/helpers/sharedpref_helper.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';

class LoginRepo {
  LoginRepo();

  Future<RepoResult<String>> login(
    String username,
    String password,
    String fcmToken,
  ) async {
    try {
      final response = AuthDemoData.login(username, password);

      if (response != null) {
        await SharedprefHelper.setSecurityString("token", response['token']);
        await SharedprefHelper.setData("role", response["user"]["role"]);
        AppConstants.role = response["user"]["role"];
        AppConstants.savedToken = response['token'];
        logger.d("Login successful for user: ${response["user"]["role"]}");
        return Right(response["user"]["role"]);
      } else {
        logger.d("Login failed for user: $username");
        return Left(
          ApiErrorHandler.handle(
            Exception("اسم المستخدم أو كلمة المرور غير صحيحة"),
          ),
        );
      }
    } catch (e) {
      logger.d(e);
      return Left(ApiErrorHandler.handle(e));
    }
  }
}
