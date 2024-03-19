import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_story_app/data/model/stories/stories_response.dart';
import 'package:my_story_app/theme/color_schemes.dart';
import 'package:my_story_app/theme/text_style.dart';

class MyDetailScreen extends StatefulWidget {
  final ListStory listStory;

  const MyDetailScreen({super.key, required this.listStory});

  @override
  State<MyDetailScreen> createState() => _MyDetailScreenState();
}

class _MyDetailScreenState extends State<MyDetailScreen> {
  late GoogleMapController mapController;
  final Set<Marker> markers = {};
  late LatLng userLocation;
  late List<Placemark> placemarks;

  @override
  void initState() {
    super.initState();
    userLocation = LatLng(widget.listStory.lat!, widget.listStory.lon!);
    initializePlacemarks();
  }

  Future<void> initializePlacemarks() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        widget.listStory.lat!, widget.listStory.lon!);

    if (placemarks.isNotEmpty) {
      var placemark = placemarks.first;
      var address = "${placemark.street}, ${placemark.locality}, ${placemark.postalCode}";

      final marker = Marker(
        markerId: MarkerId(widget.listStory.name),
        position: userLocation,
        infoWindow: InfoWindow(title: placemark.name, snippet: address),
        onTap: () async {
          mapController.animateCamera(
            CameraUpdate.newLatLngZoom(userLocation, 18),
          );
        },
      );

      setState(() {
        markers.add(marker);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                FadeInImage.assetNetwork(
                  placeholder: 'assets/images/placeholder.png',
                  image: widget.listStory.photoUrl,
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                  height: 300,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/images/image_not_available.jpg',
                        fit: BoxFit.cover);
                  },
                ),
                const SafeArea(
                  child: BackButton(color: Color(primaryColor)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.listStory.name,
                style: myTextTheme.titleMedium?.copyWith(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.listStory.description,
                style: myTextTheme.labelSmall?.copyWith(color: Colors.black45),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      zoom: 18,
                      target: userLocation,
                    ),
                    markers: markers,
                    onMapCreated: (controller) {
                      setState(() {
                        mapController = controller;
                      });
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
