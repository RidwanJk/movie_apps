import 'package:flutter/material.dart';
import 'package:movie_apps/View/Homepage_view.dart';
import 'package:movie_apps/View/Landing_Page.dart';
import 'package:movie_apps/View/Login_view.dart';
import 'package:movie_apps/View/Search_view.dart';
import 'package:movie_apps/Widgets/Bottom_Navbar.dart';

void main() {
  runApp(const MyApp());
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Homepage(), // Your custom view widget
      bottomNavigationBar: BotNav(),
    );
  }
}
