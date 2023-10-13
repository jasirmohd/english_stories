import 'dart:convert';

class StoryCategoryModel {
  final String? word;
  final String? phonetic;
  final List<Phonetic>? phonetics;
  final String? origin;
  final List<Meaning>? meanings;

  StoryCategoryModel({
    this.word,
    this.phonetic,
    this.phonetics,
    this.origin,
    this.meanings,
  });

  factory StoryCategoryModel.fromJson(String str) => StoryCategoryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StoryCategoryModel.fromMap(Map<String, dynamic> json) => StoryCategoryModel(
    word: json["word"] ?? '',
    phonetic: json["phonetic"] ?? '',
    phonetics: json["phonetics"] != null ? List<Phonetic>.from(json["phonetics"].map((x) => Phonetic.fromMap(x))) : [],
    origin: json["origin"] ?? '',
    meanings: json["meanings"] != null ? List<Meaning>.from(json["meanings"].map((x) => Meaning.fromMap(x))) : [],
  );

  Map<String, dynamic> toMap() => {
    "word": word,
    "phonetic": phonetic,
    "phonetics": List<dynamic>.from(phonetics!.map((x) => x.toMap())),
    "origin": origin,
    "meanings": List<dynamic>.from(meanings!.map((x) => x.toMap())),
  };
}

class Meaning {
  final String? partOfSpeech;
  final List<Definition>? definitions;

  Meaning({
    this.partOfSpeech,
    this.definitions,
  });

  factory Meaning.fromJson(String str) => Meaning.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Meaning.fromMap(Map<String, dynamic> json) => Meaning(
    partOfSpeech: json["partOfSpeech"] ?? '',
    definitions: json["definitions"] != null ? List<Definition>.from(json["definitions"].map((x) => Definition.fromMap(x))) : [],
  );

  Map<String, dynamic> toMap() => {
    "partOfSpeech": partOfSpeech,
    "definitions": List<dynamic>.from(definitions!.map((x) => x.toMap())),
  };
}

class Definition {
  final String? definition;
  final String? example;
  final List<dynamic>? synonyms;
  final List<dynamic>? antonyms;

  Definition({
    this.definition,
    this.example,
    this.synonyms,
    this.antonyms,
  });

  factory Definition.fromJson(String str) => Definition.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Definition.fromMap(Map<String, dynamic> json) => Definition(
    definition: json["definition"] ?? '',
    example: json["example"] ?? '',
    synonyms: json["synonyms"] != null ? List<dynamic>.from(json["synonyms"].map((x) => x)) : [],
    antonyms: json["antonyms"] != null ? List<dynamic>.from(json["antonyms"].map((x) => x)) : [],
  );

  Map<String, dynamic> toMap() => {
    "definition": definition,
    "example": example,
    "synonyms": List<dynamic>.from(synonyms!.map((x) => x)),
    "antonyms": List<dynamic>.from(antonyms!.map((x) => x)),
  };
}

class Phonetic {
  final String? text;
  final String? audio;

  Phonetic({
    this.text,
    this.audio,
  });

  factory Phonetic.fromJson(String str) => Phonetic.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Phonetic.fromMap(Map<String, dynamic> json) => Phonetic(
    text: json["text"] ?? '',
    audio: json["audio"] ?? '',
  );

  Map<String, dynamic> toMap() => {
    "text": text,
    "audio": audio,
  };
}
