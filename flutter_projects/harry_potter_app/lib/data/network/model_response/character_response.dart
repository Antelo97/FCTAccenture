import 'dart:convert';

List<CharacterResponse> characterResponseFromJson(String str) =>
    List<CharacterResponse>.from(
        json.decode(str).map((x) => CharacterResponse.fromJson(x)));

String characterResponseToJson(List<CharacterResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CharacterResponse {
  String idApi;
  String name;
  Species species;
  Gender gender;
  House house;
  int? yearOfBirth;
  bool isWizard;
  Ancestry ancestry;
  Wand wand;
  Patronus patronus;
  bool isHogwartsStudent;
  bool isHogwartsStaff;
  String actor;
  bool isAlive;
  String imageUrl;

  CharacterResponse({
    required this.idApi,
    required this.name,
    required this.species,
    required this.gender,
    required this.house,
    this.yearOfBirth,
    required this.isWizard,
    required this.ancestry,
    required this.wand,
    required this.patronus,
    required this.isHogwartsStudent,
    required this.isHogwartsStaff,
    required this.actor,
    required this.isAlive,
    required this.imageUrl,
  });

  factory CharacterResponse.fromJson(Map<String, dynamic> json) =>
      CharacterResponse(
        idApi: json["id"],
        name: json["name"],
        species: speciesValues.map[json["species"]]!,
        gender: genderValues.map[json["gender"]]!,
        house: houseValues.map[json["house"]]!,
        yearOfBirth: json["yearOfBirth"],
        isWizard: json["wizard"],
        ancestry: ancestryValues.map[json["ancestry"]]!,
        wand: Wand.fromJson(json["wand"]),
        patronus: patronusValues.map[json["patronus"]]!,
        isHogwartsStudent: json["hogwartsStudent"],
        isHogwartsStaff: json["hogwartsStaff"],
        actor: json["actor"],
        isAlive: json["alive"],
        imageUrl: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": idApi,
        "name": name,
        "species": speciesValues.reverse[species],
        "gender": genderValues.reverse[gender],
        "house": houseValues.reverse[house],
        "yearOfBirth": yearOfBirth,
        "wizard": isWizard,
        "ancestry": ancestryValues.reverse[ancestry],
        "wand": wand.toJson(),
        "patronus": patronusValues.reverse[patronus],
        "hogwartsStudent": isHogwartsStudent,
        "hogwartsStaff": isHogwartsStaff,
        "actor": actor,
        "alive": isAlive,
        "image": imageUrl,
      };
}

enum Ancestry {
  HALF_BLOOD,
  MUGGLEBORN,
  PURE_BLOOD,
  EMPTY,
  SQUIB,
  MUGGLE,
  HALF_VEELA,
  QUARTER_VEELA
}

final ancestryValues = EnumValues({
  "": Ancestry.EMPTY,
  "half-blood": Ancestry.HALF_BLOOD,
  "half-veela": Ancestry.HALF_VEELA,
  "muggle": Ancestry.MUGGLE,
  "muggleborn": Ancestry.MUGGLEBORN,
  "pure-blood": Ancestry.PURE_BLOOD,
  "quarter-veela": Ancestry.QUARTER_VEELA,
  "squib": Ancestry.SQUIB
});

enum EyeColour {
  GREEN,
  BROWN,
  BLUE,
  GREY,
  EMPTY,
  BLACK,
  RED,
  YELLOW,
  HAZEL,
  PALE_SILVERY,
  AMBER,
  ORANGE,
  WHITE,
  DARK,
  YELLOWISH
}

final eyeColourValues = EnumValues({
  "amber": EyeColour.AMBER,
  "black": EyeColour.BLACK,
  "blue": EyeColour.BLUE,
  "brown": EyeColour.BROWN,
  "dark": EyeColour.DARK,
  "": EyeColour.EMPTY,
  "green": EyeColour.GREEN,
  "grey": EyeColour.GREY,
  "hazel": EyeColour.HAZEL,
  "orange": EyeColour.ORANGE,
  "pale, silvery": EyeColour.PALE_SILVERY,
  "red": EyeColour.RED,
  "white": EyeColour.WHITE,
  "yellow": EyeColour.YELLOW,
  "yellowish": EyeColour.YELLOWISH
});

enum Gender { MALE, FEMALE }

final genderValues = EnumValues({"female": Gender.FEMALE, "male": Gender.MALE});

enum HairColour {
  BLACK,
  BROWN,
  RED,
  BLONDE,
  BALD,
  GREY,
  EMPTY,
  BLOND,
  SILVER,
  SANDY,
  WHITE,
  GINGER,
  DARK,
  TAWNY,
  DULL
}

final hairColourValues = EnumValues({
  "bald": HairColour.BALD,
  "black": HairColour.BLACK,
  "blond": HairColour.BLOND,
  "blonde": HairColour.BLONDE,
  "brown": HairColour.BROWN,
  "dark": HairColour.DARK,
  "dull": HairColour.DULL,
  "": HairColour.EMPTY,
  "ginger": HairColour.GINGER,
  "grey": HairColour.GREY,
  "red": HairColour.RED,
  "sandy": HairColour.SANDY,
  "silver": HairColour.SILVER,
  "tawny": HairColour.TAWNY,
  "white": HairColour.WHITE
});

enum House { GRYFFINDOR, SLYTHERIN, HUFFLEPUFF, RAVENCLAW, EMPTY }

final houseValues = EnumValues({
  "": House.EMPTY,
  "Gryffindor": House.GRYFFINDOR,
  "Hufflepuff": House.HUFFLEPUFF,
  "Ravenclaw": House.RAVENCLAW,
  "Slytherin": House.SLYTHERIN
});

enum Patronus {
  STAG,
  OTTER,
  JACK_RUSSELL_TERRIER,
  EMPTY,
  TABBY_CAT,
  SWAN,
  DOE,
  NON_CORPOREAL,
  HARE,
  HORSE,
  WOLF,
  WEASEL,
  LYNX,
  PERSIAN_CAT,
  BOAR,
  GOAT
}

final patronusValues = EnumValues({
  "boar": Patronus.BOAR,
  "doe": Patronus.DOE,
  "": Patronus.EMPTY,
  "goat": Patronus.GOAT,
  "hare": Patronus.HARE,
  "horse": Patronus.HORSE,
  "Jack Russell terrier": Patronus.JACK_RUSSELL_TERRIER,
  "lynx": Patronus.LYNX,
  "Non-Corporeal": Patronus.NON_CORPOREAL,
  "otter": Patronus.OTTER,
  "persian cat": Patronus.PERSIAN_CAT,
  "stag": Patronus.STAG,
  "swan": Patronus.SWAN,
  "tabby cat": Patronus.TABBY_CAT,
  "weasel": Patronus.WEASEL,
  "wolf": Patronus.WOLF
});

enum Species {
  HUMAN,
  HALF_GIANT,
  WEREWOLF,
  CAT,
  GOBLIN,
  OWL,
  GHOST,
  POLTERGEIST,
  THREE_HEADED_DOG,
  DRAGON,
  CENTAUR,
  HOUSE_ELF,
  ACROMANTULA,
  HIPPOGRIFF,
  GIANT,
  VAMPIRE,
  HALF_HUMAN
}

final speciesValues = EnumValues({
  "acromantula": Species.ACROMANTULA,
  "cat": Species.CAT,
  "centaur": Species.CENTAUR,
  "dragon": Species.DRAGON,
  "ghost": Species.GHOST,
  "giant": Species.GIANT,
  "goblin": Species.GOBLIN,
  "half-giant": Species.HALF_GIANT,
  "half-human": Species.HALF_HUMAN,
  "hippogriff": Species.HIPPOGRIFF,
  "house-elf": Species.HOUSE_ELF,
  "human": Species.HUMAN,
  "owl": Species.OWL,
  "poltergeist": Species.POLTERGEIST,
  "three-headed dog": Species.THREE_HEADED_DOG,
  "vampire": Species.VAMPIRE,
  "werewolf": Species.WEREWOLF
});

class Wand {
  Wood wood;
  Core core;
  double? length;

  Wand({
    required this.wood,
    required this.core,
    this.length,
  });

  factory Wand.fromJson(Map<String, dynamic> json) => Wand(
        wood: woodValues.map[json["wood"]]!,
        core: coreValues.map[json["core"]]!,
        length: json["length"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "wood": woodValues.reverse[wood],
        "core": coreValues.reverse[core],
        "length": length,
      };
}

enum Core {
  PHOENIX_FEATHER,
  DRAGON_HEARTSTRING,
  UNICORN_TAIL_HAIR,
  UNICORN_HAIR,
  EMPTY
}

final coreValues = EnumValues({
  "dragon heartstring": Core.DRAGON_HEARTSTRING,
  "": Core.EMPTY,
  "phoenix feather": Core.PHOENIX_FEATHER,
  "unicorn hair": Core.UNICORN_HAIR,
  "unicorn tail-hair": Core.UNICORN_TAIL_HAIR
});

enum Wood {
  HOLLY,
  VINE,
  WILLOW,
  HAWTHORN,
  FIR,
  ASH,
  EMPTY,
  OAK,
  CHERRY,
  YEW,
  CYPRESS,
  WALNUT,
  CEDAR,
  BIRCH,
  ELM,
  MAHOGANY,
  LARCH,
  CHESTNUT,
  HORNBEAM
}

final woodValues = EnumValues({
  "ash": Wood.ASH,
  "birch": Wood.BIRCH,
  "cedar": Wood.CEDAR,
  "cherry": Wood.CHERRY,
  "chestnut": Wood.CHESTNUT,
  "cypress": Wood.CYPRESS,
  "elm": Wood.ELM,
  "": Wood.EMPTY,
  "fir": Wood.FIR,
  "hawthorn": Wood.HAWTHORN,
  "holly": Wood.HOLLY,
  "hornbeam": Wood.HORNBEAM,
  "larch": Wood.LARCH,
  "mahogany": Wood.MAHOGANY,
  "oak": Wood.OAK,
  "vine": Wood.VINE,
  "walnut": Wood.WALNUT,
  "willow": Wood.WILLOW,
  "yew": Wood.YEW
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
