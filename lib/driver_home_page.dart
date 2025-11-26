import 'package:autoricksaw/app_drawer.dart';
import 'package:flutter/material.dart';

import 'exit_pop_up.dart';
import 'package:vector_math/vector_math_64.dart' as vmath;

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  DriverHomePageState createState() => DriverHomePageState();
}

class DriverHomePageState extends State<DriverHomePage> {
  final TransformationController _transformationController =
      TransformationController();

  @override
  void initState() {
    super.initState();

    final matrix = Matrix4.identity();
    matrix.scaleByVector3(vmath.Vector3(2, 2, 1));
    _transformationController.value = matrix;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        handlePopResult(context, didPop, result);
      },
      child: Scaffold(
        drawer: AppDrawer(userType: 'Driver', userName: 'Driver Name'),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Driver Home Page',
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 254, 187, 38),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        _buildMapBox(context),
                        Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: SizedBox(
                            height: 300,
                            width: double.infinity,
                            child: DecoratedBox(
                              decoration: BoxDecoration(color: Colors.white),
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildTextCard(
                                          context,
                                          'Fare: ₹50',
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        _buildTextCard(context,
                                            'Pickup Location:  Galaxy Plaza, SG Highway'),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        _buildTextCard(context,
                                            'Destination Location: Sunrise Tower, Vastrapur'),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        _buildTextCard(context,
                                            'Passenger Arrive time: 3min'),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        _buildTextCard(
                                            context, 'Trip Duration: 20min'),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextCard(BuildContext context, String userText) {
    return Text(
      userText,
      style: TextStyle(
        decoration: TextDecoration.underline,
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildMapBox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: InteractiveViewer(
            transformationController: _transformationController,
            panEnabled: true,
            minScale: 1.0,
            maxScale: 4.0,
            child: Image.asset(
              'assets/Images/Map.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
