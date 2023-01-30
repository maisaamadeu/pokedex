import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:pokedex/repository/pokemon_model.dart';

class PokemonRepository {
  Future<List<dynamic>> getPokemon({
    String limit = '100000',
    String offset = '0',
  }) async {
    var url = Uri.https(
      'pokeapi.co',
      'api/v2/pokemon',
      {
        'limit': limit,
        'offset': offset,
      },
    );
    var response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List pokemon = map['results'];
      pokemon = pokemon.map((json) => PokemonModel.fromJson(json)).toList();

      return pokemon;
    } else {
      throw ('ERRO');
    }
  }
}
