import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'apiconn.dart';
import 'package:intl/intl.dart';

class Overview extends StatefulWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  late List<List<dynamic>> prices = [];

  @override
  void initState() {

    super.initState();
    fetchData();

  }

  Future<void> fetchData() async {

    try{
      await getdata();

      final String historical_chart  = "https://api.coingecko.com/api/v3/coins/$crypto/market_chart?vs_currency=$currency&&days=$day&&interval=daily&&precision=2";

      final response = await http.get(Uri.parse(historical_chart));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        print(data);
        setState(() {
          prices = List<List<dynamic>>.from(data['prices']);
          for (var i = 0; i < prices.length; i++) {
            prices[i][0] = DateTime.fromMillisecondsSinceEpoch(prices[i][0])
                .toString(); // Convert timestamp to a readable format
          }
        });
      } else {
        throw Exception('Failed to load data');
      }
    }
    catch(e)
    {
      print("Error");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu, color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        title: Text('Barya Tuko'),
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
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text(
                  "OVERVIEW",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(height: 20,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "BTC-" + currency.toString().toUpperCase(),
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Bitcoin $currency",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                ],
              ),
              SizedBox(height: 10,),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "\₱ $value",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                height: 2,
                color: Colors.black12,
              ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25)
                ),
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: prices.isEmpty
                        ? CircularProgressIndicator()
                        : LineChart(
                      LineChartData(
                        minX: 0,
                        maxX: prices.length.toDouble(),
                        minY: prices
                            .map<double>((e) => e[1] as double)
                            .reduce((a, b) => a < b ? a : b),
                        maxY: prices
                            .map<double>((e) => e[1] as double)
                            .reduce((a, b) => a > b ? a : b),
                        titlesData: FlTitlesData(
                          leftTitles: SideTitles(showTitles: false),
                          bottomTitles: SideTitles(showTitles: false),
                        ),
                        gridData: FlGridData(show: true),
                        lineBarsData: [
                          LineChartBarData(
                            spots: List.generate(
                              prices.length,
                                  (index) => FlSpot(
                                index.toDouble(),
                                prices[index][1] as double,
                              ),
                            ),
                            isCurved: false,
                            colors: [Colors.blue],
                            barWidth: 2,
                            isStrokeCapRound: true,
                            belowBarData: BarAreaData(
                              show: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 60,),
              Row(
                children: [
                  Text("Bitcoin Statics", style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,),),
                ],
              ),
              Divider(
                height: 2,
                color: Colors.black12,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Market Cap", style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,),),
                    Text("20 132,111", style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,),),
                  ],
                ),
              ),

              SizedBox(height: 60,),
              SizedBox(height: 60,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Change to center
                children: [
                  Container(
                    width: 150,
                    height: 50,
                    margin: EdgeInsets.only(right: 20), // Add margin to the right
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(27, 27, 27, 1),
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Buy',
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
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Sell',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),

              // Other widgets...
            ],
          ),
        ),
      ),
    );
  }
}
