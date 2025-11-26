import 'package:flutter/material.dart';
import 'package:autoricksaw/autoricksaw_list.dart';

class PickupPage extends StatefulWidget {
  final String pickupLocation;
  final String dropoffLocation;

  const PickupPage({
    super.key,
    required this.pickupLocation,
    required this.dropoffLocation,
  });

  @override
  PickupPageState createState() => PickupPageState();
}

class PickupPageState extends State<PickupPage> {
  final FocusNode _pickupFocusNode = FocusNode();
  final FocusNode _dropoffFocusNode = FocusNode();
  double _pickupElevation = 0.1;
  double _dropoffElevation = 0.1;

  late TextEditingController pickupController;
  late TextEditingController dropoffController;

  final TransformationController _transformationController =
      TransformationController();

  // Toggle flags
  bool _isEditingPickup = false;
  bool _isEditingDropoff = false;

  @override
  void initState() {
    super.initState();

    pickupController = TextEditingController(text: widget.pickupLocation);
    dropoffController = TextEditingController(text: widget.dropoffLocation);

    final matrix = Matrix4.identity();
    matrix.scaleByDouble(2.0, 2.0, 1.0, 1);
    _transformationController.value = matrix;

    _pickupFocusNode.addListener(() {
      setState(() {
        _pickupElevation = _pickupFocusNode.hasFocus ? 8 : 0.1;
      });
    });

    _dropoffFocusNode.addListener(() {
      setState(() {
        _dropoffElevation = _dropoffFocusNode.hasFocus ? 8 : 0.1;
      });
    });
  }

  @override
  void dispose() {
    _pickupFocusNode.dispose();
    _dropoffFocusNode.dispose();
    pickupController.dispose();
    dropoffController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan your Ride'),
        backgroundColor: const Color.fromARGB(255, 254, 187, 38),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // Fullscreen map background
            Positioned.fill(
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

            // Bottom draggable sheet
            DraggableScrollableSheet(
              initialChildSize: 0.35,
              minChildSize: 0.05,
              maxChildSize: 0.4,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 6)
                    ],
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Drag handle
                        Center(
                          child: Container(
                            height: 5,
                            width: 40,
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Distance',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              '1.2km',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),

                        // Pickup field (toggle view/edit)
                        Material(
                          elevation: _pickupElevation,
                          borderRadius: BorderRadius.circular(50),
                          child: _isEditingPickup
                              ? TextField(
                                  focusNode: _pickupFocusNode,
                                  controller: pickupController,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.gps_fixed,
                                      color: Color.fromARGB(255, 254, 187, 38),
                                    ),
                                    hintText: 'Pickup Location',
                                    filled: true,
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 1.5),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromARGB(255, 254, 187, 38),
                                          width: 2.0),
                                    ),
                                  ),
                                )
                              : ListTile(
                                  leading: const Icon(Icons.gps_fixed,
                                      color: Color.fromARGB(255, 254, 187, 38)),
                                  title: Text(pickupController.text),
                                  trailing: IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Color.fromARGB(255, 254, 187, 38),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isEditingPickup = true;
                                      });
                                    },
                                  ),
                                ),
                        ),

                        const SizedBox(height: 12),

                        // Dropoff field (toggle view/edit)
                        Material(
                          elevation: _dropoffElevation,
                          borderRadius: BorderRadius.circular(50),
                          child: _isEditingDropoff
                              ? TextField(
                                  focusNode: _dropoffFocusNode,
                                  controller: dropoffController,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.location_on,
                                      color: Color.fromARGB(255, 254, 187, 38),
                                    ),
                                    hintText: 'Dropoff Location',
                                    filled: true,
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 1.5),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromARGB(255, 254, 187, 38),
                                          width: 2.0),
                                    ),
                                  ),
                                )
                              : ListTile(
                                  leading: const Icon(Icons.location_on,
                                      color: Color.fromARGB(255, 254, 187, 38)),
                                  title: Text(dropoffController.text),
                                  trailing: IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Color.fromARGB(255, 254, 187, 38),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isEditingDropoff = true;
                                      });
                                    },
                                  ),
                                ),
                        ),

                        const SizedBox(height: 20),

                        // Check Prices button
                        if (pickupController.text.isNotEmpty &&
                            dropoffController.text.isNotEmpty)
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const AutoricksawList(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 254, 187, 38),
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: const Size.fromHeight(50),
                            ),
                            child: const Text(
                              'Check Autoricksaws',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                      ],
                    ),
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
