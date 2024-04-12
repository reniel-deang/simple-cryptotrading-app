import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'main.dart';
import 'data.dart';
import 'apiconn.dart';


class BuyETHPage extends StatefulWidget {
  const BuyETHPage({super.key});

  @override
  State<BuyETHPage> createState() => _BuyETHPageState();
}


class _BuyETHPageState extends State<BuyETHPage> {
  TextEditingController buybtc = TextEditingController();
  double bitcoin_value = double.parse(value);
  double inputbalance = balance;
  String _result = "";

  void calculate(String expression) {
    // Check if the expression is empty
    if (expression.isEmpty) {
      setState(() {
        _result = '';
      });
      return;
    }

    // Implement your calculation logic here
    // For simplicity, this example evaluates the expression as a string
    try {
      setState(() {
        _result = evalExpression(expression).toString();
      });
    } catch (e) {
      setState(() {
        _result = 'To Bitcoin';
      });
    }
  }

  double evalExpression(String expression) {
    // Implement your expression evaluation logic here
    // For simplicity, this example directly parses and evaluates the expression
    double bitcoin = double.parse(expression) / bitcoin_value;
    return double.tryParse(bitcoin.toString()) ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: Text('BUY BTC'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(50.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
                blurRadius: 1.0,
                spreadRadius: 1.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 40),
            child: Column(
              children: [
                Image.asset(
                  'assets/bitcoin.png',
                  height: 80,
                ),
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 1.0,
                        spreadRadius: 1.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Text('PHP', style: TextStyle(fontSize: 20)),
                            SizedBox(width: 50),
                            Expanded(
                              child: TextField(
                                textAlign: TextAlign.end,
                                style: TextStyle(fontSize: 20),
                                controller: buybtc,
                                keyboardType: TextInputType.phone, // Set keyboard type to phone
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ], // Allow only digits
                                decoration: InputDecoration(
                                  hintText: '$balance',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                ),
                                onChanged: (value) {
                                  // Ensure that the entered value does not exceed the input balance
                                  if (double.parse(value) > inputbalance) {
                                    buybtc.text = inputbalance.toStringAsFixed(2);
                                    buybtc.selection = TextSelection.fromPosition(
                                      TextPosition(offset: buybtc.text.length),
                                    );
                                    return; // Exit early if input reaches maximum balance
                                  }
                                  calculate(value);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 1.0,
                        spreadRadius: 1.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20, right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('BTC', style: TextStyle(fontSize: 20)),
                        Text('$_result', style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            balance = balance - double.parse(buybtc.text);
                            ownbitcoin = ownbitcoin + double.parse(_result);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Homepage()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'BUY',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
