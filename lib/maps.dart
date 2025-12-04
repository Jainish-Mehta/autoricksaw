import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class AhmedabadMap extends StatefulWidget {
  const AhmedabadMap({super.key});

  @override
  State<AhmedabadMap> createState() => _AhmedabadMapState();
}

class _AhmedabadMapState extends State<AhmedabadMap> {
  final MapController _mapController = MapController();

  // Ahmedabad coordinates
  final LatLng _ahmedabad = const LatLng(23.0215374, 72.5800568);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ahmedabad Map'),
        backgroundColor: Color.fromARGB(255, 254, 187, 38),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _ahmedabad,
              initialZoom: 14,
              minZoom: 12,
              maxZoom: 16,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: 'com.example.autoricksaw',
              ),
              /*MarkerLayer(
                markers: [
                  Marker(
                    point: _ahmedabad,
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.location_on,
                      size: 40,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),*/
            ],
          ),

          // Floating button to move back to Ahmedabad
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 254, 187, 38),
              onPressed: () {
                _mapController.move(_ahmedabad, 12);
              },
              child: const Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }
}
