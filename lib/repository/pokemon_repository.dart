import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:pokedex/pages/home_page.dart' as HomePage;

import 'package:pokedex/repository/pokemon_list__model.dart';

class PokemonRepository {
  Future<Map<String, dynamic>> getPokemonList({
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
      // Map<String, dynamic> map = json.decode(response.body);
      // List a = map['results'];
      // a = a.map((json) => PokemonModel.fromJson(json)).toList();

      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponse;
    } else {
      throw ('ERRO');
    }
  }

  Future<Map<String, dynamic>> getPokemonDetails({required String name}) async {
    var url = Uri.https('pokeapi.co', 'api/v2/pokemon/${name}');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponse;
    } else {
      throw ('ERRO');
    }
  }

  Future<Map<String, dynamic>> getTypes({required String name}) async {
    var url = Uri.https('pokeapi.co', 'api/v2/pokemon/${name}');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponse;
    } else {
      throw ('ERRO');
    }
  }
}
