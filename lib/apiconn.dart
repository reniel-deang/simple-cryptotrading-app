import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

String? currency = "usd";
bool? market_cap = true;
bool? day_vol = true;
String? presion = "full";
final String apikey = "CG-j9k6XsDnbYo6kCzPjE1WiHWc";

var millis = 1712361600000;
var dt = DateTime.fromMillisecondsSinceEpoch(millis);

// 12 Hour format:
var d12 = DateFormat('MM/dd/yyyy').format(dt);

final String link  = "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&&vs_currencies=$currency&&include_market_cap=$market_cap&&include_24hr_vol=$day_vol&&precision=$presion";

final Map<String, String> headers = {
  'x_cg_demo_api_key' : apikey,
};

Future <void> getdata() async
{
  final currencyprice = await http.get(
    Uri.parse(link),
    headers: headers,
  );

  final fetchdata = jsonDecode(currencyprice.body);

  print(fetchdata);
  print(d12);
}