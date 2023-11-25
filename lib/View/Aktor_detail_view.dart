import 'package:flutter/material.dart';
import 'package:movie_apps/model/model_detail_aktor.dart';

TextStyle priceTextStyle = const TextStyle(
    color: Color.fromARGB(255, 255, 255, 255),
    fontSize: 20,
    fontWeight: FontWeight.bold);

class AktorDetail extends StatefulWidget {
  final String aktorId;
  const AktorDetail({Key? key, required this.aktorId}) : super(key: key);
  @override
  State<AktorDetail> createState() => _AktorDetailState();
}

class _AktorDetailState extends State<AktorDetail> {
  late DetailAktor detailAktor = const DetailAktor(
    id: '',
    name: '',
    profilePath: '',
    placeOfBirth: '',
    biography: '',
    birthday: '',
  );

  @override
  void initState() {
    super.initState();
    _getAktorDetail(widget.aktorId);
  }

  _getAktorDetail(String id) async {
    try {
      DetailAktor detail = await DetailAktor.fetchActorDetails(id);
      setState(() {
        detailAktor = detail;
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
            expandedHeight: 500.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              title: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(134, 2, 2, 2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0)
                  ),
                ),
                padding: const EdgeInsets.all(8.0),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  detailAktor.name,
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Color.fromARGB(255, 250, 245, 245),
                  ),
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(detailAktor.profilePath),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Image.network(
                      detailAktor.profilePath,
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.favorite_border),
                color: const Color.fromARGB(255, 255, 255, 255),
                tooltip: 'Favorites',
                onPressed: () {/* ... */},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: const Color.fromARGB(255, 134, 2, 2),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Text("Profile Actor".toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold))),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 15),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 150, // Panjang tetap untuk label "Name"
                        child: Text(
                          "Name :",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          detailAktor.name,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width:
                            150, // Panjang tetap untuk label "Place of Birth"
                        child: Text(
                          "Place of Birth :",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          detailAktor.placeOfBirth,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width:
                            150, // Panjang tetap untuk label "Place of Birth"
                        child: Text(
                          "Birthday :",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          detailAktor.birthday,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width:
                            150, 
                        child: Text(
                          "Biography :",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          detailAktor.biography,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
