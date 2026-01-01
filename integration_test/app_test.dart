import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:office_office/office.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:office_office/core/constants/strings.dart';
import 'package:office_office/core/get_it.dart' as di;
import 'package:office_office/core/helpers/sharedpref_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    // 1️⃣ mock shared preferences
    SharedPreferences.setMockInitialValues({});
    await SharedprefHelper.cacheInitialization();
    await di.init();
  });

  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify counter', (
      tester,
    ) async {
      // Load app widget.
      AppConstants.savedToken = "dummy_token"; 
      AppConstants.role = "employee";
      await tester.pumpWidget(officeOffice(initialLanguage: Locale("en")));

      await tester.pumpAndSettle();

      final usernameField = find.byKey(ValueKey('usernameField'));
      final passwordField = find.byKey(ValueKey('passwordField'));
      final loginButton = find.byKey(ValueKey('loginButton'));
      expect(usernameField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(loginButton, findsOneWidget);
      await tester.enterText(usernameField, 'Seham');
      await tester.enterText(passwordField, '12345678');
      await tester.tap(loginButton);

      await tester.pumpAndSettle();
      expect(find.byKey(const Key('BottomNavigation')), findsOneWidget);
      // await tester.pumpAndSettle();
    });
  });
}
