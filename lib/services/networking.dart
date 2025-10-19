import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String url;
  NetworkHelper(this.url);

  Future<dynamic> getData() async {
    try {
      final uri = Uri.parse(url);              // use the constructor field, not a new `url` var
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Request failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Network error: $e');
      return null;
    }
  }
}
