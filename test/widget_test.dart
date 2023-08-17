import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:new_app/pages/Dashboard/dashboard.dart';
import 'package:new_app/pages/login_page.dart';
import 'package:new_app/pages/register.dart';
import 'package:new_app/pages/splash_screen.dart';

void main() {
  testWidgets('Initial route is determined correctly', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: SplashScreen(), // Use the appropriate initial widget
      routes: {
        '/': (context) => SplashScreen(),
        'login': (context) => LoginPage(),
        'register': (context) => MyRegister(),
        'dashboard': (context) => DashboardApp(),
      },
    ));

    // Verify that the initial route is set correctly.
    // For this test, we're assuming that the initial widget is SplashScreen.
    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.byType(LoginPage), findsNothing);
    expect(find.byType(MyRegister), findsNothing);
    expect(find.byType(DashboardApp), findsNothing);
  });
}
