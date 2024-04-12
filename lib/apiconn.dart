import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

//input
String? crypto;
String? currency = "php";
bool? day_vol = true;
String?day = "365";
String? presion = "2";
final String apikey = "CG-j9k6XsDnbYo6kCzPjE1WiHWc";

//output
String value = "0";
String? market_cap = "0";
String? volume = "0";
String? currency_name;
String? currency_shortcut;


final String link_value  = "https://api.coingecko.com/api/v3/simple/price?ids=$crypto&&vs_currencies=$currency&&include_24hr_vol=$day_vol&&precision=$presion&&include_market_cap=true";

final String historical_chart  = "https://api.coingecko.com/api/v3/coins/$crypto/market_chart?vs_currency=$currency&&days=$day&&interval=daily&&precision=2";

final Map<String, String> headers = {
  'x_cg_demo_api_key' : apikey,
};

Future <void> getdata() async
{
  try{
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
    market_cap = fetchdata['$crypto']['php_market_cap'].toString();
    volume = fetchdata['$crypto']['php_24h_vol'].toString();
    print(fetchdata);

  }
  catch(e)
  {

  }

}