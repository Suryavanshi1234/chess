import 'package:flutter/material.dart';
import 'package:flutter_paypal_sdk/flutter_paypal_sdk.dart';

class Testtt4 extends StatefulWidget {
  const Testtt4({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<Testtt4> createState() => _Testtt4State();
}

class _Testtt4State extends State<Testtt4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.blue,
              child: GestureDetector(
                onTap: () async {
                  await payNow();
                },
                child: const Text(
                  'Pay Now',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> payNow() async {
    FlutterPaypalSDK sdk = FlutterPaypalSDK(
      clientId: 'yourClientId',
      clientSecret: 'yourClientSecret',
      mode: Mode.sandbox, // Use Mode.production for production
    );

    AccessToken accessToken = await sdk.getAccessToken();

    if (accessToken?.token != null) {
      Payment payment = await sdk.createPayment(
        transaction(),
        accessToken.token,
      );

      if (payment?.status == true) {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => PaypalWebview(
        //       approveUrl: payment.approvalUrl,
        //       executeUrl: payment.executeUrl,
        //       accessToken: accessToken.token,
        //       sdk: sdk,
        //     ),
        //   ),
        // );
      }
    }
  }

  Map<String, dynamic> transaction() {
    return {
      "intent": "sale",
      "payer": {
        "payment_method": "paypal",
      },
      "redirect_urls": {
        "return_url": "/success",
        "cancel_url": "/cancel",
      },
      'transactions': [
        {
          "amount": {
            "currency": "USD",
            "total": "10",
          },
        }
      ],
    };
  }
}
