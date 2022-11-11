import 'package:air_quality_app/core/packages/contracts/http_connect.dart';
import 'package:air_quality_app/feature/datas/air_quality_data.dart';
import 'package:air_quality_app/feature/datas/waqi_data.dart';
import 'package:air_quality_app/feature/modules/start_race/controller/start_race_controller.dart';
import 'package:air_quality_app/feature/repositories/races_repositories.dart';
import 'package:air_quality_app/feature/repositories/waqi_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class StartRaceBind extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory<AirQualityData>(
          (i) => AirQualityData(i<IHttpConnect>()),
          export: true,
        ),
        Bind.factory<WaqiData>(
          (i) => WaqiData(i<IHttpConnect>()),
          export: true,
        ),

        Bind.factory<RacesRepositories>(
          (i) => RacesRepositories(
            i<AirQualityData>(),
          ),
          export: true,
        ),

        Bind.factory<WaqiRepository>(
          (i) => WaqiRepository(
            i<WaqiData>(),
          ),
          export: true,
        ),

        // controller
        Bind.singleton<StartRaceController>(
          (i) => StartRaceController(
            repositoryRacer: i<RacesRepositories>(),
            repositoryWaqi: i<WaqiRepository>(),
          ),
          export: true,
        ),
      ];
}
