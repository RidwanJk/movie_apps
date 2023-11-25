import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:movie_apps/Auth/auth_service.dart';
import 'package:movie_apps/View/Login_view.dart';
import 'package:movie_apps/placeholder/assets.dart';

class RegisterKu extends StatefulWidget {
  const RegisterKu({super.key});

  @override
  State<RegisterKu> createState() => _RegisterKuState();
}

class _RegisterKuState extends State<RegisterKu> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(images[0]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  foregroundDecoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                if (MediaQuery.of(context).viewInsets == EdgeInsets.zero)
                  const Padding(
                    padding: EdgeInsets.only(top: kToolbarHeight),
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                Animator<double>(
                  triggerOnInit: true,
                  curve: Curves.easeIn,
                  tween: Tween<double>(begin: -1, end: 0),
                  builder: (context, state, child) {
                    return FractionalTranslation(
                      translation: Offset(state.value, 0),
                      child: child,
                    );
                  },
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ListView(
                      physics:
                          MediaQuery.of(context).viewInsets == EdgeInsets.zero
                              ? const NeverScrollableScrollPhysics()
                              : null,
                      padding: const EdgeInsets.all(32.0),
                      shrinkWrap: true,
                      children: [
                        const SizedBox(height: kToolbarHeight),
                        Text(
                          "Register Akun Gratis!",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20.0),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 32.0),
                            suffixIcon: const Icon(
                              Icons.person,
                              color: Colors.blueGrey,
                            ),
                            hintText: "Email",
                            hintStyle: const TextStyle(color: Colors.blueGrey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        TextField(
                          controller: _userController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 32.0),
                            suffixIcon: const Icon(
                              Icons.person,
                              color: Colors.blueGrey,
                            ),
                            hintText: "Username",
                            hintStyle: const TextStyle(color: Colors.blueGrey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 32.0),
                            suffixIcon: const Icon(
                              Icons.lock,
                              color: Colors.blueGrey,
                            ),
                            hintText: "Password",
                            hintStyle: const TextStyle(color: Colors.blueGrey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                          ),
                          child: const Text("Already Have an Account?"),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LoginKu(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (MediaQuery.of(context).viewInsets == EdgeInsets.zero)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(32.0),
                elevation: 0,
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepOrange,
              ),
              child: Text("Register".toUpperCase()),
              onPressed: () async {
                final message = await AuthService().registration(
                  username: _userController.text,
                  email: _emailController.text,
                  password: _passwordController.text,
                );
                if (message!.contains('Success')) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const LoginKu()));
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                  ),
                );
              },
            )
        ],
      ),
    );
  }
}
