import 'package:autoricksaw/autoricksaw_list.dart';
import 'package:flutter/material.dart';

class PickupPage extends StatefulWidget {
  const PickupPage({super.key});
  @override
  PickupPageState createState() => PickupPageState();
}

class PickupPageState extends State<PickupPage> {
  final FocusNode _pickupFocusNode = FocusNode();
  final FocusNode _dropoffFocusNode = FocusNode();
  double _pickupElevation = 0.1;
  double _dropoffElevation = 0.1;

  final TextEditingController pickupController = TextEditingController();
  final TextEditingController dropoffController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _pickupFocusNode.addListener(() {
      setState(() {
        _pickupElevation = (_pickupFocusNode.hasFocus ? 8 : 0.1)
            .clamp(0.0, double.infinity)
            .toDouble();
      });
    });

    _dropoffFocusNode.addListener(() {
      setState(() {
        _dropoffElevation = (_dropoffFocusNode.hasFocus ? 8 : 0.1)
            .clamp(0.0, double.infinity)
            .toDouble();
      });
    });
  }

  @override
  void dispose() {
    _pickupFocusNode.dispose();
    _dropoffFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plan your Ride'),
        backgroundColor: Colors.yellow,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Material(
                            elevation: _pickupElevation,
                            borderRadius: BorderRadius.circular(50),
                            child: Padding(
                              padding: EdgeInsets.all(0),
                              child: TextField(
                                focusNode: _pickupFocusNode,
                                controller: pickupController,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                  ),
                                  hintText: ('Pickup Location'),
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Material(
                            elevation: _dropoffElevation,
                            borderRadius: BorderRadius.circular(50),
                            child: Padding(
                              padding: EdgeInsets.all(0),
                              child: TextField(
                                focusNode: _dropoffFocusNode,
                                controller: dropoffController,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                  ),
                                  hintText: ('Dropoff Location'),
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (pickupController.text.isNotEmpty &&
                        dropoffController.text.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AutoricksawList(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              )),
                          child: Text(
                            'Check Prices',
                          ),
                        ),
                      ),
                    Material(
                      elevation: 8,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 1,
                        width: MediaQuery.of(context).size.width * 1,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              locationListCard(context,
                                  '402, Sunrise Tower, Vastrapur, Ahmedabad – 380015'),
                              locationListCard(context,
                                  'B-12, Krishna Residency, Maninagar, Ahmedabad – 380008'),
                              locationListCard(context,
                                  '5A, Shyam Villa, Ghatlodia, Ahmedabad – 380061'),
                              locationListCard(context,
                                  '3rd Floor, Galaxy Plaza, SG Highway, Ahmedabad – 380015'),
                              locationListCard(context,
                                  '402, Orchid Elegance, Bodakdev, Ahmedabad – 380054'),
                              locationListCard(context,
                                  'C-17, Shivam Enclave, Vejalpur, Ahmedabad – 380051'),
                              locationListCard(context,
                                  'A-303, Green Park, Thaltej, Ahmedabad – 380059'),
                              locationListCard(context,
                                  '3rd Floor, Galaxy Plaza, SG Highway, Ahmedabad – 380015'),
                              locationListCard(context,
                                  'D-9, Sunrise Apartments, Paldi, Ahmedabad – 380007'),
                              locationListCard(context,
                                  'Flat 102, Silver Nest, Naranpura, Ahmedabad – 380013'),
                              locationListCard(context,
                                  'B-204, Harmony Homes, Chandkheda, Ahmedabad – 382424'),
                              locationListCard(context,
                                  '3rd Floor, Galaxy Plaza, SG Highway, Ahmedabad – 380015'),
                            ],
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
      ),
    );
  }

  Widget locationListCard(BuildContext context, String location) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.07,
      child: Padding(
        padding: EdgeInsets.all(1),
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: Colors.yellow, borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Text(
              location,
            ),
          ),
        ),
      ),
    );
  }
}
