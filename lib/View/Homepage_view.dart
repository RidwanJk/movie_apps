import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:movie_apps/View/Movie_detail_view.dart';
import 'package:movie_apps/model/modal_movie.dart';
import 'package:movie_apps/placeholder/assets.dart';
import 'package:movie_apps/widgets/network_image.dart';

class Homepage extends StatefulWidget {
  final String? username;

  const Homepage({Key? key, required this.username}) : super(key: key);
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Movie> movies = [];
  List<Movie> nowplaying = [];
  List<Movie> othermovies = [];
  String? username;
  @override
  void initState() {
    super.initState();
    _fetchMovies();
    _fetchPlayingMovie();
    _otherMovie();
    username = widget.username;
  }

  _fetchMovies() async {
    try {
      List<Movie> fetchedMovies = await Movie.fetchMovies();
      setState(() {
        movies = fetchedMovies;
      });
    } catch (e) {
      print('Error fetching movies: $e');
    }
  }

  _fetchPlayingMovie() async {
    try {
      List<Movie> fetchPlayingMovie = await Movie.NowPlayingMovies();
      setState(() {
        nowplaying = fetchPlayingMovie;
      });
    } catch (e) {
      print('Error fetching movies: $e');
    }
  }

  _otherMovie() async {
    try {
      List<Movie> otherList = await Movie.OtherMovie();
      setState(() {
        othermovies = otherList;
      });
    } catch (e) {
      print('Error fetching movies: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            expandedHeight: 150.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                'Enjoy Your Movie ' + username!,
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Color.fromARGB(255, 250, 245, 245)),
              ),
              background: PNetworkImage(images[0], fit: BoxFit.cover),
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
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Color.fromARGB(255, 134, 2, 2),
                ),
                child: Text("Top Rated Movies".toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold))),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              height: 200,
              margin: const EdgeInsets.only(top: 15),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (BuildContext context, int index) {
                  return _featuredMovie(context, index);
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Color.fromARGB(255, 134, 2, 2),
                ),
                margin: const EdgeInsets.only(top: 10.0),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      MaterialButton(
                          onPressed: () {},
                          child: Text("Now Playing".toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    ],
                  ),
                )),
          ),
          SliverToBoxAdapter(
            child: _buildSlider(),
          ),
          SliverToBoxAdapter(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Color.fromARGB(255, 134, 2, 2),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Text("Another Movie For You".toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold))),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              height: 200,
              margin: const EdgeInsets.only(top: 15),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: othermovies.length,
                itemBuilder: (BuildContext context, int index) {
                  return _othermovie(context, index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _othermovie(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        String movieId = othermovies[index].id;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetail(movieId: movieId),
          ),
        );
      },
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey,
              image: DecorationImage(
                image: NetworkImage(othermovies[index].poster_path),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: 150,
            height: 200,
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
              color: const Color.fromARGB(73, 0, 0, 0),
              child: Text(
                othermovies[index].title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
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

  Widget _featuredMovie(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        String movieId = movies[index].id;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetail(movieId: movieId),
          ),
        );
      },
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey,
              image: DecorationImage(
                image: NetworkImage(movies[index].poster_path),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: 150,
            height: 200,
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
              color: const Color.fromARGB(73, 0, 0, 0),
              child: Text(
                movies[index].title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
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
          return Stack(
            fit: StackFit.expand,
            children: [
              PNetworkImage(
                nowplaying[index].backdrop_path,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  color: const Color.fromARGB(73, 0, 0, 0),
                  child: Text(
                    nowplaying[index].title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        itemCount: nowplaying.length,
        pagination: const SwiperPagination(),
      ),
    );
  }
}
