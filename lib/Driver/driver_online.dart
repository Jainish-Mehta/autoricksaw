import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_dragmarker/flutter_map_dragmarker.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class DriverOnline extends StatefulWidget {
  final String source;
  final String destination;

  const DriverOnline({
    super.key,
    required this.source,
    required this.destination,
  });

  @override
  DriverOnlineState createState() => DriverOnlineState();
}

class DriverOnlineState extends State<DriverOnline> {
  final MapController _mapController = MapController();

  LatLng newlj = LatLng(23.0415, 72.5171);
  LatLng sabarmati = LatLng(23.0635, 72.5853);
  List<LatLng> passengers = [];

  List<LatLng> routePoints = [];

  Offset draggableFabPosition = Offset.zero;

  bool showPopup = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final size = MediaQuery.of(context).size;
    draggableFabPosition = Offset(size.width - 80, size.height / 2);
  }

  @override
  void initState() {
    super.initState();
    fetchRoute();

    Timer.periodic(const Duration(seconds: 10), (timer) {
      if (mounted) {
        setState(() {
          showPopup = true;
        });
      }
    });
  }

  Future<void> fetchRoute() async {
    const apiKey = '34526283-cc7d-48b3-93d2-dbfb1dc461cd';

    final points = [
      '${newlj.latitude},${newlj.longitude}',
      ...passengers.map((p) => '${p.latitude},${p.longitude}'),
      '${sabarmati.latitude},${sabarmati.longitude}',
    ];

    final url =
        'https://graphhopper.com/api/1/route?point=${points.join("&point=")}&vehicle=car&points_encoded=false&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List coords = data['paths'][0]['points']['coordinates'];

      setState(() {
        routePoints = coords
            .map<LatLng>((c) => LatLng(c[1] as double, c[0] as double))
            .toList();
      });

      if (routePoints.isNotEmpty) {
        final avgLat =
            routePoints.map((p) => p.latitude).reduce((a, b) => a + b) /
                routePoints.length;
        final avgLng =
            routePoints.map((p) => p.longitude).reduce((a, b) => a + b) /
                routePoints.length;
        final center = LatLng(avgLat, avgLng);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _mapController.move(center, 13);
        });
      }
    } else {
      log('Routing failed: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text('Driver Online Status')),
      backgroundColor: const Color.fromARGB(255, 254, 187, 38),
      floatingActionButton: FloatingActionButton(
        heroTag: "recenterFab",
        backgroundColor: const Color.fromARGB(255, 254, 187, 38),
        onPressed: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _mapController.move(newlj, 14);
          });
        },
        child: const Icon(Icons.my_location),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black38,
                        blurRadius: 6,
                        offset: Offset(2, 4)),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Current Trip",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 24)),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("From: ${widget.source}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis),
                                  Text("To: ${widget.destination}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('30min',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                                Text('10km',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: newlj,
                    initialZoom: 13,
                    minZoom: 12,
                    maxZoom: 18,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.autoricksaw',
                    ),
                    if (routePoints.isNotEmpty)
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: routePoints,
                            color: const Color.fromARGB(255, 254, 187, 38),
                            strokeWidth: 5,
                          ),
                        ],
                      ),
                    DragMarkers(
                      markers: [
                        ...passengers.map((p) => DragMarker(
                              point: p,
                              size: const Size(40, 40),
                              builder: (_, __, ___) => const Icon(
                                Icons.location_on,
                                color: Color.fromARGB(255, 254, 187, 38),
                                size: 40,
                              ),
                              onDragEnd: (details, newPos) {
                                setState(() {
                                  final idx = passengers.indexOf(p);
                                  if (idx != -1) passengers[idx] = newPos;
                                });
                                fetchRoute();
                              },
                            )),
                        DragMarker(
                          point: newlj,
                          size: const Size(40, 40),
                          builder: (_, __, ___) => const Icon(Icons.location_on,
                              color: Colors.green, size: 40),
                          onDragEnd: (details, newPos) {
                            setState(() => newlj = newPos);
                            fetchRoute();
                          },
                        ),
                        DragMarker(
                          point: sabarmati,
                          size: const Size(40, 40),
                          builder: (_, __, ___) => const Icon(Icons.location_on,
                              color: Colors.red, size: 40),
                          onDragEnd: (details, newPos) {
                            setState(() => sabarmati = newPos);
                            fetchRoute();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (showPopup)
            Positioned(
              bottom: size.height * 0.0975,
              left: size.width * 0.1,
              right: size.width * 0.1,
              child: Container(
                constraints: BoxConstraints(maxHeight: 300, maxWidth: 300),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 254, 187, 38),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("From: Pickup request",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          const Text("To: Your destination",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          const Text("Fare: ₹10",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          const Text("Pickup: ~2 min away",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 20),
                          Align(
                            alignment: AlignmentGeometry.bottomCenter,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  showPopup = false;
                                  final offset =
                                      (passengers.length + 1) * 0.003;
                                  passengers.add(LatLng(
                                    newlj.latitude + offset,
                                    newlj.longitude + offset,
                                  ));
                                });
                                fetchRoute();
                              },
                              child: const Text(
                                'Accept',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () => setState(() => showPopup = false),
                        child: const Icon(Icons.close,
                            color: Colors.white, size: 24),
                      ),
                    ),
                  ],
                ),
              ),

              /*Positioned(
            left: draggableFabPosition.dx,
            top: draggableFabPosition.dy,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  draggableFabPosition += details.delta;
                });
              },
              child: FloatingActionButton(
                heroTag: 'draggableFab',
                backgroundColor: const Color.fromARGB(255, 254, 187, 38),
                onPressed: () {
                  setState(() {
                    showPopup = !showPopup;
                  });
                },
                child: const Icon(Icons.drag_handle),
              ),
            ),
          ),*/
            ),
        ],
      ),
    );
  }
}
