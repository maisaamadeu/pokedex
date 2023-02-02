import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pokedex/widgets/pokemon_types_widget.dart';

class PokemonDetails extends StatefulWidget {
  const PokemonDetails(
      {super.key, required this.pokemonDetails, required this.typesColors});
  final Future<Map<String, dynamic>> pokemonDetails;
  final List<Map<String, dynamic>> typesColors;

  @override
  State<PokemonDetails> createState() => _PokemonDetailsState();
}

class _PokemonDetailsState extends State<PokemonDetails>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);

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
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          snapshot.data!['sprites']['other']['official-artwork']
                              ['front_default'],
                          height: 150,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
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
                            Text(
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
                            const SizedBox(
                              height: 10,
                            ),
                            PokemonTypesWidget(
                                typesColors: this.widget.typesColors,
                                pokemonDetails: this.widget.pokemonDetails)
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
                      tabs: [
                        Tab(
                          text: 'Sobre',
                        ),
                        Tab(
                          text: 'Status',
                        ),
                        Tab(
                          text: 'Evoluções',
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: TabBarView(
                          controller: _controller,
                          children: <Widget>[
                            Center(
                              child: Text("It's cloudy here"),
                            ),
                            Center(
                              child: Text("It's rainy here"),
                            ),
                            Center(
                              child: Text("It's sunny here"),
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
      ),
    );
  }
}
