import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:simple_cryptotrading_app/Overview.dart';
import 'package:simple_cryptotrading_app/apiconn.dart';
import 'data.dart';
import 'buyeth.dart';
import 'buybtc.dart';
import 'sellbtc.dart';
import 'selleth.dart';




void main() {
  runApp(MaterialApp(
    home: Homepage(),
    debugShowCheckedModeBanner: false,
  ));
}

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);
  @override

  Widget build(BuildContext context) {
    String Balance = balance.toString();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon:Icon(Icons.menu, color: Colors.black)),
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Text('Barya Tuko'),
          ],
        ),
      ),
      body: SingleChildScrollView(
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
          child: Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.account_circle_outlined, color: Colors.black, size: 30,),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.qr_code_scanner_outlined, color: Colors.black, size: 30,),
                                  ),
                                ],
                              ),
                            ),
                            Text('Total balance', style: TextStyle(color: Colors.grey),),
                            Text(
                              Balance,
                              style: TextStyle(color: Colors.black, fontSize: 30),
                            ),

                            SizedBox(height: 20,),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center, // Change to center
                                children: [

                                  Container(
                                    width: 150,
                                    height: 50,
                                    margin: EdgeInsets.only(right: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color.fromRGBO(27, 27, 27, 1),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('What do you want to buy?'),
                                              //content: Text('Are you sure you want to buy crypto?'),
                                              actions: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [

                                                    Container(
                                                      child: Row(
                                                        children: [
                                                          ElevatedButton(
                                                              onPressed: () async{
                                                                currency_name = "BITCOIN";
                                                                currency_shortcut = "BTC";
                                                                crypto = "bitcoin";
                                                                Navigator.push(context, MaterialPageRoute(builder: (context) => Overview()));
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  Image.asset('assets/bitcoin.png', height: 40,),
                                                                  SizedBox(width: 5,),
                                                                  Text('BTC')
                                                                ],
                                                              )
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                                SizedBox(height: 20,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Cancel'),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Text(
                                        'BUY',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),


                                  Container(
                                    width: 150,
                                    height: 50,
                                    margin: EdgeInsets.only(left: 20), // Add margin to the left
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color.fromRGBO(27, 27, 27, 1),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('What do you want to sell?'),
                                              //content: Text('Are you sure you want to buy crypto?'),
                                              actions: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [

                                                    Container(
                                                      child: Row(
                                                        children: [
                                                          ElevatedButton(
                                                              onPressed: () {
                                                                currency_name = "BITCOIN";
                                                                currency_shortcut = "BTC";
                                                                crypto = "bitcoin";
                                                                Navigator.push(context, MaterialPageRoute(builder: (context) => Overview()));
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  Image.asset('assets/bitcoin.png', height: 40,),
                                                                  SizedBox(width: 5,),
                                                                  Text('BTC')
                                                                ],
                                                              )
                                                          ),
                                                        ],
                                                      ),
                                                    ),


                                                  ],
                                                ),

                                                SizedBox(height: 20,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Cancel'),
                                                    ),
                                                  ],
                                                ),

                                              ],
                                            );
                                          },
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Text(
                                        'SELL',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),


                          ],
                        ),
                      ),
                      SizedBox(height: 10,),


                      Container(
                        height: 400,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(242, 243, 245, 1),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Assets'),
                                              IconButton(
                                                onPressed: () {},
                                                icon: Icon(Icons.add),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 20,),
                                          Row(
                                            children: [
                                              Image.asset('assets/bitcoin.png',height: 40,),
                                              SizedBox(width: 10,),
                                              Text('Bitcoin : $ownbitcoin'),
                                            ],
                                          ),
                                          SizedBox(height: 20,),

                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
