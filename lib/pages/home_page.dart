import 'package:flutter/material.dart';
import 'package:pokedex/repository/pokemon_model.dart';
import 'package:pokedex/repository/pokemon_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<dynamic>> pokemonList;
  @override
  void initState() {
    super.initState();
    pokemonList = PokemonRepository().getPokemon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('POKEDEX'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: pokemonList,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
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
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.amber,
                      height: 300,
                      margin: EdgeInsets.only(
                        bottom: 20,
                      ),
                    );
                  },
                );
              }
          }
        },
      ),
    );
  }
}
