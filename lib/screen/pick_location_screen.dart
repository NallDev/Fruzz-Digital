import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_story_app/provider/form_provider.dart';
import 'package:my_story_app/theme/text_style.dart';
import 'package:my_story_app/util/constant.dart';
import 'package:my_story_app/util/ui_helper.dart';
import 'package:provider/provider.dart';

import '../theme/color_schemes.dart';
import '../util/common.dart';
import '../widget/button_widget.dart';

class MyPickLocationScreen extends StatefulWidget {
  const MyPickLocationScreen({super.key});

  @override
  State<MyPickLocationScreen> createState() => _MyPickLocationScreenState();
}

class _MyPickLocationScreenState extends State<MyPickLocationScreen> {
  GoogleMapController? _mapController;
  Marker? _centerMarker;
  String _address = '';
  LatLng _lastMapPosition = const LatLng(-6.175542, 106.826073);

  @override
  void initState() {
    super.initState();
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
      _address =
          "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}";
    });
  }

  void _navigateToCurrentLocation() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (!mounted) return;
        return showToast(
            context, AppLocalizations.of(context)!.locationPermission);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (!mounted) return;
      return showToast(
          context, AppLocalizations.of(context)!.locationPermission);
    }
    Position position = await Geolocator.getCurrentPosition();
    _lastMapPosition = LatLng(position.latitude, position.longitude);

    _mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: _lastMapPosition,
      zoom: 16.0,
    )));
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
            zoomControlsEnabled: false,
            buildingsEnabled: false,
            trafficEnabled: false,
            initialCameraPosition: CameraPosition(
              target: _lastMapPosition,
              zoom: 16.0,
            ),
            markers: Set.of(_centerMarker != null ? [_centerMarker!] : []),
          ),
          const Icon(
            Icons.location_pin,
            size: 50,
            color: Colors.red,
          ),
          Positioned(
            bottom: 50,
            child: Container(
              height: 160,
              width: 300,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 8),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    'Address: $_address',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: myTextTheme.labelMedium,
                  )),
                  const SizedBox(height: 8),
                  MyButton.filled(
                    text: AppLocalizations.of(context)!.saveLocation,
                    onPressed: () {
                      context.read<FormProvider>().setValue(
                          latitude, _lastMapPosition.latitude.toString());
                      context.read<FormProvider>().setValue(
                          longitude, _lastMapPosition.longitude.toString());
                      context.pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToCurrentLocation,
        backgroundColor: const Color(darkColor),
        child: const Icon(
          Icons.my_location,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
    );
  }
}
