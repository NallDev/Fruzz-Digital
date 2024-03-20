import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_story_app/provider/form_provider.dart';
import 'package:my_story_app/util/constant.dart';
import 'package:provider/provider.dart';

class MyPickLocationScreen extends StatefulWidget {
  const MyPickLocationScreen({super.key});

  @override
  State<MyPickLocationScreen> createState() => _MyPickLocationScreenState();
}

class _MyPickLocationScreenState extends State<MyPickLocationScreen> {
  GoogleMapController? _mapController;
  Marker? _centerMarker;
  String _address = '', _country = '', _postalCode = '';
  LatLng _lastMapPosition = const LatLng(-6.175542, 106.826073); // Default to Buenos Aires, replace with any default position you like.

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onCameraIdle() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      _lastMapPosition.latitude,
      _lastMapPosition.longitude,
    );

    Placemark place = placemarks[0];
    setState(() {
      _address = '${place.street}, ${place.subLocality}, ${place.locality}';
      _country = place.country!;
      _postalCode = place.postalCode!;
    });
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _lastMapPosition = LatLng(position.latitude, position.longitude);
    });
  }

  void _saveLocation() {
    // Implement your save location logic here, possibly involving sending the data to a backend or local storage.
    print('Saved Location: $_address, $_country, $_postalCode');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            onCameraMove: _onCameraMove,
            onCameraIdle: _onCameraIdle,
            initialCameraPosition: CameraPosition(
              target: _lastMapPosition,
              zoom: 16.0,
            ),
            markers: Set.of(_centerMarker != null ? [_centerMarker!] : []),
          ),
          const Icon(Icons.location_pin, size: 50, color: Colors.red,), // This icon will act as the marker on the center
          Positioned(
            bottom: 50,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 8),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Address: $_address'),
                  Text('Country: $_country'),
                  Text('Postal Code: $_postalCode'),
                  const SizedBox(height: 8),
                  Consumer<FormProvider>(
                    builder: (context, formProvider, child) {
                      return ElevatedButton(
                        onPressed: () {
                          formProvider.setValue(latitude, _lastMapPosition.latitude.toString());
                          formProvider.setValue(longitude, _lastMapPosition.longitude.toString());
                        },
                        child: const Text('Save Location'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
