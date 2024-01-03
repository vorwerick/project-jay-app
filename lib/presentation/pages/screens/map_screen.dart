import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;

  MapType _currentMapType = MapType.normal;

  final LatLng _center = const LatLng(50.07474478732811, 14.436800854941344);
  // example marker
  final Marker _marker = const Marker(
    markerId: MarkerId('marker_1'),
    position: LatLng(50.07474478732811, 14.436800854941344),
    infoWindow: InfoWindow(
      title: 'Praha',
      snippet: 'Hlavni mesto',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _currentMapType = (_currentMapType == MapType.normal) ? MapType.satellite : MapType.normal;
          });
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.layers),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        mapType: _currentMapType,
        markers: {_marker},
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }
}
