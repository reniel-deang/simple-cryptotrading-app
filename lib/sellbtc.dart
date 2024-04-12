import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';
import 'apiconn.dart';
import 'data.dart';

class SellBTCPage extends StatefulWidget {
  const SellBTCPage({Key? key}) : super(key: key);

  @override
  State<SellBTCPage> createState() => _SellBTCPageState();
}

class _SellBTCPageState extends State<SellBTCPage> {
  TextEditingController buybtc = TextEditingController();
  double bitcoin_value = double.parse(value ?? "0"); // Ensure value is not null
  double inputbalance = balance ?? 0; // Ensure balance is not null
  double ownBitcoin = double.parse(ownbitcoin.toString()); // Convert ownbitcoin to double
  String _result = "";
  double inputValue = 0;

  void calculate(String expression) {
    if (expression.isEmpty) {
      setState(() {
        _result = '';
      });
      return;
    }

    try {
      setState(() {
        _result = evalExpression(expression).toStringAsFixed(10);
      });
    } catch (e) {
      setState(() {
        _result = 'To Bitcoin';
      });
    }
  }

  double evalExpression(String expression) {
    double bitcoin = double.parse(expression) * bitcoin_value;
    return double.tryParse(bitcoin.toString()) ?? 0.0;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: Text('SELL BTC'),
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
                            Text('BTC', style: TextStyle(fontSize: 20)),
                            SizedBox(width: 50),
                            Expanded(
                              child: TextField(
                                textAlign: TextAlign.end,
                                style: TextStyle(fontSize: 20),
                                controller: buybtc,
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,8}')),
                                ],
                                decoration: InputDecoration(
                                  hintText: '$ownBitcoin', // Display ownBitcoin as hintText
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                ),
                                onChanged: (value) {

                                  try {
                                    inputValue = double.parse(value);
                                  } catch (e) {
                                    inputValue = 0;
                                  }
                                  if (inputValue > ownBitcoin) {
                                    // Truncate the input to match precision of ownBitcoin
                                    inputValue = ownBitcoin;
                                    buybtc.text = inputValue.toStringAsFixed(8);
                                    buybtc.selection = TextSelection.fromPosition(
                                      TextPosition(offset: buybtc.text.length),
                                    );
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
                        Text('PHP', style: TextStyle(fontSize: 20)),
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
                            if (buybtc.text.isEmpty) {
                              _showErrorDialog("Please enter a valid amount.");
                              return;
                            }
                            double inputValue = double.parse(buybtc.text);
                            if (inputValue > ownBitcoin || inputValue <= 0) {
                              _showErrorDialog("Invalid input. Please enter a valid amount.");
                              return;
                            }
                            double btcToSell = inputValue;
                            balance = balance + double.parse(_result);
                            ownbitcoin = ownbitcoin - inputValue; // Update ownBitcoin
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
                              'SELL',
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
