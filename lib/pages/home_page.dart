import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pokedex/repository/pokemon_repository.dart';
import 'package:pokedex/widgets/pokemon_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color defaultColorCardPokemon = Colors.orangeAccent;
  late Future<Map<String, dynamic>> pokemonList;

  List<Map<String, dynamic>> typesColors = [
    {"type": "normal", "color": Colors.grey[400]},
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
                        'Search for Pokémon by name or using the National Pokédex number.',
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
                          hintText: 'What Pokémon you are looking for?',
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
                            return PokemonCardWidget(
                              index: index,
                              results: results,
                              pokemonDetails: pokemonDetails,
                              typesColors: typesColors,
                              name: name,
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
