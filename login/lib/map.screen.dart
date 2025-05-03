import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const List<Map<String, dynamic>> aqabaLocations = [
  {
    'id': 1,
    'title': 'Aqaba Fort',
    'type': 'Historical Site',
    'lat': 29.5265,
    'lng': 35.0078,
  },
  {
    'id': 2,
    'title': 'Aqaba Marine Park',
    'type': 'Nature',
    'lat': 29.4562,
    'lng': 34.9793,
  },
];

class MapScreen extends StatefulWidget {
  final List<Map<String, dynamic>> locations;

  const MapScreen({required this.locations});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  // Initial camera position
  static const LatLng _center = LatLng(29.5319, 35.0061);
  
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Explore Aqaba')),
      body: widget.locations.isEmpty
          ? Center(child: Text('No locations available'))
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 14,
              ),
              markers: widget.locations.map((location) {
                return Marker(
                  markerId: MarkerId(location['id'].toString()),
                  position: LatLng(location['lat'], location['lng']),
                  infoWindow: InfoWindow(
                    title: location['title'],
                    snippet: location['type'],
                  ),
                );
              }).toSet(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Move camera to the user's location or a default position
          mapController.animateCamera(
            CameraUpdate.newLatLngZoom(_center, 14),
          );
        },
        child: Icon(Icons.my_location),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
