import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Model for Location
class AqabaLocation {
  final int id;
  final String title;
  final String type;
  final double lat;
  final double lng;

  AqabaLocation({
    required this.id,
    required this.title,
    required this.type,
    required this.lat,
    required this.lng,
  });

  LatLng get latLng => LatLng(lat, lng);
}

// List of locations in Aqaba
final List<AqabaLocation> aqabaLocations = [
  AqabaLocation(
    id: 1,
    title: 'Aqaba Fort',
    type: 'Historical Site',
    lat: 29.5265,
    lng: 35.0078,
  ),
  AqabaLocation(
    id: 2,
    title: 'Aqaba Marine Park',
    type: 'Nature',
    lat: 29.4562,
    lng: 34.9793,
  ),
];

class MapScreen extends StatefulWidget {
  final List<AqabaLocation> locations;

  const MapScreen({Key? key, required this.locations}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  late CameraPosition _initialCameraPosition;

  @override
  void initState() {
    super.initState();
    _initialCameraPosition = CameraPosition(
      target: widget.locations.isNotEmpty
          ? widget.locations.first.latLng
          : LatLng(29.5319, 35.0061),
      zoom: 14,
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onMarkerTapped(AqabaLocation location) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${location.title} - ${location.type}'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Explore Aqaba')),
      body: widget.locations.isEmpty
          ? Center(child: Text('لا توجد مواقع متاحة'))
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: _initialCameraPosition,
              markers: widget.locations
                  .map((location) => Marker(
                        markerId: MarkerId(location.id.toString()),
                        position: location.latLng,
                        infoWindow: InfoWindow(
                          title: location.title,
                          snippet: location.type,
                        ),
                        onTap: () => _onMarkerTapped(location),
                      ))
                  .toSet(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Move camera to the default center
          mapController.animateCamera(
            CameraUpdate.newLatLngZoom(
                LatLng(29.5319, 35.0061), 14),
          );
        },
        child: Icon(Icons.my_location),
        backgroundColor: Colors.blue,
      ),
    );
  }
}