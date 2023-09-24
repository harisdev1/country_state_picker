class CountryModel {
  final String country;
  final List<String> states;

  CountryModel({
    required this.country,
    required this.states,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      country: json['country'],
      states: List<String>.from(json['states']),
    );
  }
}
