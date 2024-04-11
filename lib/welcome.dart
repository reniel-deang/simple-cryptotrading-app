import 'main.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
                //Image.asset('assets/bitcoin.png',height: 80,),
                SizedBox(height: 15,),
                
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('WELC',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                            Image.network('https://cdn0.iconfinder.com/data/icons/basic-11/97/55-512.png',height: 40,),
                            Text('ME',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Text('Introducing our Simple Stock Market Simulator',style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
                        SizedBox(height: 15,),
                        Divider(thickness: 2,color: Colors.black,),
                        SizedBox(height: 15,),
                        Text("Experience the thrill of trading stocks in a risk-free environment with our intuitive simulator. Whether you're a seasoned investor or just starting out, our app provides a realistic simulation of the stock market without any actual financial risk.",textAlign: TextAlign.center,style: TextStyle(color: Colors.black87),),

                        SizedBox(height: 20,),
                        Container(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>Homepage()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                'GET STARTED',
                                style: TextStyle(color: Colors.white,fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
