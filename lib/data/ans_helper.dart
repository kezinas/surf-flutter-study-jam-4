import 'dart:convert';

import 'package:http/http.dart' as http;

class AHelper {
  Future<String> getAnswer() async {
    const fullUri = 'https://eightballapi.com/api';
    final uri = Uri.parse(fullUri);
    try {
      final response = await http.get(uri);
      final result = jsonDecode(response.body);
      return result['reading'];
    } catch (error) {
      throw Error();
    }
  }
}
