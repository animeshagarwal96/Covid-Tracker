import 'package:http/http.dart' as http;

class Api {
  static Future<http.Response> getCovidReport() {
    return http.get(Uri.parse('https://api.covidtracking.com/v1/us/daily.json'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'});
  }
}
