import 'package:app/application/bloc/gps/alarm_gps_bloc.dart';
import 'package:app/application/dto/alarm_dto.dart';
import 'package:app/presentation/components/jay_floating_action_button.dart';
import 'package:app/presentation/utils/map_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final AlarmDto detail;
  const MapScreen({super.key, required this.detail});

  @override
  State<StatefulWidget> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;

  MapType _currentMapType = MapType.normal;

  final Set<Marker> _markers = {};

  LatLng? _position = null;

  @override
  Widget build(final BuildContext context) => BlocProvider(
        create: (final context) => AlarmGpsBloc()..add(AlarmGpsStarted(eventId: widget.detail.eventId)),
        child: Scaffold(
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<AlarmGpsBloc, AlarmGpsState>(
                builder: (final context, final state) {
                  if (state is AlarmGpsLoadSuccess) {
                    return JayFloatingActionButton(
                      hero: 'navigate-fab',
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
                hero: 'layers-fab',
                onPressed: () {
                  setState(() {
                    _currentMapType = (_currentMapType == MapType.normal)
                        ? MapType.satellite
                        : MapType.normal;
                  });
                },
                iconData: Icons.layers,
              ),
              SizedBox(
                height: 56,
              )
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          body: BlocListener<AlarmGpsBloc, AlarmGpsState>(
            listener: (final context, final state) {
              if (state is AlarmGpsLoadSuccess) {
                _markers.clear();

                final Marker marker = Marker(
                  markerId: const MarkerId('marker_1'),
                  position: LatLng(state.latitude, state.longitude),
                );
                setState(() {
                  _position =  LatLng(state.latitude, state.longitude);
                  _markers.add(marker);
                });
              }
            },
            child: _position != null ? GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _position!,
                zoom: 11.0,
              ),
              mapType: _currentMapType,
              markers: _markers,
              mapToolbarEnabled: false,
            ) : Center(child: CircularProgressIndicator(),)
          ),
        ),
      );

  void _onMapCreated(final GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }
}
