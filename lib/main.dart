import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_apps/View/Homepage_view.dart';
import 'package:movie_apps/View/Landing_Page.dart';
import 'package:movie_apps/View/Login_view.dart';
import 'package:movie_apps/View/Search_view.dart';
import 'package:movie_apps/Widgets/Bottom_Navbar.dart';
import 'package:movie_apps/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',

      initialRoute: '/', // The landing page route
      routes: {
        '/': (context) => const Firstpage(),
        '/login': (context) => const LoginKu(),
        '/Homepage': (context) => viewWithNav(),
        '/Search': (context) => SearchView(),
      },
    );
  }
}

class viewWithNav extends StatelessWidget {
  final String? username;
  viewWithNav({Key? key, this.username}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (username != null) {
      return Scaffold(
        body: Homepage(username: username), // Pass username to Homepage
        bottomNavigationBar: BotNav(username: username),
      );
    }
    return Text("fail");
  }
}
