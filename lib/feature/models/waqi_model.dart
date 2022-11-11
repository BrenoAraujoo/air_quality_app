class WaqiModel {
  final DataModel data;
  WaqiModel(this.data);

  factory WaqiModel.fromJson(Map<String, dynamic> json) => WaqiModel(
        DataModel.fromJson(
          json["data"],
        ),
      );
}

class DataModel {
  final int aqi;
  final CityModel city;

  DataModel({
    required this.aqi,
    required this.city,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        aqi: json["aqi"],
        city: CityModel.fromJson(json["city"]),
      );
}

class CityModel {
  final String name;

  CityModel(this.name);

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        json["name"],
      );
}
