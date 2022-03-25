import 'dart:convert';
import 'dart:async';

import 'package:academic_app/shared/config.dart';
import 'package:http/http.dart' as http;

class VideoApi {
  static String baseUrl = 'https://api.pexels.com/videos/search';
  static String token = Config.tokenPexels;

  static Future<Iterable> getVideos(Map<String, String> params) async {
    Uri url = Uri.parse(VideoApi.baseUrl);

    final finalUri = url.replace(queryParameters: params);

    var response = await http.get(finalUri, headers: {'Authorization': token});

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['videos'];
    } else {
      throw Exception(response.body);
    }
  }
}
