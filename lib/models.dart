class Pokemon {
  final int id;
  final String name;
  final int height;
  final int weight;
  final Sprites sprite;
  final List<TypePlaceholder> types;
  final List<StatPlaceholder> stats;
  final int baseExperience;
  final List<AbilityPlaceholder> abilities;

  Pokemon(
      {this.id,
      this.name,
      this.height,
      this.weight,
      this.sprite,
      this.types,
      this.stats,
      this.baseExperience,
      this.abilities});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    List<TypePlaceholder> types = List();
    json["types"]
        .forEach((type) => {types.add(TypePlaceholder.fromJson(type))});

    List<StatPlaceholder> stats = List();
    json["stats"]
        .forEach((stat) => {stats.add(StatPlaceholder.fromJson(stat))});

    List<AbilityPlaceholder> abilities = List();
    json["abilities"].forEach(
        (ability) => {abilities.add(AbilityPlaceholder.fromJson(ability))});

    return Pokemon(
        id: json["id"],
        name: json["name"],
        height: json["height"],
        weight: json["weight"],
        sprite: Sprites.fromJson(json["sprites"]),
        types: types,
        stats: stats,
        baseExperience: json["base_experience"],
        abilities: abilities);
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

class StatPlaceholder {
  final int baseStat;
  final int effort;
  final Type stat;

  StatPlaceholder({this.baseStat, this.effort, this.stat});

  factory StatPlaceholder.fromJson(Map<String, dynamic> json) {
    return StatPlaceholder(
        baseStat: json["base_stat"],
        effort: json["effort"],
        stat: Type.fromJson(json["stat"]));
  }
}

class AbilityPlaceholder {
  final Ability ability;
  final bool isHidden;

  AbilityPlaceholder({this.ability, this.isHidden});

  factory AbilityPlaceholder.fromJson(Map<String, dynamic> json) {
    return AbilityPlaceholder(
        ability: Ability.fromJson(json["ability"]),
        isHidden: json["is_hidden"]);
  }
}

class Ability {
  final String name;
  final String url;

  Ability({this.name, this.url});

  factory Ability.fromJson(Map<String, dynamic> json) {
    return Ability(name: json["name"], url: json["url"]);
  }
}

class AbilityDetail {
  final List<EffectEntry> effectEntries;
  final Type generation;

  AbilityDetail({this.effectEntries, this.generation});

  factory AbilityDetail.fromJson(Map<String, dynamic> json) {
    List<EffectEntry> effectEntries = List();
    json["effect_entries"]
        .forEach((entry) => {effectEntries.add(EffectEntry.fromJson(entry))});

    return AbilityDetail(
        effectEntries: effectEntries,
        generation: Type.fromJson(json["generation"]));
  }
}

class EffectEntry {
  final String shortEffect;

  EffectEntry({this.shortEffect});

  factory EffectEntry.fromJson(Map<String, dynamic> json) {
    return EffectEntry(shortEffect: json["short_effect"]);
  }
}

class Species {
  final int captureRate; // out of 255
  final int genderRate; // chance of being female, out of 8, -1 if genderless
  final Type color;
  final List<EggGroup> eggGroups;
  final Type habitat;
  final Type generation;

  Species(
      {this.captureRate,
      this.genderRate,
      this.color,
      this.eggGroups,
      this.habitat,
      this.generation});

  factory Species.fromJson(Map<String, dynamic> json) {
    List<EggGroup> eggGroups = List();
    json["egg_groups"]
        .forEach((eggGroup) => eggGroups.add(EggGroup.fromJson(eggGroup)));

    return Species(
        captureRate: json["capture_rate"],
        genderRate: json["gender_rate"],
        color: Type.fromJson(json["color"]),
        eggGroups: eggGroups,
        habitat: Type.fromJson(json["habitat"]),
        generation: Type.fromJson(json["generation"]));
  }
}

class EggGroup {
  final String name;

  EggGroup({this.name});

  factory EggGroup.fromJson(Map<String, dynamic> json) {
    return EggGroup(name: json["name"]);
  }
}
