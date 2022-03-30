import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

class AtividadeService {
  static String baseUrl =
      'https://flutter-firebase-345714-default-rtdb.firebaseio.com/atividades.json';

  static Future save(Map data) async {
    Uri url = Uri.parse(baseUrl);

    var body = jsonEncode(data);

    var response = await http.post(url, body: body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  static Future list() async {
    Uri url = Uri.parse(baseUrl);

    var response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.body);
    }
  }
}
