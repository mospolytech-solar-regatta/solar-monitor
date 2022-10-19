import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  WindowOptions windowOptions = WindowOptions(
    size: Size(1024, 600),
    // center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    // titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    // await windowManager.setFullScreen(true);
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
              title: 'Solar Monitor',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: const MyHomePage(title: 'Solar monitor'),
            )));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ShowSettingsWidget()),
                  );
                },
                child: const Icon(
                  Icons.settings,
                  size: 26.0,
                ),
              )),
        ],
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
                  child: TelemetryWidget('Empty', const []),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
