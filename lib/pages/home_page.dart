import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        child: FutureBuilder<List<dynamic>>(
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
                        'Procure por um Pokemon usando um nome ou usando o número da pokédex',
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
                          hintText: 'Qual pokemon você está procurando?',
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.grey[250],
                          contentPadding: const EdgeInsets.all(20),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Text(
                                  index + 1 < 10
                                      ? '#000${index + 1}'
                                      : index + 1 < 99
                                          ? '#00${index + 1}'
                                          : index + 1 < 999
                                              ? '#0${index + 1}'
                                              : '#${index + 1}',
                                ),
                                Text(
                                  snapshot.data![index].name.toString(),
                                ),
                              ],
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
