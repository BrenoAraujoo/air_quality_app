import 'package:air_quality_app/feature/models/localization_model.dart';
import 'package:air_quality_app/feature/modules/start_race/controller/start_race_controller.dart';
import 'package:air_quality_app/feature/modules/start_race/utils/generate_localization_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ExpasionLocalizationListWidget extends StatefulWidget {
  const ExpasionLocalizationListWidget({super.key});

  @override
  State<ExpasionLocalizationListWidget> createState() =>
      _ExpasionLocalizationListWidgetState();
}

class _ExpasionLocalizationListWidgetState
    extends State<ExpasionLocalizationListWidget> {
  final _controller = Modular.get<StartRaceController>();

  @override
  void initState() {
    super.initState();
    _controller.setSelectedLocalization = generateLocalizationList().first;
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;

    return ValueListenableBuilder<LocalizationModel>(
      valueListenable: _controller.getSelectedLocalization,
      builder: (_, selectedLocalization, __) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(
              Radius.circular(4.0),
            ),
          ),
          child: ExpansionTile(
            iconColor: Colors.white,
            collapsedIconColor: Colors.white,
            collapsedTextColor: Colors.white,
            textColor: Colors.white,
            title: Text(selectedLocalization.city),
            children: [
              Container(
                padding: const EdgeInsets.only(top: 6.0),
                color: Colors.white,
                child: Container(
                  width: maxWidth,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(6.0),
                    ),
                    border: Border.all(
                      color: Colors.blue,
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: generateLocalizationList().map((localization) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 16.0,
                          left: 8.0,
                          right: 8.0,
                          bottom: 16.0,
                        ),
                        child: InkWell(
                          onTap: () {
                            _controller.setSelectedLocalization = localization;
                            _controller.findWaqi();
                          },
                          child: Text(localization.city),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
