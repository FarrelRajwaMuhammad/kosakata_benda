import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kosakata_benda/data/models/game_model.dart';

// Future<void> postGameToAPI(Game game) async {
//   final response = await http.post(
//     Uri.parse('http://192.168.1.14:8080/game/api/games'),
//     headers: {'Content-Type': 'application/json'},  
//     body: jsonEncode(game.toJson()),
//   );

//   if (response.statusCode != 201 && response.statusCode != 200) {
//     print("Gagal menyimpan data game: ${response.body}");
//   }
// }