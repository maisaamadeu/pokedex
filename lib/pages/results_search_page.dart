import 'package:flutter/material.dart';
import 'package:pokedex/pages/pokemon_details.dart';
import 'package:pokedex/repository/pokemon_repository.dart';
import 'package:pokedex/widgets/pokemon_card_widget.dart';
import 'package:pokedex/widgets/pokemon_types_widget.dart';

class ResultsSearchPage extends StatefulWidget {
  const ResultsSearchPage(
      {super.key, required this.nameOrId, required this.typesColors});
  final String nameOrId;
  final List<Map<String, dynamic>> typesColors;

  @override
  State<ResultsSearchPage> createState() => _ResultsSearchPageState();
}

class _ResultsSearchPageState extends State<ResultsSearchPage> {
  late Future<Map<String, dynamic>?> pokemonDetails;

  @override
  void initState() {
    super.initState();
    pokemonDetails =
        PokemonRepository().getPokemonDetails(name: widget.nameOrId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: FutureBuilder(
        future: pokemonDetails,
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
                    'An error occurred while loading the data, please try again later. We apologize for the inconvenience.',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                if (snapshot.data == null) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Center(
                      child: Text(
                        'This Pokémon does not exist, please return and check if you have typed the name correctly.',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PokemonDetails(
                                pokemonDetails: pokemonDetails,
                                typesColors: widget.typesColors,
                                name: snapshot.data!['name'].toString(),
                              ),
                            ),
                          );
                        },
                        child: Card(
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
                                    snapshot.data!['id'] < 10
                                        ? '#000${snapshot.data!['id']}'
                                        : snapshot.data!['id'] < 99
                                            ? '#00${snapshot.data!['id']}'
                                            : snapshot.data!['id'] < 999
                                                ? '#0${snapshot.data!['id']}'
                                                : '#${snapshot.data!['id']}',
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontFamily: 'sf',
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 20,
                                  top: 30,
                                  child: Text(
                                    snapshot.data!['name']
                                            .toString()
                                            .split('')
                                            .first
                                            .toUpperCase() +
                                        snapshot.data!['name']
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
                                    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${snapshot.data!['id']}.png',
                                    fit: BoxFit.contain,
                                    height: 120,
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 20,
                                  child: PokemonTypesWidget(
                                    typesColors: widget.typesColors,
                                    pokemonDetails: pokemonDetails,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              }
          }
        },
      ),
    );
  }
}
