import 'package:dartz/dartz.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/demo_data/user_demo.dart';
import '../../../../core/helpers/sharedpref_helper.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';

class LogOutRepo {
  LogOutRepo();
  Future<RepoResult<Map<String, dynamic>>> logOut() async {
    try {
      final result = AuthDemoData.logout();

      if (result) {
        await SharedprefHelper.clearAllSecuredData();
        await SharedprefHelper.deleteData(key: "role");

        return Right({"message": "Logged out successfully"});
      } else {
        return Left(ApiErrorHandler.handle("Logout failed"));
      }
    } catch (e) {
      logger.d(e.toString());
      return Left(ApiErrorHandler.handle(e));
    }
  }
}
