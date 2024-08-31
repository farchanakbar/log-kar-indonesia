class Movie {
  Movie({
    required this.title,
    required this.episodeId,
    required this.openingCrawl,
    required this.director,
    required this.producer,
    required this.releaseDate,
    required this.characters,
    required this.planets,
    required this.starships,
    required this.vehicles,
    required this.species,
    required this.created,
    required this.edited,
    required this.url,
  });

  final String? title;
  final int? episodeId;
  final String? openingCrawl;
  final String? director;
  final String? producer;
  final DateTime? releaseDate;
  final List<String> characters;
  final List<String> planets;
  final List<String> starships;
  final List<String> vehicles;
  final List<String> species;
  final DateTime? created;
  final DateTime? edited;
  final String? url;

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json["title"],
      episodeId: json["episode_id"],
      openingCrawl: json["opening_crawl"],
      director: json["director"],
      producer: json["producer"],
      releaseDate: DateTime.tryParse(json["release_date"] ?? ""),
      characters: json["characters"] == null
          ? []
          : List<String>.from(json["characters"]!.map((x) => x)),
      planets: json["planets"] == null
          ? []
          : List<String>.from(json["planets"]!.map((x) => x)),
      starships: json["starships"] == null
          ? []
          : List<String>.from(json["starships"]!.map((x) => x)),
      vehicles: json["vehicles"] == null
          ? []
          : List<String>.from(json["vehicles"]!.map((x) => x)),
      species: json["species"] == null
          ? []
          : List<String>.from(json["species"]!.map((x) => x)),
      created: DateTime.tryParse(json["created"] ?? ""),
      edited: DateTime.tryParse(json["edited"] ?? ""),
      url: json["url"],
    );
  }
}
