import 'package:air_quality_app/feature/modules/start_race/bind/start_race_bind.dart';
import 'package:air_quality_app/feature/modules/start_race/racer_page.dart';
import 'package:air_quality_app/feature/modules/start_race/start_race_page.dart';
import 'package:air_quality_app/feature/routes/app_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'waqi_page.dart';

class StartRaceModule extends Module {
  @override
  List<Module> get imports => [
        StartRaceBind(),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => const StartRacePage(),
        ),
        ChildRoute(
          AppRoutes.RACER,
          child: (context, args) => const RacerPage(),
        ),
        ChildRoute(
          AppRoutes.WAQI,
          child: (context, args) => const WaqiPage(),
        ),
      ];
}
