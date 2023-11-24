import 'package:flutter/material.dart';
import 'package:movie_apps/model/model_aktor.dart';
import 'package:movie_apps/model/model_detail.dart';

TextStyle priceTextStyle = const TextStyle(
    color: Color.fromARGB(255, 255, 255, 255),
    fontSize: 20,
    fontWeight: FontWeight.bold);

class MovieDetail extends StatefulWidget {
  final String movieId;
  const MovieDetail({Key? key, required this.movieId}) : super(key: key);
  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  late MovieDetails movieDetail = MovieDetails(
    id: '',
    title: '',
    overview: '',
    genres: [],
    cast: [],
    image: '',
  );
  List<Aktor> aktor = [];
  List<CastModel> x = [];

  @override
  void initState() {
    super.initState();
    _getMovieDetail(widget.movieId);
  }

  _getMovieDetail(String id) async {
    try {
      MovieDetails mvDetail = await MovieDetails.fetchMovieDetails(id);
      setState(() {
        movieDetail = mvDetail;
        x = movieDetail.cast;
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
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            expandedHeight: 250.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  movieDetail.title,
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 250, 245, 245)),
                ),
                background: Image(
                  image: NetworkImage(movieDetail.image),
                  fit: BoxFit.fill,
                )),
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
                child: Text("Cast".toUpperCase(),
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
                itemCount: x.length,
                itemBuilder: (BuildContext context, int index) {
                  return _cast(context, index);
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
        ],
      ),
    );
  }

  Widget _cast(BuildContext context, int index) {
    return InkWell(
      onTap: () {},
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
              image: DecorationImage(
                image: NetworkImage(
                    "https://image.tmdb.org/t/p/w500" + x[index].profilePath),
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
              color: const Color.fromARGB(64, 0, 0, 0),
              child: Text(
                x[index].name,
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
}
