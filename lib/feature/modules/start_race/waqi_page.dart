import 'package:air_quality_app/feature/modules/start_race/controller/start_race_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'widgets/expasion_localization_list_widget.dart';

class WaqiPage extends StatefulWidget {
  const WaqiPage({super.key});

  @override
  State<WaqiPage> createState() => _WaqiPageState();
}

class _WaqiPageState extends State<WaqiPage> {
  final _controller = Modular.get<StartRaceController>();

  @override
  void initState() {
    super.initState();
    _controller.findWaqi();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Climatização', style: theme.headline6),
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Modular.to.navigate(Modular.initialRoute);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: _controller.getWaqiLoad,
        builder: (context, bool load, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const ExpasionLocalizationListWidget(),
                const Spacer(),
                Visibility(
                  replacement: const Center(child: CircularProgressIndicator()),
                  visible: !load,
                  child: Column(
                    children: [
                      Text(
                        _controller.getLocalization,
                        textAlign: TextAlign.center,
                        style: theme.headline6?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _controller.getClimatization,
                        textAlign: TextAlign.center,
                        style: theme.headline6?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: _controller.getClimatizationColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          );
        },
      ),
    );
  }
}
