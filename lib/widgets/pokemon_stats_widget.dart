import 'package:flutter/material.dart';
import 'package:pokedex/widgets/pokemon_about_item_widget.dart';

class PokemonStatsWidget extends StatefulWidget {
  PokemonStatsWidget({super.key, required this.futureBuilderPokemonDetails});
  final AsyncSnapshot<Map<String, dynamic>> futureBuilderPokemonDetails;

  @override
  State<PokemonStatsWidget> createState() => _PokemonStatsWidgetState();
}

class _PokemonStatsWidgetState extends State<PokemonStatsWidget> {
  int totalStats = 1;
  bool isTotalStatsFull = false;

  @override
  void initState() {
    if (isTotalStatsFull == false) {
      isTotalStatsFull = true;
      for (var i = 0;
          i < widget.futureBuilderPokemonDetails.data!['stats'].length;
          i++) {
        totalStats += int.parse(widget
            .futureBuilderPokemonDetails.data!['stats'][i]['base_stat']
            .toString());
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'Base Stats',
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
            ListView.builder(
              shrinkWrap: true,
              itemCount:
                  widget.futureBuilderPokemonDetails.data!['stats'].length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 80,
                        child: Text(
                          widget.futureBuilderPokemonDetails
                              .data!['stats'][index]['stat']['name']
                              .toString()
                              .toUpperCase()
                              .replaceAll('-', ' '),
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'sf',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        widget.futureBuilderPokemonDetails
                            .data!['stats'][index]['base_stat']
                            .toString(),
                        style: const TextStyle(
                          color: Colors.black54,
                          fontFamily: 'sf',
                          fontSize: 20,
                        ),
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbColor: Colors.transparent,
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 0.0,
                          ),
                        ),
                        child: Slider(
                          value: double.parse(widget.futureBuilderPokemonDetails
                              .data!['stats'][index]['base_stat']
                              .toString()),
                          onChanged: (value) {},
                          min: 0,
                          max: 300,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      'TOTAL',
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'sf',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    totalStats.toString(),
                    style: const TextStyle(
                      color: Colors.black54,
                      fontFamily: 'sf',
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
