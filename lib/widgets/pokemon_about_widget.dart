import 'package:flutter/material.dart';
import 'package:pokedex/widgets/pokemon_about_item_widget.dart';

class PokemonAbouWidget extends StatelessWidget {
  const PokemonAbouWidget(
      {super.key,
      required this.futureBuilderPokemonDetails,
      required this.weakness,
      required this.typesColors,
      required this.futureBuilderTrainingData});
  final AsyncSnapshot<Map<String, dynamic>?> futureBuilderPokemonDetails;
  final AsyncSnapshot<Map<String, dynamic>> futureBuilderTrainingData;
  final Future<List<String>> weakness;
  final List<Map<String, dynamic>> typesColors;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Text(
            futureBuilderTrainingData.data!['flavor_text_entries'][0]
                    ['flavor_text']
                .toString()
                .replaceAll('\n', ' ')
                .replaceAll('\f', ' ')
                .replaceAll('POKéMON', 'pokémon'),
            style: const TextStyle(
              color: Colors.black54,
              fontFamily: 'sf',
              fontSize: 20,
            ),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Pokedéx Data',
            style: TextStyle(
              color: Colors.blueGrey[500],
              fontFamily: 'sf',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          PokemonAboutItemWidget(
            itemName: 'Species',
            results: futureBuilderPokemonDetails.data!['species']['name']
                    .toString()
                    .split('')
                    .first
                    .toUpperCase() +
                futureBuilderPokemonDetails.data!['species']['name']
                    .toString()
                    .substring(1),
          ),
          PokemonAboutItemWidget(
            itemName: 'Height',
            results: futureBuilderPokemonDetails.data!['height'] < 10
                ? '0.${futureBuilderPokemonDetails.data!['height']}m'
                : '${futureBuilderPokemonDetails.data!['height']}m',
          ),
          PokemonAboutItemWidget(
            itemName: 'Weight',
            results: futureBuilderPokemonDetails.data!['weight'] < 1
                ? '0.${futureBuilderPokemonDetails.data!['weight']}kg'
                : '${futureBuilderPokemonDetails.data!['weight']}kg',
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(children: [
              const SizedBox(
                width: 120,
                child: Text(
                  'Abilities',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'sf',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Flexible(
                child: ListView.builder(
                  itemCount:
                      futureBuilderPokemonDetails.data!['abilities'].length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Text(
                      '${index + 1}. ${futureBuilderPokemonDetails.data!['abilities'][index]['ability']['name'].toString().split('').first.toUpperCase() + futureBuilderPokemonDetails.data!['abilities'][index]['ability']['name'].toString().substring(1)}',
                      style: TextStyle(
                        color: Colors.black54,
                        fontFamily: 'sf',
                        fontSize: 20,
                      ),
                    );
                  },
                ),
              ),
            ]),
          ),
          FutureBuilder(
            future: weakness,
            builder: (context, typesSnapshot) {
              switch (typesSnapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  if (typesSnapshot.hasError) {
                    return const Center(
                      child: Text(
                        'An error occurred while loading the data, please try again later. We apologize for the inconvenience.carregar os dados :D',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    return SizedBox(
                      height: 40,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 120,
                            child: Text(
                              'Weakness',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'sf',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: typesSnapshot.data!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                // print(typesSnapshot.data);
                                // return Text(typesSnapshot.data![index]);
                                dynamic color;
                                for (var element in typesColors) {
                                  if (element["type"] ==
                                      typesSnapshot.data![index]) {
                                    color = element['color'];
                                  }
                                }
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 2,
                                  ),
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    color: color,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        typesSnapshot.data![index]
                                            .toString()
                                            .toUpperCase(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              }
            },
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            'Pokedéx Data',
            style: TextStyle(
              color: Colors.blueGrey[500],
              fontFamily: 'sf',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          PokemonAboutItemWidget(
            itemName: 'Catch Rate',
            results: futureBuilderTrainingData.data!['capture_rate'].toString(),
          ),
          PokemonAboutItemWidget(
            itemName: 'Base Friendship',
            results:
                futureBuilderTrainingData.data!['base_happiness'].toString(),
          ),
          PokemonAboutItemWidget(
            itemName: 'Growth Rate',
            results: futureBuilderTrainingData.data!['growth_rate']['name']
                    .toString()
                    .split('')
                    .first
                    .toUpperCase() +
                futureBuilderTrainingData.data!['growth_rate']['name']
                    .toString()
                    .substring(1),
          ),
        ],
      ),
    );
  }
}
