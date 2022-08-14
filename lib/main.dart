import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
//import 'package:decimal/decimal.dart';//
//import 'package:flutter_money_formatter/flutter_money_formatter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Peac.io Payments',
      home: MyCustomForm(),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  String receiver = '';
  String amountStr = '';
  String passcodeStr = '';
  double amount = 0.00;
  double balance = 0.00;
  int passcode = 0;
  String msg = '';

  final usCurrency = NumberFormat("#,##0.00", "en_US");

  // FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: balance);

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  void getBalance() async {
    final response =
        await http.get(Uri.parse('https://peacioapi.com:3000/ping'));
    double localBal = 400.01999;
    print("get balance now xxxxxxxxxxxxxxxxxxxxxxxxS");
    //  balance = localBal;
    setState(() {
      balance = localBal;
    });
    print("baklceb is -------");
    print(balance);
    // return 1;
  }

  Future<http.Response> payUser(String receiver, String amount) {
    return http.post(Uri.parse('https://peacioapi.com:3000/getDBData'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'keyword': receiver}));
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget buildReceiver() {
    return TextFormField(
      decoration: const InputDecoration(
        //  icon: Icon(Icons.send),
        labelText: 'Receiver Email',
        // helperText: 'Helper Text',
        //  counterText: '0 characters',
        border: OutlineInputBorder(),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'receiver cannot be empty';
        }

        return null;
      },
      onChanged: (value) => setState(() => receiver = value),

      //onChanged: (value) {
      //  receiver = value;
      //  print('------------------');
      //  print(value);
      // }
    );
  }

  Widget headerLabel() {
    return const Text('Pay by Phone Number or Email Address',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15));
    //,
    //  style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 0.5));
  }

  Widget buildAmount() {
    return TextFormField(
      decoration: const InputDecoration(
        //  contentPadding: EdgeInsets.symmetric(horizontal: 700),
        // icon: Icon(Icons.send),
        labelText: 'Payment Amount',
        //  helperText: 'Helper Text',
        //  counterText: '0 characters',
        border: OutlineInputBorder(),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'amount cannot be empty';
        }
        if (double.tryParse(text) != null) {
          // valid amount
        } else {
          return 'please enter a valid amount';
        }
        return null;
      },
      onChanged: (value) => setState(() => amountStr = value),
    );
    // {
    //amountStr = value;

    // print('------------------');
    // print(value);
    // });
  }

  Widget passCode() {
    return TextFormField(
      decoration: const InputDecoration(
        // icon: Icon(Icons.send),
        labelText: 'Pass Code',
        //  helperText: 'Helper Text',
        //  counterText: '0 characters',
        border: OutlineInputBorder(),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'code cannot be empty';
        }
        if (int.tryParse(text) != null) {
          // valid amount
        } else {
          return 'please enter a valid code';
        }

        return null;
      },
      onChanged: (value) => setState(() => passcodeStr = value),

      //onChanged: (value) {
      //  passcodeStr = value;
      //  print('------------------');
      //  print(value);
      // }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Peacio Payments'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.account_balance),
              onPressed: (getBalance),
            ),
          ],
        ),

        //  appBar: PreferredSize(
        //      preferredSize: const Size.fromWidth(600),
        //      child: Column(
        //        children: [AppBar(title: const Text('Payments'))],
        //      )),
        body: Container(
            margin: const EdgeInsets.all(24),
            child: Form(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                headerLabel(),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child:
                      //Text(NumberFormat.simpleCurrency(locale:))
                      Text('Balance:  ${usCurrency.format(balance)}',
                          style: const TextStyle(fontSize: 20)),
                ),
                const SizedBox(
                  height: 10,
                ),
                buildReceiver(),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 400,
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: 200,
                    //alignment: const Alignment(-1.0, 0.0),
                    child: buildAmount(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 400,
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: 200,
                    //alignment: const Alignment(-1.0, 0.0),
                    child: passCode(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child:
                      //Text(NumberFormat.simpleCurrency(locale:))
                      Text('$msg', style: const TextStyle(fontSize: 20)),
                ),
                // ),
                //buildAmount(),
                // passCode(),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    print('submit ----------------');
                    print(receiver);
                    print(amountStr);
                    print(passcodeStr);

                    //44.209.97.240
                    final response = await http
                        .get(Uri.parse('https://peacioapi.com:3000/ping'));

                    print(response.body);
                    var myInt = int.parse(passcodeStr);
                    if (myInt == 1234) {
                      final response2 = await payUser(receiver, amountStr);
                      print(response2.body);
                      getBalance();
                      setState(() => msg = 'Payment made');
                    } else {
                      setState(() => msg = 'Passcode wrong');
                    }

//getDBData
                    /* http.post(
                        Uri.parse('https://peacioapi.com:3000/getDBData'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body:
                            jsonEncode(<String, String>{'keyword': receiver}));
                    */
                    // setState(() => msg = 'Payment made');
                  },
                  icon: const Icon(Icons.arrow_right, size: 40),
                  // label: const Text("pay"),
                  label: const Text("Pay", style: TextStyle(fontSize: 20)),
                ),
              ],
            ))));
  }
}
