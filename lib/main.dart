import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Payments',
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
  int passcode = 0;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget buildReceiver() {
    return TextFormField(
        decoration: const InputDecoration(
          //  icon: Icon(Icons.send),
          hintText: 'Receiver Email',
          // helperText: 'Helper Text',
          //  counterText: '0 characters',
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          receiver = value;
          print('------------------');
          print(value);
        });
  }

  Widget buildAmount() {
    return TextFormField(
        decoration: const InputDecoration(
          // icon: Icon(Icons.send),
          hintText: 'Amount to Send',
          //  helperText: 'Helper Text',
          //  counterText: '0 characters',
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          amountStr = value;
          print('------------------');
          print(value);
        });
  }

  Widget passCode() {
    return TextFormField(
        decoration: const InputDecoration(
          // icon: Icon(Icons.send),
          hintText: 'Pass Code',
          //  helperText: 'Helper Text',
          //  counterText: '0 characters',
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          passcodeStr = value;
          print('------------------');
          print(value);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Payments'),
        ),
        body: Container(
            margin: const EdgeInsets.all(24),
            child: Form(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildReceiver(),
                buildAmount(),
                passCode(),
                const SizedBox(
                  height: 100,
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

//getDBData
                    final response2 = await http.post(
                        Uri.parse('https://peacioapi.com:3000/getDBData'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body:
                            jsonEncode(<String, String>{'keyword': receiver}));
                    print(response2.body);
                  },
                  icon: const Icon(Icons.arrow_right),
                  label: const Text("pay"),
                ),
              ],
            ))));
  }
}
