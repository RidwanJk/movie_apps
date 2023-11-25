import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_apps/placeholder/assets.dart';
import 'package:movie_apps/widgets/swiper_pagination.dart';

class Firstpage extends StatefulWidget {
  const Firstpage({super.key});
  @override
  _FirstpageState createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  final SwiperController _swiperController = SwiperController();
  final int _pageCount = 3;
  int _currentIndex = 0;
  final List<String> titles = [
    "Selamat datang!",
    "Temukan film terkini dan klasik, nikmati penilaian dan ulasan, serta bagikan kegembiraan bersama komunitas pecinta film kami.",
    "Rasakan pengalaman sinematik yang tak terlupakan."
  ];
  final List<Color> pageBgs = [
    const Color.fromARGB(255, 124, 0, 0),
    Colors.grey.shade600,
    const Color.fromARGB(255, 2, 0, 109)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              height: 300,
              margin: const EdgeInsets.only(left: 8.0, right: 8.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Swiper(
                index: _currentIndex,
                controller: _swiperController,
                itemCount: _pageCount,
                onIndexChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                loop: false,
                itemBuilder: (context, index) {
                  return _buildPage(
                      title: titles[index],
                      icon: /*image array image*/ images[index + 2],
                      pageBg: pageBgs[index]);
                },
                pagination: SwiperPagination(
                    builder: CustomPaginationBuilder(
                        activeSize: const Size(10.0, 20.0),
                        size: const Size(10.0, 15.0),
                        color: Colors.grey.shade600)),
              )),
              const SizedBox(height: 10.0),
              _buildButtons(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Container(
      margin: const EdgeInsets.only(right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey.shade600,
            ),
            child: const Text("Skip"),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
          IconButton(
            icon: Icon(_currentIndex < _pageCount - 1
                ? Icons.arrow_forward_ios
                : FontAwesomeIcons.check),
            onPressed: () async {
              if (_currentIndex < _pageCount - 1) {
                _swiperController.next();
              } else {
                Navigator.pushNamed(context, '/login');
              }
            },
          )
        ],
      ),
    );
  }

  Widget _buildPage(
      {required String title, required String icon, Color? pageBg}) {
    const TextStyle titleStyle = TextStyle(
        fontWeight: FontWeight.w500, fontSize: 20.0, color: Colors.white);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 40.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0), color: pageBg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 20.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: titleStyle,
          ),
          const SizedBox(height: 30.0),
          Expanded(
            child: ClipOval(
                child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(icon), fit: BoxFit.cover)),
            )),
          ),
          const SizedBox(height: 50.0),
        ],
      ),
    );
  }
}
