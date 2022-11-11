import 'package:air_quality_app/feature/models/localization_model.dart';
import 'package:air_quality_app/feature/models/race_model.dart';
import 'package:air_quality_app/feature/models/user_model.dart';
import 'package:air_quality_app/feature/repositories/races_repositories.dart';
import 'package:air_quality_app/feature/repositories/waqi_repository.dart';
import 'package:flutter/material.dart';

class StartRaceController {
  final RacesRepositories _repositoryRacer;
  final WaqiRepository _repositoryWaqi;

  StartRaceController({
    required RacesRepositories repositoryRacer,
    required WaqiRepository repositoryWaqi,
  })  : _repositoryRacer = repositoryRacer,
        _repositoryWaqi = repositoryWaqi;

  final ValueNotifier<bool> _startRacerLoad = ValueNotifier(false);
  final ValueNotifier<bool> _racerLoad = ValueNotifier(false);
  final ValueNotifier<bool> _waqiLoad = ValueNotifier(false);

  final ValueNotifier<UserModel> _selectedUser = ValueNotifier(
    UserModel(id: 0, name: ""),
  );

  final ValueNotifier<LocalizationModel> _selectedLocalization = ValueNotifier(
    LocalizationModel.fromEmpty(),
  );

  List<RacerModel> _raceList = [];

  late RacerModel _getDataRacer;

  String _localization = "";
  String _climatization = "";
  Color _climatizationColor = Colors.brown;

  ValueNotifier<bool> get getStartRacerLoad => _startRacerLoad;
  ValueNotifier<bool> get getRacerLoad => _racerLoad;
  ValueNotifier<bool> get getWaqiLoad => _waqiLoad;

  RacerModel get getDataRacer => _getDataRacer;

  String get getLocalization => _localization;

  String get getClimatization => _climatization;

  Color get getClimatizationColor => _climatizationColor;

  List<RacerModel> get getRaceList => _raceList;

  set setSelectedUser(UserModel newUser) {
    _selectedUser.value = newUser;
  }

  ValueNotifier<UserModel> get getSelectedUser => _selectedUser;

  set setSelectedLocalization(LocalizationModel newLocalization) {
    _selectedLocalization.value = newLocalization;
  }

  ValueNotifier<LocalizationModel> get getSelectedLocalization =>
      _selectedLocalization;

  Future<void> getAllRacer() async {
    _racerLoad.value = true;

    final result = await _repositoryRacer.get();

    if (result.isLeft) {
      _racerLoad.value = false;
      return;
    }

    _racerLoad.value = false;

    _raceList = result.right;
  }

  Future<void> send(int distance) async {
    _startRacerLoad.value = true;

    double co2 = distance * 0.3263;

    var model = RacerModel(
      distance: double.parse(distance.toString()),
      user: getSelectedUser.value,
      co2: co2,
    );

    final result = await _repositoryRacer.send(model);

    if (result.isLeft) {
      _startRacerLoad.value = false;
      return;
    }

    _getDataRacer = result.right;

    _startRacerLoad.value = false;
  }

  Future<void> findWaqi() async {
    _waqiLoad.value = true;

    String longitude = _selectedLocalization.value.longitude.isEmpty
        ? '46.6970097631965'
        : _selectedLocalization.value.longitude;

    String latitude = _selectedLocalization.value.latitude.isEmpty
        ? '23.632840328628994'
        : _selectedLocalization.value.latitude;

    final result = await _repositoryWaqi.get(
      longitude: longitude,
      latitude: latitude,
    );

    if (result.isLeft) {
      _waqiLoad.value = false;
      return;
    }

    _localization = result.right.data.city.name;
    _climatization = checkClimatization(result.right.data.aqi);
    _climatizationColor = changeClimatizationColor(result.right.data.aqi);

    _waqiLoad.value = false;
  }

  String checkClimatization(int index) {
    if (index > 0 && index <= 50) return 'Bom.';
    if (index > 50 && index <= 100) return 'Moderado.';
    if (index > 100 && index <= 150) {
      return 'Não saudável para grupos sensíveis.';
    }
    if (index > 150 && index <= 200) {
      return 'Não saudável.';
    }
    if (index > 200 && index <= 300) {
      return 'Muito arriscado.';
    }

    return 'Perigosa.';
  }

  Color changeClimatizationColor(int index) {
    if (index > 0 && index <= 50) return Colors.green;
    if (index > 50 && index <= 100) return Colors.yellow;
    if (index > 100 && index <= 150) {
      return Colors.orange;
    }
    if (index > 150 && index <= 200) {
      return Colors.red;
    }
    if (index > 200 && index <= 300) {
      return Colors.purple;
    }

    return Colors.brown;
  }
}
