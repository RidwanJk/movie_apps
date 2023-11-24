import 'package:flutter/material.dart';
import 'package:movie_apps/model/modal_tv.dart';
import 'package:movie_apps/model/model_aktor.dart';
import 'package:movie_apps/placeholder/assets.dart';

TextStyle priceTextStyle = const TextStyle(
    color: Color.fromARGB(255, 255, 255, 255),
    fontSize: 20,
    fontWeight: FontWeight.bold);

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<Aktor> aktor = [];
  List<TVShow> tv = [];

  @override
  void initState() {
    super.initState();
    _fetchAktor();
    _fetchTV();
  }

  _fetchAktor() async {
    try {
      List<Aktor> fetchActors = await Aktor.fetchActors();
      List<Aktor> tenAktor = fetchActors.take(10).toList();
      setState(() {
        aktor = tenAktor;
      });
    } catch (e) {
      print('Error fetching actors: $e');
    }
  }

  _fetchTV() async {
    try {
      List<TVShow> fetchTV = await TVShow.fetchTVShows();
      List<TVShow> tenTV = fetchTV.take(10).toList();
      setState(() {
        tv = tenTV;
      });
    } catch (e) {
      print('Error fetching TV: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: const Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text(
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              'Directories'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: const Color.fromARGB(255, 255, 255, 255),
            onPressed: () {
              // Perform search action
              print('Search button tapped');
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 2, 0, 0),
              Color.fromARGB(255, 255, 0, 0)
            ], // Adjust the colors as needed
          ),
        ),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: searchbar(context),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
              child: Text("10 Top Rated Actors",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: const Color.fromARGB(255, 241, 241, 241))),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 200,
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: aktor.length,
                itemBuilder: (BuildContext context, int index) {
                  return _topAktor(context, index);
                },
              ),
            ),
            Container(
              width: double.infinity,
              color: const Color.fromARGB(90, 0, 0, 0),
              height: 60.0,
              child: const Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  children: <Widget>[
                    Text(
                      "List TV Populer",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                      selectionColor: Colors.white,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4.0),
            ...tv.map(
              (tvShow) => ProductListItem(
                tvShow: tvShow,
                onPressed: () {
                  // Handle the button press for each TV show
                },
              ),
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  Widget searchbar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white), // Example border
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.white70),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
              ),
              // Implement additional functionalities like suggestions, filtering, etc.
              onSubmitted: (value) {
                // Perform search based on the entered text
                print('Search for: $value');
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.clear, color: Colors.white),
            onPressed: () {
              // Clear search text
              print('Clear search');
            },
          ),
        ],
      ),
    );
  }

  Widget _topAktor(BuildContext context, int index) {
    return InkWell(
      onTap: () {},
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
              image: DecorationImage(
                image: NetworkImage(aktor[index].profilePath),
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
                aktor[index].name,
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

  Widget _categoryList(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black12,
                image: DecorationImage(
                    image: NetworkImage(images[2]), fit: BoxFit.cover)),
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: 100,
            height: 100,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Tables",
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          )
        ],
      ),
    );
  }
}

class ProductListItem extends StatelessWidget {
  final TVShow tvShow;
  final Function onPressed;
  const ProductListItem(
      {Key? key, required this.onPressed, required this.tvShow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: MaterialButton(
        padding: const EdgeInsets.all(0),
        elevation: 0.5,
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: onPressed as void Function()?,
        child: Row(
          children: <Widget>[
            Ink(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  image: NetworkImage(tvShow.posterPath),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                             Text("Name: ${tvShow.name}", style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                             Text("Popularity: ${tvShow.popularity}"),
                             Text("First Air Date: ${tvShow.firstAirDate}"),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
