class Planets {
  Planets({
    required this.name,
    required this.rotationPeriod,
    required this.orbitalPeriod,
    required this.diameter,
    required this.climate,
    required this.gravity,
    required this.terrain,
    required this.surfaceWater,
    required this.population,
    required this.residents,
    required this.films,
    required this.created,
    required this.edited,
    required this.url,
  });

  final String? name;
  final String? rotationPeriod;
  final String? orbitalPeriod;
  final String? diameter;
  final String? climate;
  final String? gravity;
  final String? terrain;
  final String? surfaceWater;
  final String? population;
  final List<String> residents;
  final List<String> films;
  final DateTime? created;
  final DateTime? edited;
  final String? url;

  factory Planets.fromJson(Map<String, dynamic> json) {
    return Planets(
      name: json["name"],
      rotationPeriod: json["rotation_period"],
      orbitalPeriod: json["orbital_period"],
      diameter: json["diameter"],
      climate: json["climate"],
      gravity: json["gravity"],
      terrain: json["terrain"],
      surfaceWater: json["surface_water"],
      population: json["population"],
      residents: json["residents"] == null
          ? []
          : List<String>.from(json["residents"]!.map((x) => x)),
      films: json["films"] == null
          ? []
          : List<String>.from(json["films"]!.map((x) => x)),
      created: DateTime.tryParse(json["created"] ?? ""),
      edited: DateTime.tryParse(json["edited"] ?? ""),
      url: json["url"],
    );
  }
}
