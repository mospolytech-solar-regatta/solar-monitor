import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_monitor/store/connectorAPI.dart';
import 'package:solar_monitor/settings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_monitor/showSettings.dart';
import 'models/telemetry.dart';
import 'telemetryWidget.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1024, 600),
    center: true,
    backgroundColor: Color(0xFF20242D),
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.setFullScreen(true);
    await windowManager.focus();
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TelemetryModel()),
        ],
        child: ScreenUtilInit(
            designSize: const Size(1024, 600),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'First Method',
                // You can use the library anywhere in the app even in theme
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  textTheme:
                      Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
                ),
                home: child,
              );
            },
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: const MyHomePage(),
            )));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF20242D),
      appBar: AppBar(
          // actions: <Widget>[
          //   Padding(
          //       padding: const EdgeInsets.only(right: 20.0),
          //       child: GestureDetector(
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => const ShowSettingsWidget()),
          //           );
          //         },
          //         child: const Icon(
          //           Icons.settings,
          //           size: 26.0,
          //         ),
          //       )),
          // ],
          ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: TelemetryWidget('Мотор', [
                    TelemetryProperty(Icons.thermostat, 'motor_temp'),
                    TelemetryProperty(
                        Icons.settings_backup_restore, 'motor_revols')
                  ]),
                ),
                Expanded(
                  child: TelemetryWidget('MPPT', [
                    TelemetryProperty(Icons.bolt, 'MPPT_volts'),
                    TelemetryProperty(Icons.power, 'MPPT_volts'),
                    TelemetryProperty(Icons.battery_std, 'time_to_go')
                  ]),
                ),
                Expanded(
                  child: TelemetryWidget('Контроллер', [
                    TelemetryProperty(Icons.bolt, 'controller_volts'),
                    TelemetryProperty(Icons.power, 'controller_volts')
                  ]),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: TelemetryWidget('GPS', [
                    TelemetryProperty(Icons.gps_fixed, 'position_lat'),
                    TelemetryProperty(Icons.gps_fixed, 'position_lng'),
                    TelemetryProperty(Icons.share_location, 'lap_point_lat'),
                    TelemetryProperty(Icons.share_location, 'lap_point_lng'),
                  ]),
                ),
                Expanded(
                  child: TelemetryWidget('Параметры', [
                    TelemetryProperty(Icons.timer_outlined, 'created_at'),
                    TelemetryProperty(Icons.speed, 'speed'),
                    TelemetryProperty(
                        Icons.social_distance, 'distance_travelled')
                  ]),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TelemetryButton(
                                text: "Reset point",
                                backgroundColor: const Color(0xFF72BBFF),
                                onPressed: () => ConnectorAPI.resetPoint()),
                            TelemetryButton(
                                text: "Reset distance",
                                backgroundColor: const Color(0xFF72BBFF),
                                onPressed: () => ConnectorAPI.resetDistance())
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TelemetryButton(
                                text: "Start",
                                backgroundColor: const Color(0xFF75FF72),
                                onPressed: () =>
                                    ConnectorAPI.startCompetition()),
                            TelemetryButton(
                                text: "Stop",
                                backgroundColor: const Color(0xFFFF7272),
                                onPressed: () =>
                                    ConnectorAPI.stopCompetition()),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TelemetryButton(
                                text: "Set lap point",
                                backgroundColor: const Color(0xFFFFFFFF),
                                onPressed: () => ConnectorAPI.setLapPoint()),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class TelemetryButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const TelemetryButton({
    Key? key,
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 215, // Задаем ширину кнопки
      height: 114, // Задаем высоту кнопки
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          // Цвет текста и иконок
          backgroundColor: backgroundColor,
          // Цвет фона кнопки
          textStyle: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter', // Указываем семейство шрифтов
          ),
          elevation: 10,
          // Высота тени кнопки
          shadowColor: Colors.black,
          // Цвет тени
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Скругление углов
          ),
        ),
        onPressed: onPressed, // Функция, которая будет вызвана при нажатии
        child: Text(text), // Текст внутри кнопки
      ),
    );
  }
}