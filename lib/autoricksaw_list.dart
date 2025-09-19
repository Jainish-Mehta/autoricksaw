import 'package:autoricksaw/conformation_pop_up.dart';

import 'package:flutter/material.dart';

class AutoricksawList extends StatefulWidget {
  const AutoricksawList({super.key});
  @override
  AutoricksawListState createState() => AutoricksawListState();
}

class AutoricksawListState extends State<AutoricksawList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Autorickshaws'),
        backgroundColor: Colors.yellow,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Column(
                    children: [
                      buildRicksawCard('Darshit', 'GJ01MN1982',
                          '+91 9239234454', '9:30am', '50'),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      buildRicksawCard('Nisarg', 'GJ05CH5672', '+91 9339234454',
                          '9:32am', '52'),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      buildRicksawCard('Jainish', 'GJ11UI4186',
                          '+91 9929234454', '9:45am', '47'),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      buildRicksawCard('Nischay', 'GJ09MT7455',
                          '+91 9656894454', '9:42am', '45'),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      buildRicksawCard('XYZ', 'GJ08NK9833', '+91 9459275830',
                          '9:29am', '53'),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      buildRicksawCard('ABC', 'GJ01SS9999', '+91 9739564454',
                          '9:36am', '55'),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildRicksawCard(String driverName, String numberPlate,
      String driverPhoneNo, String arrivalTime, String cost) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.21,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  driverName,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(
                  numberPlate,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(
                  'Arrive:- $arrivalTime',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Row(
                  children: [
                    Text(
                      '₹$cost',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        handleConfirmResult(context, false, null,
                            cost: cost,
                            driverPhoneNo: driverPhoneNo,
                            driverName: driverName,
                            vehicalNo: numberPlate);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                      ),
                      child: Text(
                        'Book',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Icon(
                  Icons.person,
                  size: 80,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
