class UserModel {
  final int id;
  final String name;

  UserModel({required this.id, required this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
    );
  }

  factory UserModel.fromEmpty() {
    return UserModel(
      id: -1,
      name: "",
    );
  }

  static Map<String, dynamic> toJson(UserModel model) {
    return {"id": model.id};
  }
}
