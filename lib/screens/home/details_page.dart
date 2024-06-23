import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:projek/komponen/like_button.dart';
import 'package:projek/services/favorite_service.dart';
import 'package:projek/screens/home/google_maps_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/reuseable_text.dart';
import 'package:projek/models/wisata.dart';

class DetailsPage extends StatefulWidget {
  final String wisataId;

  const DetailsPage({
    super.key,
    required this.wisataId,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  TextEditingController datetimeinput = TextEditingController();
  int selected = 0;
  final EdgeInsetsGeometry padding =
      const EdgeInsets.symmetric(horizontal: 20.0);
  dynamic current;
  List<Marker> markers = [];
  Wisata? wisata;
  bool _isFavorite = false;
  double _rating = 0.0;

  @override
  void initState() {
    super.initState();
    fetchLocations();
    _fetchWisataDetails();
  }

  void toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
      wisata!.isFavorite = _isFavorite;
    });

    if (_isFavorite) {
      FavoriteService.addToFavorites(wisata!);
    } else {
      FavoriteService.removeFromFavorites(wisata!.id!);
    }
  }

  Future<void> fetchLocations() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('locations').get();
      List<DocumentSnapshot> documents = snapshot.docs;

      setState(() {
        markers = documents.map((doc) {
          GeoPoint geoPoint = doc['location'];
          return Marker(
            markerId: MarkerId(doc.id),
            position: LatLng(geoPoint.latitude, geoPoint.longitude),
            infoWindow: InfoWindow(title: doc['name']),
          );
        }).toList();
      });
    } catch (e) {
      print("Error fetching locations: $e");
    }
  }

  Future<void> _launchMaps(double latitude, double longitude) async {
    Uri googleUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
    if (await canLaunch(googleUrl.toString())) {
      await launch(googleUrl.toString());
    } else {
      print('Could not open the map.');
    }
  }

  Future<void> _fetchWisataDetails() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("No user is signed in");
      return;
    }

    final userId = user.uid;

    // Get the Wisata document
    final docRef = FirebaseFirestore.instance
        .collection('Destinations')
        .doc(widget.wisataId);
    final docSnapshot = await docRef.get();

    if (!docSnapshot.exists) {
      print("Wisata not found with ID: ${widget.wisataId}");
      return;
    }

    final fetchedWisata = Wisata.fromDocument(docSnapshot);

    // Check if the Wisata is in the user's favorites
    final favDocRef = FirebaseFirestore.instance
        .collection('Destination_favorites')
        .doc('${widget.wisataId}');
    final favDocSnapshot = await favDocRef.get();

    setState(() {
      wisata = fetchedWisata;
      _isFavorite = favDocSnapshot.exists;
      wisata!.isFavorite = _isFavorite;
      // Get current rating
    });
  }

  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 24,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: wisata == null
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              width: size.width,
              height: size.height,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    right: 0,
                    child: wisata!.imageUrl != null &&
                            Uri.parse(wisata!.imageUrl!).isAbsolute
                        ? Hero(
                            tag: wisata!.name,
                            child: Image.network(
                              wisata!.imageUrl!,
                              fit: BoxFit.cover,
                              width: size.width,
                              height: size.height * 0.45,
                            ),
                          )
                        : Container(
                            color: Theme.of(context).backgroundColor,
                          ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: padding,
                      width: size.width,
                      height: size.height * 0.65,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeInUp(
                              delay: const Duration(milliseconds: 200),
                              child: Padding(
                                padding:
                                    EdgeInsets.only(top: size.height * 0.02),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppText(
                                          text: wisata!.name,
                                          size: 28,
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                    LikeButton(
                                      isLiked: _isFavorite,
                                      onTap: toggleFavorite,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            FadeInUp(
                              delay: const Duration(milliseconds: 300),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.monetization_on,
                                    color: Theme.of(context).iconTheme.color,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 10),
                                  AppText(
                                    text: "\Rp. " + wisata!.harga,
                                    size: 20,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            FadeInUp(
                              delay: const Duration(milliseconds: 400),
                              child: Row(
                                children: [
                                  RatingBarIndicator(
                                    rating: wisata!.rating ?? 0,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 20.0,
                                    direction: Axis.horizontal,
                                    unratedColor: Colors.grey,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    wisata!.rating.toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FadeInUp(
                                  delay: const Duration(milliseconds: 1000),
                                  child: AppText(
                                    text: "Deskripsi",
                                    size: 22,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                FadeInUp(
                                  delay: const Duration(milliseconds: 1000),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.map,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                    onPressed: wisata?.latitude != null &&
                                            wisata?.longitude != null
                                        ? () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    GoogleMapsScreen(
                                                  latitude: wisata!.latitude,
                                                  longitude: wisata!.longitude,
                                                ),
                                              ),
                                            );
                                          }
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.01),
                            FadeInUp(
                              delay: const Duration(milliseconds: 1100),
                              child: Text(
                                wisata!.description,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.04),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
