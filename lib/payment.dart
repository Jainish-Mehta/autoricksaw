import 'package:flutter/material.dart';

class Payment extends StatefulWidget {
  final String fare;

  const Payment({
    required this.fare,
    super.key,
  });

  @override
  PaymentState createState() => PaymentState();
}

class PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Payment",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 100),
                child: Column(
                  children: [
                    Text(
                      "Charge",
                      style: TextStyle(
                        fontSize: 56,
                        color: const Color.fromARGB(185, 0, 0, 0),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Amount",
                      style: TextStyle(
                        fontSize: 21,
                        color: const Color.fromARGB(185, 0, 0, 0),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '₹${widget.fare}',
                      style: TextStyle(
                        fontSize: 21,
                        color: const Color.fromARGB(185, 0, 0, 0),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.only(top: 20),
                    child: Text('Select payment method'),
                  )
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 150,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
