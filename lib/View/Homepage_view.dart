import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:movie_apps/placeholder/assets.dart' as assets;
import 'package:movie_apps/widgets/network_image.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<String> images = [
    assets.images[0],
    assets.backgroundImages[0],
    assets.images[1],
    assets.images[2],
    assets.images[3],
    assets.images[4],
    assets.backgroundImages[1],
    assets.images[5]
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.red,
            expandedHeight: 150.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Welcome To The Cinema'),
              background: PNetworkImage(assets.images[1], fit: BoxFit.cover),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.favorite_border),
                tooltip: 'Favorites',
                onPressed: () {/* ... */},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
                padding: const EdgeInsets.all(20.0),
                color: Color.fromARGB(192, 255, 0, 0),
                child: Text("Anime".toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold))),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              height: 150,
              margin: const EdgeInsets.only(top: 15),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return _featuredProduct(context);
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
                margin: const EdgeInsets.only(top: 20.0),
                color: Color.fromARGB(192, 255, 0, 0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      MaterialButton(
                          onPressed: () {},
                          child: Text("Featured Artist".toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                      MaterialButton(
                          onPressed: () {},
                          child: Text("See All".toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400))),
                    ],
                  ),
                )),
          ),
          SliverToBoxAdapter(
            child: _buildSlider(),
          ),
          SliverToBoxAdapter(
            child: Container(
                padding: const EdgeInsets.all(20.0),
                color: Color.fromARGB(192, 255, 0, 0),
                child: Text("Recommended for you".toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold))),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              height: 150,
              margin: const EdgeInsets.only(top: 15),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return _featuredProduct(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _featuredProduct(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
              image: DecorationImage(
                image: NetworkImage(images[0]),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: 150,
            height: 150,
          ),
          Positioned(
            bottom: 0,
            left: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              color: Colors.black87,
              child: const Text(
                "Movies",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildSlider() {
    return Container(
      padding: const EdgeInsets.only(bottom: 20.0),
      height: 200.0,
      child: Swiper(
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return PNetworkImage(
            images[index],
            fit: BoxFit.cover,
          );
        },
        itemCount: 4,
        pagination: const SwiperPagination(),
      ),
    );
  }

  Widget _buildListItem(int index) {
    return SizedBox(
        height: 100,
        child: Card(
          color: Color.fromARGB(255, 255, 0, 0),
          child: Center(
            child: ListTile(
              leading: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(images[index % images.length]),
              ),
              title: const Text(
                'Movie List',
                softWrap: true,
              ),
            ),
          ),
        ));
  }

  _onTapItem(BuildContext pcontext, int index) {
    Navigator.of(pcontext)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Movie 2'),
        ),
        body: Material(
          child: Container(
            // The blue background emphasizes that it's a new route.
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: Hero(
                          tag: "item$index",
                          child: PNetworkImage(images[index % images.length],
                              fit: BoxFit.cover))),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'Movie 2',
                    softWrap: true,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }));
  }
}
