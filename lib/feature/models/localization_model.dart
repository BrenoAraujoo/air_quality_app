class LocalizationModel {
  final String city;
  final String longitude;
  final String latitude;

  LocalizationModel({
    required this.city,
    required this.longitude,
    required this.latitude,
  });

  factory LocalizationModel.fromEmpty() {
    return LocalizationModel(
      city: '',
      latitude: '',
      longitude: '',
    );
  }
}
