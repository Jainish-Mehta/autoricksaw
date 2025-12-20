import 'dart:convert';
import 'dart:developer';
import 'package:autoricksaw/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_dragmarker/flutter_map_dragmarker.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'cancel_ride.dart';
import 'exit_pop_up.dart';

class AutoricksawBooking extends StatefulWidget {
  final String cost;
  final String driverName;
  final String driverPhoneNo;
  final String vehicalNo;
  final String fare;

  const AutoricksawBooking({
    required this.cost,
    required this.driverPhoneNo,
    required this.driverName,
    required this.vehicalNo,
    required this.fare,
    super.key,
  });

  @override
  AutoricksawBookingState createState() => AutoricksawBookingState();
}

class AutoricksawBookingState extends State<AutoricksawBooking> {
  final MapController _mapController = MapController();

  LatLng newlj = LatLng(23.0415, 72.5171);
  LatLng sabarmati = LatLng(23.0635, 72.5853);

  List<LatLng> routePoints = [];
  double _sheetExtent = 0.35;

  @override
  void initState() {
    super.initState();
    fetchRoute();
  }

  Future<void> fetchRoute() async {
    const apiKey = '34526283-cc7d-48b3-93d2-dbfb1dc461cd';

    final url =
        'https://graphhopper.com/api/1/route?point=${newlj.latitude},${newlj.longitude}&point=${sabarmati.latitude},${sabarmati.longitude}&vehicle=car&points_encoded=false&key=$apiKey';

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
        _mapController.move(center, 13);
      }
    } else {
      log('Routing failed: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final sheetInitialSize = 0.35;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        handlePopResult(
          context,
          didPop,
          result,
          title: 'Cancel Ride?',
          message: 'Do you really want to cancel the ride?',
          confirmText: 'Yes',
          cancelText: 'No',
          onConfirm: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const CancelRide()),
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              ),
            ),
          ],
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        endDrawer: Padding(
          padding: const EdgeInsets.all(12),
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(-2, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: TextButton(
                        onPressed: () {
                          handlePopResult(
                            context,
                            false,
                            null,
                            title: 'Cancel Ride?',
                            message: 'Do you really want to cancel the ride?',
                            confirmText: 'Yes',
                            cancelText: 'No',
                            onConfirm: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const CancelRide(),
                                ),
                              );
                            },
                          );
                        },
                        child: const Text(
                          'Cancel Ride',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Positioned.fill(
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
            NotificationListener<DraggableScrollableNotification>(
              onNotification: (notification) {
                setState(() {
                  _sheetExtent = notification.extent;
                });
                return true;
              },
              child: DraggableScrollableSheet(
                initialChildSize: sheetInitialSize,
                minChildSize: 0.05,
                maxChildSize: 0.35,
                builder: (context, scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 254, 187, 38),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: ListView(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      children: [
                        const SizedBox(height: 10),
                        Center(
                          child: Container(
                            height: 5,
                            width: 40,
                            margin: const EdgeInsets.only(top: 8, bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const Divider(thickness: 1, color: Colors.white),
                        const SizedBox(height: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Arrive in: 10min',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'Fare: ${widget.fare}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const Divider(thickness: 1, color: Colors.white),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Icon(Icons.person,
                                    size: 50, color: Colors.white),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    widget.driverName,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    widget.driverPhoneNo,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    widget.vehicalNo,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15,
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 255, 255, 255),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Payment(
                                      fare: widget.fare,
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                "Pay",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeOut,
              bottom: screenHeight * _sheetExtent + 20,
              right: 20,
              child: FloatingActionButton(
                backgroundColor: const Color.fromARGB(255, 254, 187, 38),
                onPressed: () {
                  _mapController.move(newlj, 14);
                },
                child: const Icon(Icons.my_location),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
