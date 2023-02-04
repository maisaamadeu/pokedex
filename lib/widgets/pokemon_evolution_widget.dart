import 'package:flutter/material.dart';
import 'package:pokedex/repository/pokemon_repository.dart';

class PokemonEvolutionWidget extends StatefulWidget {
  const PokemonEvolutionWidget(
      {super.key, required this.futureBuilderTrainingData});
  final AsyncSnapshot<Map<String, dynamic>> futureBuilderTrainingData;

  @override
  State<PokemonEvolutionWidget> createState() => _PokemonEvolutionWidgetState();
}

class _PokemonEvolutionWidgetState extends State<PokemonEvolutionWidget> {
  late Future<Map<String, dynamic>> evolutionChain;
  @override
  void initState() {
    super.initState();
    evolutionChain = PokemonRepository().getEvolutionChain(widget
        .futureBuilderTrainingData.data!['evolution_chain']['url']
        .toString()
        .replaceAll('https://pokeapi.co/', ''));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: evolutionChain,
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
                    'There was an error acquiring the Pokémon\'s evolutions! Try again later!'),
              );
            } else {
              if (snapshot.data!['chain']['evolves_to'].length > 0) {
                if (snapshot.data!['chain']['species']['name'] == 'eevee') {
                  return SingleChildScrollView(
                    child: Column(children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        snapshot.data!['chain']['species']['name']
                            .toString()
                            .toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Image.network(
                        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${snapshot.data!['chain']['species']['url'].toString().replaceAll('https://pokeapi.co/api/v2/pokemon-species/', '').replaceAll('/', '')}.png',
                        height: 150,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.south_west,
                            size: 48,
                            color: Colors.black,
                          ),
                          const Icon(
                            Icons.south_east,
                            size: 48,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemCount:
                                snapshot.data!['chain']['evolves_to'].length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  Text(
                                    snapshot.data!['chain']['evolves_to'][index]
                                            ['species']['name']
                                        .toString()
                                        .toUpperCase(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    ),
                                  ),
                                  Image.network(
                                    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${snapshot.data!['chain']['evolves_to'][index]['species']['url'].toString().replaceAll('https://pokeapi.co/api/v2/pokemon-species/', '').replaceAll('/', '')}.png',
                                    height: 120,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              );
                            }),
                      ),
                    ]),
                  );
                } else {
                  if (snapshot.data!['chain']['evolves_to'][0]['evolves_to']
                          .length >
                      0) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            snapshot.data!['chain']['species']['name']
                                .toString()
                                .toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          Image.network(
                            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${snapshot.data!['chain']['species']['url'].toString().replaceAll('https://pokeapi.co/api/v2/pokemon-species/', '').replaceAll('/', '')}.png',
                            height: 150,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Icon(
                            Icons.arrow_downward,
                            size: 48,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            snapshot.data!['chain']['evolves_to'][0]['species']
                                    ['name']
                                .toString()
                                .toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          Image.network(
                            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${snapshot.data!['chain']['evolves_to'][0]['species']['url'].toString().replaceAll('https://pokeapi.co/api/v2/pokemon-species/', '').replaceAll('/', '')}.png',
                            height: 150,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Icon(
                            Icons.arrow_downward,
                            size: 48,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            snapshot.data!['chain']['evolves_to'][0]
                                    ['evolves_to'][0]['species']['name']
                                .toString()
                                .toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          Image.network(
                            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${snapshot.data!['chain']['evolves_to'][0]['evolves_to'][0]['species']['url'].toString().replaceAll('https://pokeapi.co/api/v2/pokemon-species/', '').replaceAll('/', '')}.png',
                            height: 150,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            snapshot.data!['chain']['species']['name']
                                .toString()
                                .toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          Image.network(
                            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${snapshot.data!['chain']['species']['url'].toString().replaceAll('https://pokeapi.co/api/v2/pokemon-species/', '').replaceAll('/', '')}.png',
                            height: 150,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Icon(
                            Icons.arrow_downward,
                            size: 48,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            snapshot.data!['chain']['evolves_to'][0]['species']
                                    ['name']
                                .toString()
                                .toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          Image.network(
                            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${snapshot.data!['chain']['evolves_to'][0]['species']['url'].toString().replaceAll('https://pokeapi.co/api/v2/pokemon-species/', '').replaceAll('/', '')}.png',
                            height: 150,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    );
                  }
                }
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        snapshot.data!['chain']['species']['name']
                            .toString()
                            .toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Image.network(
                        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${snapshot.data!['chain']['species']['url'].toString().replaceAll('https://pokeapi.co/api/v2/pokemon-species/', '').replaceAll('/', '')}.png',
                        height: 150,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                );
              }
            }
        }
      },
    );
  }
}
