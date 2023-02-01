import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/repository/pokemon_list__model.dart';
import 'package:pokedex/repository/pokemon_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color defaultColorCardPokemon = Colors.orangeAccent;
  late Future<Map<String, dynamic>> pokemonList;

  List<Map<String, dynamic>> typesColors = [
    {"type": "normal", "color": Colors.grey[300]},
    {"type": "fighting", "color": Colors.brown},
    {"type": "flying", "color": Colors.lightBlue},
    {"type": "poison", "color": Colors.purple},
    {"type": "ground", "color": Colors.deepOrange},
    {"type": "rock", "color": Colors.brown[300]},
    {"type": "bug", "color": Colors.lightGreen},
    {"type": "ghost", "color": Colors.indigo},
    {"type": "steel", "color": Colors.grey},
    {"type": "fire", "color": Colors.red},
    {"type": "water", "color": Colors.blue},
    {"type": "grass", "color": Colors.green},
    {"type": "electric", "color": Colors.yellow},
    {"type": "psychic", "color": Colors.pink[200]},
    {"type": "ice", "color": Colors.lightBlue[100]},
    {"type": "dragon", "color": Colors.blue[900]},
    {"type": "dark", "color": Colors.black54},
    {"type": "fairy", "color": Colors.pinkAccent[100]},
    {"type": "unknown", "color": Colors.teal},
    {"type": "shadow", "color": Colors.grey[900]}
  ];

  @override
  void initState() {
    super.initState();
    pokemonList = PokemonRepository().getPokemonList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffF7F7F7),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.grain,
              color: Colors.black87,
              size: 25,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.sort,
              color: Colors.black87,
              size: 25,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.tune,
              color: Colors.black87,
              size: 25,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: FutureBuilder(
          future: pokemonList,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Erro ao carregar os dados :D',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  var results = snapshot.data!['results'];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Pokédex',
                        style: TextStyle(
                          fontFamily: 'sf',
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 40,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Procure por um Pokemon usando um nome ou usando o número da pokédex',
                        style: TextStyle(
                          fontFamily: 'sf',
                          fontSize: 18,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Qual pokemon você está procurando?',
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.grey[250],
                          contentPadding: const EdgeInsets.all(20),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: results.length,
                          itemBuilder: (context, index) {
                            var name = results[index]['name'].toString();
                            late Future<Map<String, dynamic>> pokemonDetails =
                                PokemonRepository()
                                    .getPokemonDetails(name: name);
                            return Card(
                              margin: const EdgeInsets.only(top: 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: Colors.blueGrey[200],
                              child: SizedBox(
                                height: 100,
                                child: Stack(
                                  fit: StackFit.loose,
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      top: 10,
                                      left: 20,
                                      child: Text(
                                        index + 1 < 10
                                            ? '#000${index + 1}'
                                            : index + 1 < 99
                                                ? '#00${index + 1}'
                                                : index + 1 < 999
                                                    ? '#0${index + 1}'
                                                    : '#${index + 1}',
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'sf',
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    // Positioned(
                                    //   left: 20,
                                    //   top: 30,
                                    //   child: Text(
                                    //     results[index]['name']
                                    //             .toString()
                                    //             .split('')
                                    //             .first
                                    //             .toUpperCase() +
                                    //         results[index]['name']
                                    //             .toString()
                                    //             .substring(1),
                                    //     style: TextStyle(
                                    //       fontFamily: 'sf',
                                    //       fontSize: 24,
                                    //       fontWeight: FontWeight.bold,
                                    //       foreground: Paint()
                                    //         ..style = PaintingStyle.stroke
                                    //         ..strokeWidth = 3
                                    //         ..color = Colors.black,
                                    //     ),
                                    //   ),
                                    // ),
                                    Positioned(
                                      left: 20,
                                      top: 30,
                                      child: Text(
                                        results[index]['name']
                                                .toString()
                                                .split('')
                                                .first
                                                .toUpperCase() +
                                            results[index]['name']
                                                .toString()
                                                .substring(1),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'sf',
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 235,
                                      bottom: 20,
                                      child: Image.network(
                                        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${index + 1}.png',
                                        fit: BoxFit.contain,
                                        height: 120,
                                      ),
                                    ),
                                    FutureBuilder(
                                      future: pokemonDetails,
                                      builder: (context, snapshot) {
                                        switch (snapshot.connectionState) {
                                          case ConnectionState.none:
                                          case ConnectionState.waiting:
                                            return const Positioned(
                                              bottom: 10,
                                              left: 20,
                                              child: SizedBox(
                                                height: 20,
                                                width: 20,
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            );
                                          default:
                                            if (snapshot.hasError) {
                                              return const Positioned(
                                                bottom: 0,
                                                left: 20,
                                                child: Text(
                                                  'Erro ao carregar os tipos dest pokemon',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              );
                                            } else {
                                              return Positioned(
                                                bottom: 10,
                                                left: 20,
                                                child: SizedBox(
                                                  height: 20,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: snapshot
                                                        .data!['types'].length,
                                                    itemBuilder: (context, i) {
                                                      var types = snapshot
                                                              .data!['types'][i]
                                                          ['type']['name'];
                                                      var color = Colors.red;
                                                      for (var element
                                                          in typesColors) {
                                                        if (element["type"] ==
                                                            types) {
                                                          color =
                                                              element['color'];
                                                        }
                                                      }
                                                      return Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          horizontal: 5,
                                                          vertical: 2,
                                                        ),
                                                        margin: EdgeInsets.only(
                                                            right: 10),
                                                        decoration: BoxDecoration(
                                                            color: color,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3)),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                              types
                                                                  .toString()
                                                                  .toUpperCase(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              );
                                            }
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
            }
          },
        ),
      ),
    );
  }
}
