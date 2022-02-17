import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);
  //Razorpay razorpay;
  @override
  _homescreenState createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  Razorpay razorpay = Razorpay();
  TextEditingController textEditingController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    // razorpay=new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void opencheckout() {
    var options = {
      "key": "rzp_test_g6ggnb0Dw7RNtc",
      "amount": num.parse(textEditingController.text) * 100,
      "name": "Sample App",
      "description": "Payment for the some random product",
      "prefill": {
        "contact": "7721028071",
        "email": "pratappatilawachar@gmail.com"
      },
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentSuccess() {
    print("Payment succesfully");
    // Toast.show("Payment success", context);
  }

  void handlerErrorFailure() {
    print("Payment Error");
    // Toast.show("Payment error", context);
  }

  void handlerExternalWallet() {
    print("External Wallet");
    // Toast.show("External Wallet", context);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Razor pay"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              decoration: new InputDecoration(
                hintText: "Amount pay",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              child: Text(
                "Pay now",
                style: TextStyle(color: Colors.white),
              ),
              // color:Colors.amber,
              onPressed: () {
                opencheckout();
              },
            )
          ],
        ),
      ),
    );
  }
}
