import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'package:simple_cryptotrading_app/buybtc.dart';
import 'package:simple_cryptotrading_app/buyeth.dart';
import 'package:simple_cryptotrading_app/main.dart';
import 'package:simple_cryptotrading_app/sellbtc.dart';
import 'package:simple_cryptotrading_app/selleth.dart';
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
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Connecting error'),
            content: Text('Please check your internet and try again. '),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Homepage()));
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
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
                    "$currency_name",
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
                    "$currency_shortcut $currency",
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
                        minY: 0,
                        maxY: prices
                            .map<double>((e) => e[1] as double)
                            .reduce((a, b) => a > b ? a : b),
                        lineTouchData: LineTouchData(
                          touchTooltipData: LineTouchTooltipData(
                            tooltipBgColor: Colors.blueAccent.withOpacity(0.8),
                            tooltipRoundedRadius: 8,
                            getTooltipItems: (List<LineBarSpot> touchedSpots) {
                              // List to hold the tooltip items
                              final List<LineTooltipItem> tooltipItems = [];

                              // Loop through each touched spot
                              for (final spot in touchedSpots) {
                                // Get the corresponding price data
                                final price = spot.y;

                                // Get the corresponding date data
                                final dateString = prices[spot.x!.toInt()][0];
                                final date = DateTime.parse(dateString);

                                // Format the date
                                final formattedDate = DateFormat('yyyy-MM-dd').format(date);

                                // Add tooltip item with value and date
                                tooltipItems.add(
                                  LineTooltipItem(
                                    '\₱${price.toStringAsFixed(2)}\n$formattedDate',
                                    const TextStyle(color: Colors.white),
                                  ),
                                );
                              }

                              return tooltipItems;
                            },
                          ),
                          touchCallback: (LineTouchResponse touchResponse) {},
                          // Other touch data configurations...
                        ),
                        // Other chart configurations...
                        titlesData: FlTitlesData(
                          leftTitles: SideTitles(
                            showTitles: true,
                            getTextStyles: (value) => TextStyle(color: Colors.black, fontSize: 12),
                            getTitles: (value) {
                              // Convert value to millions or thousands format
                              if (currency_name == "BITCOIN") {
                                if (value >= 1000000) {
                                  return '\₱${(value ~/ 1000000)}M';
                                } else {
                                  return '\₱${(value ~/ 1000)}';
                                }
                              } else if (currency_name == "ETHEREUM") {
                                if (value >= 1000000) {
                                  return '${(value ~/ 100000)}K';
                                } else {
                                  return '${(value ~/ 1000)}K';
                                }
                              }
                              return ''; // Default empty string if currency_name is neither BITCOIN nor ETHEREUM
                            },
                            interval: currency_name == "BITCOIN" ? 1000000 : 50000, // Set interval based on currency_name
                          ),
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
                            isCurved: true,
                            colors: [
                              Colors.green.withOpacity(0.5), // Set the line color to green with opacity
                            ],
                            barWidth: 2,
                            isStrokeCapRound: true,
                            belowBarData: BarAreaData(
                              show: true,
                              colors: [Colors.green.withOpacity(0.3)], // Set the fill color to green with opacity
                            ),
                            dotData: FlDotData(
                              show: false, // Hide the dots
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
                    Text("$market_cap", style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,),),
                  ],
                ),
              ),

              SizedBox(height: 3,),
              Container(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("24 Hour Trading Vol", style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,),),
                    Text("$volume", style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,),),
                  ],
                ),
              ),
              SizedBox(height: 5,),


              // Other widgets...
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Buy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Sell',
          ),
        ],
        backgroundColor: Color.fromRGBO(27, 27, 27, 1),
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) { // Check if the "Buy" button is pressed
            if(currency_name == "BITCOIN")
              {

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BuyBTCPage()));
              }
            else
              {

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BuyETHPage()));
              }

          }
          else
            {
              if(currency_name == "BITCOIN")
              {

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SellBTCPage()));
              }
              else
              {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SellETHPage()));
              }

            }
        },
      ),
    );
  }
}
