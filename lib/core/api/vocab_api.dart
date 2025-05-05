import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kosakata_benda/data/models/vocab_model.dart';

class VocabApi {
  static Future<List<Vocab>> fetchVocabs() async {
    final res = await http.get(
      Uri.parse('https://sxkykrzzconjmvqidcxc.supabase.co/rest/v1/vocabs'),
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN4a3lrcnp6Y29uam12cWlkY3hjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQ2MDIxNDQsImV4cCI6MjA2MDE3ODE0NH0.cCV1lIlSlGjU3xlON04PfCGykHalGidI7FiMXrcCbns',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN4a3lrcnp6Y29uam12cWlkY3hjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQ2MDIxNDQsImV4cCI6MjA2MDE3ODE0NH0.cCV1lIlSlGjU3xlON04PfCGykHalGidI7FiMXrcCbns',
      },
    );

    print('Status Code: ${res.statusCode}');
    print('Response Body: ${res.body}');

    if (res.statusCode == 200) {
      List data = json.decode(res.body);
      return data.map((e) => Vocab.fromJson(e)).toList();
    } else {
      throw Exception('Gagal load vocab');
    }
  }

  // static Future<void> createVocabs(List<Vocab> vocabs) async {
  //   final res = await http.post(
  //     Uri.parse('$baseUrl/'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: json.encode(vocabs.map((v) => v.toJson()).toList()),
  //   );
  //   if (res.statusCode != 201) {
  //     throw Exception('Gagal membuat vocab');
  //   }
  // }
}
