import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future<Map> getData() async {
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
