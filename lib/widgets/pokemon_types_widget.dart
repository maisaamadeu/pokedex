import 'package:flutter/material.dart';

class PokemonTypesWidget extends StatelessWidget {
  const PokemonTypesWidget(
      {super.key, required this.typesColors, required this.pokemonDetails});
  final List<Map<String, dynamic>> typesColors;
  final Future<Map<String, dynamic>?> pokemonDetails;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: pokemonDetails,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(),
            );
          default:
            if (snapshot.hasError) {
              return Text(
                'An error occurred while loading the data, please try again later. We apologize for the inconvenience.carregar os tipos dest pokemon',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              );
            } else {
              return SizedBox(
                height: 20,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!['types'].length,
                  itemBuilder: (context, i) {
                    var types = snapshot.data!['types'][i]['type']['name'];
                    dynamic color;
                    for (var element in typesColors) {
                      if (element["type"] == types) {
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
                            types.toString().toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
        }
      },
    );
  }
}
