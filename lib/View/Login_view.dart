import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:movie_apps/Auth/auth_service.dart';
import 'package:movie_apps/View/Register_view.dart';
import 'package:movie_apps/main.dart';
import 'package:movie_apps/placeholder/assets.dart';

class LoginKu extends StatefulWidget {
  const LoginKu({super.key});

  @override
  State<LoginKu> createState() => _LoginKuState();
}

class _LoginKuState extends State<LoginKu> {
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
                      "Movie App",
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
                          "Welcome!",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          "Login to Enjoy Your Movie",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20.0),
                        TextField(
                          controller: _emailController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 32.0),
                            suffixIcon: const Icon(
                              Icons.person,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            hintText: "Email",
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        TextField(
                          obscureText: true,
                          controller: _passwordController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 32.0),
                            suffixIcon: const Icon(
                              Icons.lock,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            hintText: "Password",
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromARGB(255, 221, 0, 0),
                            minimumSize: const Size(150.0, 50.0),
                          ),
                          onPressed: () async {
                            String? username = await AuthService().login(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                            if (username != "Unable to establish connection on channel." &&
                                username !=
                                    "The supplied auth credential is incorrect, malformed or has expired." &&
                                username !=
                                    "We have blocked all request from this device due to unusual activity. Try again later." &&
                                username !=
                                    "The email address is badly formatted.") {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      viewWithNav(username: username),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text(username ?? 'An error occurred'),
                                ),
                              );
                            }
                          },
                          child: const Text('Login'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const RegisterKu(),
                              ),
                            );
                          },
                          child: const Text('Register'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
