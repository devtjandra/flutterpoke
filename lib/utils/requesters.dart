import 'dart:convert';

import 'package:flutterpoke/models.dart';
import 'package:http/http.dart' as http;

enum FetchStatus { success, failed, loading }

Future<Pokemon> fetchPokemon(String name) {
  return http
      .get('https://pokeapi.co/api/v2/pokemon/' + name)
      .then((response) => Pokemon.fromJson(json.decode(response.body)));
}

Future<AbilityDetail> fetchAbility(String url) {
  return http
      .get(url)
      .then((response) => AbilityDetail.fromJson(json.decode(response.body)));
}

Future<Species> fetchSpecies(String url) {
  return http
      .get(url)
      .then((response) => Species.fromJson(json.decode(response.body)));
}
