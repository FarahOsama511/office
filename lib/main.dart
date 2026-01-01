import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'core/constants/strings.dart';
import 'core/cubit/language/app_language_constant.dart';
import 'core/get_it.dart' as di;
import 'core/helpers/sharedpref_helper.dart';
import 'firebase_options.dart';
import 'local_notification.dart';
import 'push_notification_service.dart';
import 'office.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocalNotificationService.init();
  await PushNotificationService.init();
  await SharedprefHelper.cacheInitialization();
  final currentLanguage =
      SharedprefHelper.getData("LanguageCode") ??
      WidgetsBinding.instance.platformDispatcher.locale;
  final initialLanguage = currentLanguage == "en"
      ? AppLanguageConstant.getEnglishLanguage()
      : AppLanguageConstant.getArabicLanguage();
  AppConstants.savedToken = SharedprefHelper.getData("token");
  AppConstants.role = SharedprefHelper.getData("role");
  logger.d('Saved Token: ${AppConstants.savedToken} ');
  logger.d('Role: ${AppConstants.role}');
  runApp(officeOffice(initialLanguage: initialLanguage));
}
