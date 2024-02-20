import 'package:app/application/bloc/gps/alarm_gps_bloc.dart';
import 'package:app/presentation/components/jay_floating_action_button.dart';
import 'package:app/presentation/utils/map_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;

  MapType _currentMapType = MapType.normal;

  final Set<Marker> _markers = {};

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
  Widget build(final BuildContext context) => BlocProvider(
        create: (final context) => AlarmGpsBloc()..add(AlarmGpsStarted()),
        child: Scaffold(
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<AlarmGpsBloc, AlarmGpsState>(
                builder: (final context, final state) {
                  if (state is AlarmGpsLoadSuccess) {
                    return JayFloatingActionButton(
                      onPressed: () {
                        MapUtils.openMap(state.latitude, state.longitude);
                      },
                      iconData: Icons.navigation,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 10),
              JayFloatingActionButton(
                onPressed: () {
                  setState(() {
                    _currentMapType = (_currentMapType == MapType.normal) ? MapType.satellite : MapType.normal;
                  });
                },
                iconData: Icons.layers,
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          body: BlocListener<AlarmGpsBloc, AlarmGpsState>(
            listener: (final context, final state) {
              if (state is AlarmGpsLoadSuccess) {
                _mapController.animateCamera(CameraUpdate.newLatLng(LatLng(state.latitude, state.longitude)));
                _markers.clear();

                final Marker marker = Marker(
                  markerId: const MarkerId('marker_1'),
                  position: LatLng(state.latitude, state.longitude),
                );
                setState(() {
                  _markers.add(marker);
                });
              }
            },
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              mapType: _currentMapType,
              markers: _markers,
              mapToolbarEnabled: false,
            ),
          ),
        ),
      );

  void _onMapCreated(final GoogleMapController controller) {
    _mapController = controller;
  }
}
