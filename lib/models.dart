class Pokemon {
  final int id;
  final String name;
  final int height;
  final Sprites sprite;
  final List<TypePlaceholder> types;

  Pokemon({this.id, this.name, this.height, this.sprite, this.types});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    var typeJsons = json["types"];
    List<TypePlaceholder> types = List();
    typeJsons.forEach((type) => {types.add(TypePlaceholder.fromJson(type))});

    return Pokemon(
        id: json["id"],
        name: json["name"],
        height: json["height"],
        sprite: Sprites.fromJson(json["sprites"]),
        types: types);
  }
}

class Sprites {
  final String main;
  final String female;

  Sprites({this.main, this.female});

  factory Sprites.fromJson(Map<String, dynamic> json) {
    return Sprites(main: json["front_default"], female: json["front_female"]);
  }
}

class TypePlaceholder {
  final Type type;

  TypePlaceholder({this.type});

  factory TypePlaceholder.fromJson(Map<String, dynamic> json) {
    return TypePlaceholder(type: Type.fromJson(json["type"]));
  }
}

class Type {
  final String name;

  Type({this.name});

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(name: json["name"]);
  }
}
