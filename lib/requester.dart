import 'package:http/http.dart' as http;

Future<http.Response> fetchPokemon(String name) {
  return http.get('https://pokeapi.co/api/v2/pokemon/' + name);
}
