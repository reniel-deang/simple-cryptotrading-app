import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'main.dart';

class SellBTCPage extends StatefulWidget {
  const SellBTCPage({super.key});

  @override
  State<SellBTCPage> createState() => _SellBTCPageState();
}

class _SellBTCPageState extends State<SellBTCPage> {
  TextEditingController sellbtc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: Text('SELL BTC'),
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 20),
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
            padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 40),
            child: Column(
              children: [
                Image.asset('assets/bitcoin.png',height: 80,),
                SizedBox(height: 15,),
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
                            Text('BTC',style: TextStyle(fontSize: 20),),
                            SizedBox(width: 50,),
                            Expanded(
                              child: TextField(
                                  textAlign: TextAlign.end,
                                  style: TextStyle(fontSize: 20),
                                  controller: sellbtc,
                                  keyboardType: TextInputType.phone, // Set keyboard type to phone
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly,
                                  ], // Allow only digits
                                  decoration: InputDecoration(
                                    hintText: '10 000 max basta convert sa btc',
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                  )
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),

                SizedBox(height: 20,),
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
                    padding: const EdgeInsets.only(top: 20,bottom: 20,right: 10,left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('PHP',style: TextStyle(fontSize: 20),),
                        Text('12, 500',style: TextStyle(fontSize: 20),)
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20,),

                Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'SELL',
                              style: TextStyle(color: Colors.black,fontSize: 20),
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
