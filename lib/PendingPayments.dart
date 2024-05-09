import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flightsense/BookingHistory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';

class PendingPayments extends StatefulWidget {
  @override
  _PendingPaymentsState createState() => _PendingPaymentsState();
}

class _PendingPaymentsState extends State<PendingPayments> {
  late Sslcommerz sslcommerz;

  @override
  void initState() {
    super.initState();
    // Initialize SSLCommerz
    sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
        store_id: "fligh66295d63f242a",
        store_passwd: "fligh66295d63f242a@ssl",
        multi_card_name: "visa,master,bkash",
        total_amount: 0.0, // Use the payment amount passed from BookingPage
        tran_id: _generateUniqueTransactionId(),
        currency: SSLCurrencyType.BDT,
        product_category: "Flight",
        sdkType: SSLCSdkType.TESTBOX,
      ),
    );
  }

  void _showPaymentCompleteDialog(String flightCode, double paymentAmount) {
    // Update Firestore payment_status here
    FirebaseFirestore.instance
        .collection('bookings')
        .where('code', isEqualTo: flightCode)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        // Update the payment_status field for the found document
        doc.reference.update({'payment_status': 'Paid'}).then((_) {
          // Show the dialog only after successfully updating the payment status
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Payment Complete'),
                content: const Text('Thank you for your payment!'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BookingHistoryPage(),
                        ),
                      );
                    },
                    child: const Text('Close'),
                  ),
                ],
              );
            },
          );
        }).catchError((error) {
          print("Failed to update payment status: $error");
        });
      });
    }).catchError((error) => print("Failed to fetch booking details: $error"));
  }

  // Generate a unique transaction ID
  String _generateUniqueTransactionId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Payments'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('bookings')
            .where('payment_status', isEqualTo: 'Pending')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final DocumentSnapshot document = snapshot.data!.docs[index];
              double paymentAmount = document['price'].toDouble();
              String flightCode = document['code'];
              return ListTile(
                title: Text(document['airline']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('From: ${document['from']}'),
                    Text('To: ${document['to']}'),
                    Text('Code: ${document['code']}'),
                    Text('Price: ${document['price']}'),
                    ElevatedButton(
                      onPressed: () {
                        String flightCode = document['code'];
                        double paymentAmount = document['price'].toDouble();
                        _initiatePayment(flightCode, paymentAmount);
                      },
                      child: Text('Pay Now'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

void _initiatePayment(String flightCode, double paymentAmount) async {
  try {
    setState(() {
      sslcommerz.initializer.total_amount = paymentAmount;
      sslcommerz.initializer.tran_id = _generateUniqueTransactionId();
    });

    SSLCTransactionInfoModel result = await sslcommerz.payNow();

    if (result.status!.toLowerCase() == "failed") {
      // Handle payment failure
    } else {
      // Show the payment complete dialog
      _showPaymentCompleteDialog(flightCode, paymentAmount);
    }
  } catch (error) {
    // Handle errors that occurred during payment process
  }
}


  
}



