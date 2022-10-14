import 'package:flutter/material.dart';
import 'package:flutter_covid_tracker/screens/home_page.dart';
import 'package:flutter_covid_tracker/screens/profile_page.dart';
import 'package:flutter_covid_tracker/screens/signup_page.dart';
import 'package:flutter_covid_tracker/widgets/shared.dart';
import 'package:flutter_covid_tracker/widgets/theme.dart';
import 'package:flutter_covid_tracker/widgets/url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Constants.prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Flutter Covid Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        routeInformationParser: VxInformationParser(),
        routerDelegate: VxNavigator(routes: {
          MyUrl.rootPage: (uri, params) => MaterialPage(
              child: Constants.prefs.getString("userName") == null
                  ? const SignUpPage()
                  : const HomePage()),
          MyUrl.homePage: (uri, params) =>
              const MaterialPage(child: HomePage()),
          MyUrl.signUpPage: (uri, params) =>
              const MaterialPage(child: SignUpPage()),
          MyUrl.profilePage: (uri, params) =>
              const MaterialPage(child: ProfilePage()),
        }));
  }
}
