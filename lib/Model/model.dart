class Data {
  final String name;
  final String officialName;
  final String capital;
  final String region;
  final int population;
  final String flag;

  Data({
    required this.name,
    required this.officialName,
    required this.capital,
    required this.region,
    required this.population,
    required this.flag,
  });

  // Factory constructor to create a Data instance from JSON
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      name: json['name']['common'] ?? '',
      officialName: json['name']['official'] ?? '',
      capital: (json['capital'] as List?)?.first ?? 'N/A',
      region: json['region'] ?? '',
      population: json['population'] ?? 0,
      flag: json['flags']['png'] ?? '',
    );
  }
}
