import 'package:air_quality_app/core/format/format_date.dart';
import 'package:air_quality_app/feature/modules/start_race/controller/start_race_controller.dart';
import 'package:air_quality_app/feature/routes/app_routes.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'widgets/expasion_user_list_widget.dart';
import 'package:flutter/material.dart';

class StartRacePage extends StatefulWidget {
  const StartRacePage({super.key});

  @override
  State<StartRacePage> createState() => _StartRacePageState();
}

class _StartRacePageState extends State<StartRacePage> {
  final _controller = Modular.get<StartRaceController>();
  final ValueNotifier<bool> _isRunning = ValueNotifier(false);
  late StopWatchTimer _stopWatchTimer;

  @override
  void initState() {
    super.initState();
    _stopWatchTimer = StopWatchTimer();
  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;
    TextTheme theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Air Quality', style: theme.headline6),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {
              Modular.to.navigate(AppRoutes.RACER);
            },
            icon: const Icon(
              Icons.list,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              Modular.to.navigate(AppRoutes.WAQI);
            },
            icon: const Icon(
              Icons.location_on_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: StreamBuilder<int>(
        stream: _stopWatchTimer.rawTime,
        initialData: 0,
        builder: (context, snap) {
          final value = snap.data ?? 0;
          final displayTime = StopWatchTimer.getDisplayTime(
            value,
            hours: false,
            minute: false,
            second: true,
            milliSecond: false,
          );

          return ValueListenableBuilder<bool>(
            valueListenable: _controller.getStartRacerLoad,
            builder: (_, bool load, __) {
              return Visibility(
                visible: !load,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: SizedBox(
                  height: maxHeight,
                  width: maxWidth,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const ExpasionUserListWidget(),
                        const SizedBox(height: 50),
                        Text('Iniciar corrida', style: theme.headline5),
                        const SizedBox(height: 20),
                        Stack(
                          children: <Widget>[
                            Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.blueAccent,
                                  width: 10.0,
                                ),
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                            ),
                            Positioned.fill(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              top: 70,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                width: 200,
                                height: 200,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      displayTime,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: theme.headline2?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'm',
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: theme.caption?.copyWith(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        ValueListenableBuilder(
                          valueListenable: _isRunning,
                          builder: (_, bool running, __) {
                            return Visibility(
                              replacement: TextButton(
                                onPressed: startTimer,
                                child: Text(
                                  'INICIAR',
                                  style: theme.headline6?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              visible: running,
                              child: TextButton(
                                onPressed: stopTimer,
                                child: Text(
                                  'PARAR',
                                  style: theme.headline6?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        Visibility(
                          replacement: const Offstage(),
                          visible: value > 0,
                          child: TextButton(
                            onPressed: resetTimer,
                            child: Text(
                              'REINICIAR',
                              style: theme.headline6?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          replacement: const Offstage(),
                          visible: value > 0,
                          child: TextButton(
                            onPressed: () => finishTimer(
                              context: context,
                              distance: int.parse(displayTime),
                            ),
                            child: Text(
                              'FINALIZAR',
                              style: theme.headline6?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void startTimer() {
    _stopWatchTimer.onStartTimer();
    _isRunning.value = _stopWatchTimer.isRunning;
  }

  void stopTimer() {
    _stopWatchTimer.onStopTimer();
    _isRunning.value = _stopWatchTimer.isRunning;
  }

  void resetTimer() {
    _stopWatchTimer.onResetTimer();
    _isRunning.value = _stopWatchTimer.isRunning;
  }

  void finishTimer({
    required BuildContext context,
    required int distance,
  }) async {
    _stopWatchTimer.onResetTimer();
    _isRunning.value = _stopWatchTimer.isRunning;
    _controller.send(distance).then((_) {
      return _showAlertDialog(context);
    });
  }

  void _showAlertDialog(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Enviado com sucesso!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('OK'),
            ),
          ],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _showContentBody(
                theme: theme,
                title: 'Nome: ',
                description: _controller.getDataRacer.user.name,
              ),
              const SizedBox(height: 5.0),
              _showContentBody(
                theme: theme,
                title: 'Co2: ',
                description: _controller.getDataRacer.co2.toString(),
              ),
              const SizedBox(height: 5.0),
              _showContentBody(
                theme: theme,
                title: 'Distância: ',
                description: _controller.getDataRacer.distance.toString(),
              ),
              const SizedBox(height: 5.0),
              _showContentBody(
                theme: theme,
                title: 'Registrado em: ',
                description: FormatDate.getDefaultDate(
                  _controller.getDataRacer.createdAt!,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Row _showContentBody({
    required TextTheme theme,
    required String title,
    required String description,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: theme.caption?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 15.0),
        Text(
          description,
          style: theme.caption,
        ),
      ],
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }
}
