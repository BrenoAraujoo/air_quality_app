import 'package:air_quality_app/core/format/format_date.dart';
import 'package:air_quality_app/feature/modules/start_race/controller/start_race_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RacerPage extends StatefulWidget {
  const RacerPage({super.key});

  @override
  State<RacerPage> createState() => _RacerPageState();
}

class _RacerPageState extends State<RacerPage> {
  final _controller = Modular.get<StartRaceController>();

  @override
  void initState() {
    super.initState();
    _controller.getAllRacer();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Corridas', style: theme.headline6),
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
        valueListenable: _controller.getRacerLoad,
        builder: (_, bool load, __) {
          return Visibility(
            replacement: _controller.getRaceList.isNotEmpty
                ? ListView.builder(
                    itemCount: _controller.getRaceList.length,
                    itemBuilder: (_, int index) {
                      var racer = _controller.getRaceList[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.only(
                          left: 16.0,
                          top: 5.0,
                          bottom: 5.0,
                          right: 16.0,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Text(
                            racer.user.name[0].toUpperCase(),
                            style: theme.bodyText1?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        title: Text(
                          racer.user.name,
                          style: theme.subtitle1?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'CO2: ',
                                    style: theme.subtitle2?.copyWith(
                                      fontWeight: FontWeight.w900,
                                      color: Colors.grey[400],
                                    ),
                                    children: [
                                      TextSpan(
                                        text: racer.co2.toString(),
                                        style: theme.subtitle2?.copyWith(
                                          color: Colors.grey[400],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                RichText(
                                  text: TextSpan(
                                    text: 'Distância: ',
                                    style: theme.subtitle2?.copyWith(
                                      fontWeight: FontWeight.w900,
                                      color: Colors.grey[400],
                                    ),
                                    children: [
                                      TextSpan(
                                        text: racer.distance.toString(),
                                        style: theme.subtitle2?.copyWith(
                                          color: Colors.grey[400],
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'm',
                                            style: theme.subtitle2?.copyWith(
                                              color: Colors.grey[400],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              FormatDate.getDefaultDate(racer.createdAt!),
                              style: theme.subtitle2?.copyWith(
                                color: Colors.grey[400],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      'Sem registro para exibir',
                      style: theme.headline6,
                    ),
                  ),
            visible: load,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
