import 'package:flutter/material.dart';
import 'package:pokedex/repository/pokemon_repository.dart';
import 'package:pokedex/widgets/pokemon_about_widget.dart';
import 'package:pokedex/widgets/pokemon_evolution_widget.dart';
import 'package:pokedex/widgets/pokemon_types_widget.dart';

class PokemonDetails extends StatefulWidget {
  const PokemonDetails(
      {super.key,
      required this.pokemonDetails,
      required this.typesColors,
      required this.name});
  final Future<Map<String, dynamic>> pokemonDetails;
  final List<Map<String, dynamic>> typesColors;
  final String name;

  @override
  State<PokemonDetails> createState() => _PokemonDetailsState();
}

class _PokemonDetailsState extends State<PokemonDetails>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  late Future<List<String>> listWeakness;
  late Future<Map<String, dynamic>> trainingData;

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    listWeakness = PokemonRepository().getWeakness(widget.name);
    trainingData = PokemonRepository().getTrainingData(widget.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueGrey[200],
      ),
      body: FutureBuilder(
        future: widget.pokemonDetails,
        builder: (context, futureBuilderPokemonDetails) {
          switch (futureBuilderPokemonDetails.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (futureBuilderPokemonDetails.hasError) {
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
                return FutureBuilder(
                  future: trainingData,
                  builder: (context, futureBuilderTrainingData) {
                    switch (futureBuilderTrainingData.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        if (futureBuilderTrainingData.hasError) {
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
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    futureBuilderPokemonDetails.data!['sprites']
                                            ['other']['official-artwork']
                                        ['front_default'],
                                    height: 150,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        futureBuilderPokemonDetails
                                                    .data!['id'] <
                                                10
                                            ? '#000${futureBuilderPokemonDetails.data!['id']}'
                                            : futureBuilderPokemonDetails
                                                        .data!['id'] <
                                                    99
                                                ? '#00${futureBuilderPokemonDetails.data!['id']}'
                                                : futureBuilderPokemonDetails
                                                            .data!['id'] <
                                                        999
                                                    ? '#0${futureBuilderPokemonDetails.data!['id']}'
                                                    : '#${futureBuilderPokemonDetails.data!['id']}',
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'sf',
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        futureBuilderPokemonDetails
                                                .data!['name']
                                                .toString()
                                                .split('')
                                                .first
                                                .toUpperCase() +
                                            futureBuilderPokemonDetails
                                                .data!['name']
                                                .toString()
                                                .substring(1),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'sf',
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      PokemonTypesWidget(
                                          typesColors: widget.typesColors,
                                          pokemonDetails: widget.pokemonDetails)
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              TabBar(
                                indicatorColor: Colors.transparent,
                                controller: _controller,
                                tabs: const [
                                  Tab(
                                    text: 'About',
                                  ),
                                  Tab(
                                    text: 'Status',
                                  ),
                                  Tab(
                                    text: 'Evolution',
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    ),
                                  ),
                                  child: TabBarView(
                                    controller: _controller,
                                    children: <Widget>[
                                      PokemonAbouWidget(
                                        futureBuilderPokemonDetails:
                                            futureBuilderPokemonDetails,
                                        weakness: listWeakness,
                                        typesColors: widget.typesColors,
                                        futureBuilderTrainingData:
                                            futureBuilderTrainingData,
                                      ),
                                      Center(
                                        child: Text("It's rainy here"),
                                      ),
                                      PokemonEvolutionWidget(
                                        futureBuilderTrainingData:
                                            futureBuilderTrainingData,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                    }
                  },
                );
              }
          }
        },
      ),
    );
  }
}
