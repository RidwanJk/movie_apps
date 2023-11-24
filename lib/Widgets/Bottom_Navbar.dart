import 'package:flutter/material.dart';
import 'package:movie_apps/View/Homepage_view.dart';
import 'package:movie_apps/View/Search_view.dart';
import 'package:movie_apps/View/Setting.dart';

class BotNav extends StatefulWidget {
  const BotNav({Key? key}) : super(key: key);

  @override
  _BotNavState createState() => _BotNavState();
}

class _BotNavState extends State<BotNav> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        transitionBuilder: (child, animation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0), // Slide from right
              end: Offset.zero,
            ).animate(animation),
            child: FadeTransition(
              opacity: animation,
              child: Material(
                color: Colors.black,
                child: child,
              ),
            ),
          );
        },
        child: _buildPage(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: BottomNavItem(
              isActive: _currentIndex == 0,
              icon: Icons.home,
              title: 'Home',
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: BottomNavItem(
              isActive: _currentIndex == 1,
              icon: Icons.search,
              title: 'Search',
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: BottomNavItem(
              isActive: _currentIndex == 2,
              icon: Icons.security,
              title: 'Account',
            ),
            label: '',
          ),
        ],
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return Homepage();
      case 1:
        return SearchView();
      case 2:
        return Setting();
      default:
        return Homepage(); // Default page to display
    }
  }
}

class BottomNavItem extends StatelessWidget {
  final bool isActive;
  final IconData icon;
  final Color? activeColor;
  final String title;

  const BottomNavItem({
    Key? key,
    required this.isActive,
    required this.icon,
    this.activeColor,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(animation),
          child: Container(
            color: const Color.fromARGB(0, 255, 255, 255), // Set the container color to transparent
            child: child,
          ),
        );
      },
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 200),
      child: isActive
          ? Container(
              color: Colors.transparent,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Container(
                    width: 5.0,
                    height: 5.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            )
          : Icon(
              icon,
              color: Colors.grey,
            ),
    );
  }
}
