import 'package:AutoShare/Payment/payment_success.dart';
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
  int selectedIndex = -1;

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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Charge",
                        style: TextStyle(
                          fontSize: 56,
                          color: const Color.fromARGB(185, 0, 0, 0),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Amount",
                        style: TextStyle(
                          fontSize: 21,
                          color: const Color.fromARGB(185, 0, 0, 0),
                        ),
                      ),
                      SizedBox(height: 10),
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
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(color: Colors.grey),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 40, left: 16, right: 16),
                    child: Column(
                      children: [
                        Text(
                          'Select payment method',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 5),
                        paymentType(
                            0, "assets/Images/Visa.png", "**** **** **** 1234"),
                        SizedBox(height: 5),
                        paymentType(1, "assets/Images/GooglePay.png",
                            "**** **** **** 5678"),
                        SizedBox(height: 5),
                        paymentType(2, "assets/Images/PayPal.png",
                            "mailaddress@gmail.com"),
                        SizedBox(height: 5),
                        paymentType(3, "assets/Images/PhonePe.png",
                            "**** **** **** 3456"),
                        SizedBox(height: 5),
                        paymentType(
                            4, "assets/Images/Cash.png", "Cash Payment"),
                        SizedBox(height: 80),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 254, 187, 38),
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => Paymentsuccess()),
                            );
                          },
                          child: Text(
                            "Proceed to Pay",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget paymentType(int index, String imgPath, String cardNo) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: selectedIndex == index
              ? const Color.fromARGB(255, 254, 248, 195)
              : const Color.fromARGB(140, 254, 248, 195),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selectedIndex == index
                ? const Color.fromARGB(255, 233, 174, 46)
                : const Color.fromARGB(145, 232, 210, 45),
            width: 2,
          ),
        ),
        width: double.infinity,
        child: ListTile(
          leading: SizedBox(
            width: 50,
            height: 50,
            child: Image.asset(
              imgPath,
              fit: BoxFit.contain,
            ),
          ),
          title: Text(
            cardNo,
            style: TextStyle(
              color: selectedIndex == index ? Colors.black : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
