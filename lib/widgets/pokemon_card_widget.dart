import 'package:flutter/material.dart';
import 'package:pokedex/pages/pokemon_details.dart';
import 'package:pokedex/widgets/pokemon_types_widget.dart';

class PokemonCardWidget extends StatelessWidget {
  const PokemonCardWidget(
      {super.key,
      required this.index,
      required this.results,
      required this.pokemonDetails,
      required this.typesColors});
  final int index;
  final dynamic results;
  final Future<Map<String, dynamic>> pokemonDetails;
  final List<Map<String, dynamic>> typesColors;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PokemonDetails(
              pokemonDetails: pokemonDetails,
              typesColors: typesColors,
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
              Positioned(
                left: 20,
                top: 30,
                child: Text(
                  results![index]['name']
                          .toString()
                          .split('')
                          .first
                          .toUpperCase() +
                      results[index]['name'].toString().substring(1),
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
              PokemonTypesWidget(
                typesColors: typesColors,
                pokemonDetails: pokemonDetails,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
