import 'package:flutter/material.dart';
import 'package:autoricksaw/customer_home_page.dart';
import 'exit_pop_up.dart'; // <-- your reusable popup widget

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
  final TransformationController _transformationController =
      TransformationController();

  @override
  void initState() {
    super.initState();
    final matrix = Matrix4.identity();
    matrix.scaleByDouble(2.0, 2.0, 1.0, 1); // corrected scale method
    _transformationController.value = matrix;
  }

  @override
  Widget build(BuildContext context) {
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
              MaterialPageRoute(builder: (_) => const CustomerHomePage()),
            );
          },
        );
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ),
          ],
        ),
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
                                  builder: (_) => const CustomerHomePage()),
                            );
                          },
                        );
                      },
                      child: const Text(
                        'Cancel Ride',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        overflow: TextOverflow.ellipsis, // prevent overflow
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            // Fullscreen map
            InteractiveViewer(
              transformationController: _transformationController,
              panEnabled: true,
              maxScale: 4,
              minScale: 1,
              child: SizedBox.expand(
                child: Image.asset(
                  'assets/Images/Map.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Overlay info (arrival/fare)
            /*Positioned(
              bottom: 150,
              left: 10,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Arrive in: 10min',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      'Fare: ${widget.fare}',
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),*/

            // Bottom draggable detail sheet
            DraggableScrollableSheet(
              initialChildSize: 0.25,
              minChildSize: 0.05,
              maxChildSize: 0.3, // allow more drag
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(15),
                    children: [
                      // drag handle
                      Center(
                        child: Container(
                          height: 5,
                          width: 40,
                          margin: const EdgeInsets.only(top: 8, bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Divider(thickness: 1, color: Colors.grey),
                      // arrival + fare
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Arrive in: 10min',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          Text(
                            'Fare: ${widget.fare}',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      const Divider(thickness: 1, color: Colors.grey),
                      const SizedBox(height: 12),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Avatar on the left
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

                            const SizedBox(
                                width: 160), // gap between avatar and details

                            // Details aligned to the right
                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.end, // <-- right align
                              children: [
                                Text(widget.driverName),
                                const SizedBox(height: 10),
                                Text(widget.driverPhoneNo),
                                const SizedBox(height: 10),
                                Text(widget.vehicalNo),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
