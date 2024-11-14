import 'package:app/application/bloc/gps/alarm_gps_bloc.dart';
import 'package:app/application/dto/alarm_dto.dart';
import 'package:app/presentation/common/jay_colors.dart';
import 'package:app/presentation/components/jay_floating_action_button.dart';
import 'package:app/presentation/components/jay_progress_indicator.dart';
import 'package:app/presentation/utils/map_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart' as FlutterMap;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as Ltng2;
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  final AlarmDto detail;
  final String mapSettings;

  static const String MAPY_CZ_API_KEY =
      '9TzlyJmpebqKCk5LYUh9ezBW1-O_3B56bpzC3NKaOtQ';

  const MapScreen({super.key, required this.detail, required this.mapSettings});

  @override
  State<StatefulWidget> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  final FlutterMap.MapController? _flutterMapController =
      FlutterMap.MapController();
  MapType _currentMapType = MapType.normal;

  final Set<Marker> _markers = {};

  LatLng? _position = null;

  @override
  Widget build(final BuildContext context) => BlocProvider(
        create: (final context) => AlarmGpsBloc()
          ..add(AlarmGpsStarted(eventId: widget.detail.eventId)),
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
                        if (widget.mapSettings == 'Google Maps') {
                          MapUtils.openMap(state.latitude, state.longitude);
                        } else {
                          MapUtils.openMapMapyCz(
                              state.latitude, state.longitude);
                        }
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
              const SizedBox(
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
                    _position = LatLng(state.latitude, state.longitude);
                    _markers.add(marker);
                  });
                }
              },
              child: _position != null
                  ? getMap()
                  : const Center(
                      child: JayProgressIndicator(text: "Načítám mapu"),
                    )),
        ),
      );

  Widget getMap() {
    if (widget.mapSettings == 'Mapy.cz') {
      return FlutterMap.FlutterMap(
        mapController: _flutterMapController,
        options: FlutterMap.MapOptions(
          initialCenter:
              Ltng2.LatLng(_position!.latitude, _position!.longitude),
          // Center the map over London
          initialZoom: 14,
        ),
        children: [
          FlutterMap.TileLayer(
            // Display map tiles from any source
            urlTemplate:
                'https://api.mapy.cz/v1/maptiles/${(_currentMapType == MapType.normal ? "basic" : "aerial")}/256/{z}/{x}/{y}?apikey=${MapScreen.MAPY_CZ_API_KEY}', // OSMF's Tile Server
            userAgentPackageName: 'cz.telwork.jay.play',
            // And many more recommended properties!
          ),
          FlutterMap.MarkerLayer(markers: [
            FlutterMap.Marker(
                point: Ltng2.LatLng(_position!.latitude, _position!.longitude),
                child: Image.asset(
                  'assets/pin.png',
                  color: Colors.red,
                )),
          ]),
          Align(
            alignment: Alignment.bottomLeft,
            child: InkWell(
              child: SvgPicture.network('https://api.mapy.cz/img/api/logo.svg'),
              onTap: () {
                launchUrl(
                  Uri.parse('http://mapy.cz/'),
                );
              },
            ),
          ),
          FlutterMap.RichAttributionWidget(
            // Include a stylish prebuilt attribution widget that meets all requirments
            attributions: [
              FlutterMap.TextSourceAttribution(
                'Seznam.cz a.s. a další',
                onTap: () => launchUrl(
                    Uri.parse('https://api.mapy.cz/copyright')), // (external)
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      final currentZoom = _flutterMapController?.camera.zoom;
                      if (currentZoom != null) {
                        _flutterMapController?.move(
                            Ltng2.LatLng(
                                _position!.latitude, _position!.longitude),
                            currentZoom + 1);
                      }
                    });
                  },
                  heroTag: "map_zoom_add",
                  mini: true,
                  backgroundColor: JayColors.primary,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      final currentZoom = _flutterMapController?.camera.zoom;
                      if (currentZoom != null) {
                        _flutterMapController?.move(
                            Ltng2.LatLng(
                                _position!.latitude, _position!.longitude),
                            currentZoom - 1);
                      }
                    });
                  },
                  heroTag: "map_zoom_remove",
                  mini: true,
                  backgroundColor: JayColors.primary,
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _position!,
        zoom: 14,
      ),
      mapType: _currentMapType,
      markers: _markers,
      mapToolbarEnabled: false,
    );
  }

  void _onMapCreated(final GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }
}
