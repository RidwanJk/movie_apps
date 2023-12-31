import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_apps/placeholder/assets.dart';

class Setting extends StatefulWidget {
  final String? username;

  Setting({Key? key, required this.username}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  late String? username;

  @override
  void initState() {
    super.initState();
    username = widget.username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(avatars[1]),
              ),
              const SizedBox(height: 30.0),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Text(
                  username ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              Text(
                "UIN Jawa",
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 30.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  fixedSize: Size(250, 75),
                  onPrimary: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                ),
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                    // Navigate to your login or authentication page
                    Navigator.of(context).pushReplacementNamed('/login');
                  } catch (e) {
                    print('Error signing out: $e');
                    // Handle sign-out error
                  }
                },
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
