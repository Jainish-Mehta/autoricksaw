import 'package:flutter/material.dart';
import 'package:autoricksaw/customer_home_page.dart';

class AutoricksawBooking extends StatefulWidget {
  final String cost;
  final String driverName;
  final String driverPhoneNo;
  final String vehicalNo;

  const AutoricksawBooking({
    required this.cost,
    required this.driverPhoneNo,
    required this.driverName,
    required this.vehicalNo,
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
    matrix.scaleByDouble(2, 2, 1, 1);
    _transformationController.value = matrix;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: Padding(
        padding: EdgeInsets.all(12),
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
              boxShadow: [
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text(
                            'Cancel Ride?',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          content:
                              Text('Do you really want to cancel the ride?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (_) => CustomerHomePage(),
                                  ),
                                );
                              },
                              child: Text('Yes',
                                  style: TextStyle(color: Colors.black)),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                                Navigator.of(context).pop();
                              },
                              child: Text('No',
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text('Cancel Ride',
                        style: TextStyle(color: Colors.black, fontSize: 18)),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(),
              child: ClipRRect(
                borderRadius: BorderRadius.only(),
                child: Stack(
                  children: [
                    InteractiveViewer(
                      transformationController: _transformationController,
                      panEnabled: true,
                      maxScale: 4,
                      minScale: 1,
                      child: SizedBox.expand(
                        child: Image.asset(
                          'assets/Map.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Arrive in: 10min',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Text(
                              'Fare:${widget.cost}',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Container(
              height: 125,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(Icons.person, size: 50),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Driver:'),
                              SizedBox(height: 10),
                              Text('Contact No.'),
                              SizedBox(height: 10),
                              Text('Vehicle No.'),
                            ],
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.driverName),
                              SizedBox(height: 10),
                              Text(widget.driverPhoneNo),
                              SizedBox(height: 10),
                              Text(widget.vehicalNo),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
