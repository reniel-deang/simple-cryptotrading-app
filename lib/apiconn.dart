import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

//input
String? crypto = "bitcoin";
String? currency = "php";
bool? day_vol = true;
String?day = "5";
String? presion = "full";
final String apikey = "CG-j9k6XsDnbYo6kCzPjE1WiHWc";

//output
String? value = "0";


var millis = 1712361600000;
var dt = DateTime.fromMillisecondsSinceEpoch(millis);

// 12 Hour format:
var d12 = DateFormat('MM/dd/yyyy').format(dt);

final String link_value  = "https://api.coingecko.com/api/v3/simple/price?ids=$crypto&&vs_currencies=$currency&&include_24hr_vol=$day_vol&&precision=$presion";

final String historical_chart  = "https://api.coingecko.com/api/v3/coins/$crypto/market_chart?vs_currency=$currency&&days=$day&&interval=daily&&precision=2";

final Map<String, String> headers = {
  'x_cg_demo_api_key' : apikey,
};

Future <void> getdata() async
{
  final currencyprice = await http.get(
    Uri.parse(link_value),
    headers: headers,
  );

  final currencychart = await http.get(
    Uri.parse(historical_chart),
    headers: headers,
  );

  final fetchdata = jsonDecode(currencyprice.body);

  value = fetchdata['$crypto']['$currency'].toString();
  print(fetchdata);
  print(d12);
}