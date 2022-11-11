import 'package:air_quality_app/core/packages/contracts/log.dart';
import 'package:air_quality_app/core/packages/geteways/http_connect.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/packages/contracts/http_connect.dart';
import 'core/packages/geteways/logg.dart';
import 'feature/modules/start_race/start_race_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        // BINDS
        Bind.singleton<ILog>((i) => Logg()),
        Bind.singleton<IHttpConnect>((i) => HttpConnect(i<ILog>())),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          Modular.initialRoute,
          module: StartRaceModule(),
        ),
      ];
}
