class Country {
  final String name;
  final String flag;
  final int population;

  Country({required this.name, required this.flag, required this.population});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'],
      flag: json['flag'],
      population: json['population'],
    );
  }
}
