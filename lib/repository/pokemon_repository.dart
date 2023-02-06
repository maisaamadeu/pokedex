import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

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

  Future<Map<String, dynamic>?> getPokemonDetails(
      {required String name}) async {
    var url = Uri.https('pokeapi.co', 'api/v2/pokemon/$name');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponse;
    } else {
      return null;
    }
  }

  Future<List<String>> getWeakness(name) async {
    List<String> weaknessList = [];
    var url = Uri.https('pokeapi.co', 'api/v2/pokemon/$name');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

      for (var type in jsonResponse['types']) {
        var url2 =
            Uri.https('pokeapi.co', 'api/v2/type/${type['type']['name']}');
        var response2 = await http.get(url2);

        if (response2.statusCode == 200) {
          var jsonResponse2 =
              jsonDecode(response2.body) as Map<String, dynamic>;
          for (var weakness in jsonResponse2['damage_relations']
              ['double_damage_from']) {
            if (weaknessList.contains(weakness['name']) != true) {
              weaknessList.add(weakness['name']);
            }
          }
          return weaknessList;
        } else {
          throw ('ERRO');
        }
      }
    } else {
      throw ('ERRO');
    }
    return throw ('ERRO');
  }

  Future<Map<String, dynamic>> getTrainingData(String name) async {
    var url = Uri.https('pokeapi.co', 'api/v2/pokemon-species/$name');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponse;
    } else {
      throw ('ERRO');
    }
  }

  Future<Map<String, dynamic>> getEvolutionChain(String urlEnd) async {
    // var url = Uri.https('pokeapi.co', 'api/v2/pokemon-species/$name');
    var url = Uri.https('pokeapi.co', urlEnd);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponse;
    } else {
      throw ('ERRO');
    }
  }
}
