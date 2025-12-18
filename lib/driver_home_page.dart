import 'package:autoricksaw/app_drawer.dart';
import 'package:autoricksaw/plan_your_ride.dart';
import 'package:flutter/material.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  DriverHomePageState createState() => DriverHomePageState();
}

class DriverHomePageState extends State<DriverHomePage> {
  double rating = 4.8;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(userType: 'Driver', userName: 'Driver Name'),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 254, 187, 38),
        title: const Text('Driver Home Page'),
      ),
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 12, right: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.15,
                  padding: EdgeInsets.all(12.0),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Icon(Icons.person, size: 100, color: Colors.blueAccent),
                        SizedBox(width: 20.0),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Hello,',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Driver',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(100, 80),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                backgroundColor: Colors.green,
                                elevation: 5),
                            onPressed: () => (
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => PlanYourRide(
                                          pickupLocation: '',
                                          dropoffLocation: '',
                                          userType: 'driver',
                                          buttonText: 'Go for Ride',),
                                    ),
                                  ),
                                ),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Go,',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    Text(
                                      ' Online',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.15,
                  padding: EdgeInsets.all(12.0),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Image.asset('assets/Images/Auto.png'),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Text(
                            'Today\'s Earnings: ₹150',
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.15,
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'Trip Completed: 5',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.15,
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'Your Rating: $rating ⭐',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
