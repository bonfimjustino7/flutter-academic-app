import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String get tokenPexels => _get('TOKEN_PEXELS');

  static String _get(String name) => dotenv.env[name] ?? '';
}
