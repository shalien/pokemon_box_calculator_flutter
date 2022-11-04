
import 'dart:convert';

import 'package:flutter/services.dart';

PokemonManager? _instance;

class PokemonManager {

  final Map<int, String> pokemons = <int, String>{};

  PokemonManager._();

  factory PokemonManager() {
    return _instance ??= PokemonManager._();
  }

  Future<void> loadPokemonList() async {
    String csvFile = await rootBundle.loadString("assets/pokemon_en_fr.csv");

    for(var line in const LineSplitter().convert(csvFile)) {
      var splitLine = line.trim().split(';');
      var index = splitLine.first;
      var name = splitLine.last;

      if (index.toLowerCase() == 'ndex') {
        continue;
      }

      pokemons[int.parse(index)] = name;
    }
  }
}