import 'package:flutter/material.dart';

class PokemonAboutItemWidget extends StatelessWidget {
  const PokemonAboutItemWidget(
      {super.key, required this.itemName, required this.results});
  final String itemName;
  final String results;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              itemName,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'sf',
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            results,
            style: TextStyle(
              color: Colors.black54,
              fontFamily: 'sf',
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
