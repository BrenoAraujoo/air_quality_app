import 'package:air_quality_app/feature/models/user_model.dart';

class RacerModel {
  final int? id;
  final UserModel user;
  final double distance;
  final double co2;
  final DateTime? createdAt;

  RacerModel({
    this.id,
    required this.distance,
    required this.user,
    required this.co2,
    this.createdAt,
  });

  factory RacerModel.fromJson(Map<String, dynamic> json) {
    return RacerModel(
      id: json['id'],
      user: UserModel.fromJson(json['user']),
      co2: json['co2'],
      createdAt:
          DateTime.tryParse(json['createdAt'].toString()) ?? DateTime.now(),
      distance: json['distance'],
    );
  }

  factory RacerModel.fromEmpty() {
    return RacerModel(
      id: -1,
      user: UserModel.fromEmpty(),
      co2: -1.0,
      createdAt: DateTime.now(),
      distance: -1.0,
    );
  }

  static Map<String, dynamic> toJson(RacerModel model) {
    return {
      "user": UserModel.toJson(model.user),
      "distance": model.distance,
      "co2": model.co2,
    };
  }

  RacerModel copyWith({
    int? id,
    UserModel? user,
    double? distance,
    double? co2,
    DateTime? createdAt,
  }) {
    return RacerModel(
      id: id ?? this.id,
      user: user ?? this.user,
      distance: distance ?? this.distance,
      co2: co2 ?? this.co2,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
