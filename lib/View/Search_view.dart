import 'package:flutter/material.dart';
import 'package:movie_apps/placeholder/assets.dart';

TextStyle priceTextStyle = const TextStyle(
    color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold);

class SearchView extends StatelessWidget {
  const SearchView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 0, 0),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
        title: const Text('Search Movie'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Perform search action
              print('Search button tapped');
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: searchbar(context),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
            child: Text(
              "Categories",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Container(
            width: double.infinity,
            height: 150,
            margin: const EdgeInsets.only(top: 15),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              itemBuilder: (BuildContext context, int index) {
                return _categoryList(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
            child: Text(
              "Featured Products",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 10),
          Container(
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
          Container(
            width: double.infinity,
            color: Colors.black,
            height: 60.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                children: <Widget>[
                  Text(
                    "Premium",
                    style: TextStyle(color: Colors.white),
                    selectionColor: Colors.white,
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      print("hello");
                    },
                    child: const Text("View all"),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          ...[1, 2, 3, 4, 5].map(
            (product) => ProductListItem(
              onPressed: () {},
            ),
          ),
          const SizedBox(height: 10.0),
        ],
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
                "Sofa Set",
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
          const Text("Tables")
        ],
      ),
    );
  }
}

class ProductListItem extends StatelessWidget {
  final Function onPressed;
  const ProductListItem({Key? key, required this.onPressed}) : super(key: key);

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
                  image: NetworkImage(images[1]),
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
                            const Text("Paid Movie"),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.shopping_cart),
                        onPressed: () {
                          print('tapped');
                        },
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
