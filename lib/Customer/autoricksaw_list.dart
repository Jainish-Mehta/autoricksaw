import 'package:autoricksaw/Customer/conformation_pop_up.dart';
import 'package:flutter/material.dart';

class AutoricksawList extends StatefulWidget {
  const AutoricksawList({super.key});
  @override
  AutoricksawListState createState() => AutoricksawListState();
}

class AutoricksawListState extends State<AutoricksawList> {
  final int autoCount = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Available Autos for Ride",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "$autoCount auto found",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                children: [
                  buildRicksawCard('Driver 1', 'GJ01MN1982', '+91 9239234454',
                      '9:30am', '50', '35'),
                  buildRicksawCard('Driver 2', 'GJ05CH5672', '+91 9339234454',
                      '9:32am', '52', '36'),
                  buildRicksawCard('Driver 3', 'GJ11UI4186', '+91 9929234454',
                      '9:45am', '47', '38'),
                  buildRicksawCard('Driver 4', 'GJ09MT7455', '+91 9656894454',
                      '9:42am', '45', '33'),
                  buildRicksawCard('Driver 5', 'GJ08NK9833', '+91 9459275830',
                      '9:29am', '53', '35'),
                  buildRicksawCard('Driver 6', 'GJ01SS9999', '+91 9739564454',
                      '9:36am', '55', '39'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRicksawCard(
    String driverName,
    String numberPlate,
    String driverPhoneNo,
    String arrivalTime,
    String distance,
    String fare, {
    String seats = "3 seats",
  }) {
    return Card(
      elevation: 6,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
          color: Colors.black,
          width: 1.5,
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(driverName,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Text("Vehicle: $numberPlate"),
                      Text(seats),
                      Text("Distance: $distance km"),
                      Text("Arrival: $arrivalTime"),
                      Text("Fare $fare")
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    'assets/Images/urban_tuk_tuk.png',
                    width: 100,
                    height: 100,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  handleConfirmResult(
                    context,
                    false,
                    null,
                    cost: distance,
                    driverPhoneNo: driverPhoneNo,
                    driverName: driverName,
                    vehicalNo: numberPlate,
                    fare: fare,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 254, 187, 38),
                  side: const BorderSide(color: Colors.black),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Select this Auto",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
