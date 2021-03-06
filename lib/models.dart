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
  final Ability species;

  Pokemon(
      {this.id,
      this.name,
      this.height,
      this.weight,
      this.sprite,
      this.types,
      this.stats,
      this.baseExperience,
      this.abilities,
      this.species});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
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
        abilities: abilities,
        species: Ability.fromJson(json["species"]));
  }
}

class Sprites {
  final String main;
  final String female;

  Sprites({this.main, this.female});

  factory Sprites.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Sprites(main: json["front_default"], female: json["front_female"]);
  }
}

class TypePlaceholder {
  final Type type;

  TypePlaceholder({this.type});

  factory TypePlaceholder.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return TypePlaceholder(type: Type.fromJson(json["type"]));
  }
}

class Type {
  final String name;

  Type({this.name});

  factory Type.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Type(name: json["name"]);
  }
}

class StatPlaceholder {
  final int baseStat;
  final int effort;
  final Type stat;

  StatPlaceholder({this.baseStat, this.effort, this.stat});

  factory StatPlaceholder.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
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
    if (json == null) return null;
    return AbilityPlaceholder(
        ability: Ability.fromJson(json["ability"]),
        isHidden: json["is_hidden"]);
  }
}

class Link {
  final String url;

  Link({this.url});

  factory Link.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Link(url: json["url"]);
  }
}

class Ability {
  final String name;
  final String url;

  Ability({this.name, this.url});

  factory Ability.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Ability(name: json["name"], url: json["url"]);
  }
}

class AbilityDetail {
  final List<EffectEntry> effectEntries;
  final Type generation;

  AbilityDetail({this.effectEntries, this.generation});

  factory AbilityDetail.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
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
    if (json == null) return null;
    return EffectEntry(shortEffect: json["short_effect"]);
  }
}

class Species {
  final int captureRate; // out of 255
  final int genderRate; // chance of being female, out of 8, -1 if genderless
  final Type color;
  final Ability evolvesFrom;
  final Link evolutionChain;
  final List<EggGroup> eggGroups;
  final Type habitat;
  final Type generation;

  Species(
      {this.captureRate,
      this.genderRate,
      this.color,
      this.evolvesFrom,
      this.evolutionChain,
      this.eggGroups,
      this.habitat,
      this.generation});

  factory Species.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    List<EggGroup> eggGroups = List();
    json["egg_groups"]
        .forEach((eggGroup) => eggGroups.add(EggGroup.fromJson(eggGroup)));

    return Species(
        captureRate: json["capture_rate"],
        genderRate: json["gender_rate"],
        color: Type.fromJson(json["color"]),
        evolvesFrom: Ability.fromJson(json["evolves_from_species"]),
        evolutionChain: Link.fromJson(json["evolution_chain"]),
        eggGroups: eggGroups,
        habitat: Type.fromJson(json["habitat"]),
        generation: Type.fromJson(json["generation"]));
  }
}

class EggGroup {
  final String name;

  EggGroup({this.name});

  factory EggGroup.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return EggGroup(name: json["name"]);
  }
}

class EvolutionChain {
  final Chain chain;

  EvolutionChain({this.chain});

  factory EvolutionChain.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return EvolutionChain(chain: Chain.fromJson(json["chain"]));
  }
}

class Chain {
  final Type species;
  final bool isBaby;
  final EvolutionDetail details;
  final List<Chain> evolvesTo;

  Chain({this.species, this.isBaby, this.details, this.evolvesTo});

  factory Chain.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    List<EvolutionDetail> details = List();
    json["evolution_details"]
        .forEach((detail) => details.add(EvolutionDetail.fromJson(detail)));
    EvolutionDetail detail = details.length > 0 ? details[0] : null;
    List<Chain> evolvesTo = List();
    json["evolves_to"].forEach((chain) => evolvesTo.add(Chain.fromJson(chain)));

    return Chain(
        species: Type.fromJson(json["species"]),
        isBaby: json["is_baby"],
        details: detail,
        evolvesTo: evolvesTo);
  }
}

class EvolutionDetail {
  final Type trigger;
  final Type item;
  final int minLevel;
  final int minHappiness;
  final int minBeauty;
  final int minAffection;
  final Type heldItem;
  final int gender;
  final String timeOfDay;
  final Type location;

  EvolutionDetail(
      {this.trigger,
      this.item,
      this.minLevel,
      this.minHappiness,
      this.minBeauty,
      this.minAffection,
      this.heldItem,
      this.gender,
      this.timeOfDay,
      this.location});

  factory EvolutionDetail.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return EvolutionDetail(
        trigger: Type.fromJson(json["trigger"]),
        item: Type.fromJson(json["item"]),
        minLevel: json["min_level"],
        minHappiness: json["min_happiness"],
        minBeauty: json["min_beauty"],
        minAffection: json["min_affection"],
        heldItem: Type.fromJson(json["held_item"]),
        gender: json["gender"],
        timeOfDay: json["time_of_day"],
        location: Type.fromJson(json["location"]));
  }
}

class FavePoke {
  final int id;
  final String name;
  final String sprite;

  FavePoke({this.id, this.name, this.sprite});

  factory FavePoke.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return FavePoke(id: json["id"], name: json["name"], sprite: json["sprite"]);
  }
}
