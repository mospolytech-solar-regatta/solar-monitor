import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_monitor/settings.dart';
import 'package:solar_monitor/showSettings.dart';
import 'models/telemetry.dart';
import 'telemetryWidget.dart';

void main() {
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
        child: MaterialApp(
          title: 'Solar Monitor',
          theme: ThemeData(

            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(title: 'Solar monitor'),
        ));
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
                    MaterialPageRoute(builder: (context) => const ShowSettingsWidget()),
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
                  child: TelemetryWidget('Мотор', [TelemetryProperty(Icons.thermostat, 'motor_temp')]),
                ),
                Expanded(
                  child: TelemetryWidget(
                      'MPPT', [TelemetryProperty(Icons.bolt, 'MPPT_volts'),TelemetryProperty(Icons.power, 'MPPT_volts')]),
                ),
                Expanded(
                  child: TelemetryWidget('Контроллер',
                      [TelemetryProperty(Icons.bolt, 'controller_volts'),TelemetryProperty(Icons.power, 'controller_volts')]),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: TelemetryWidget('Empty', []),
                ),
                Expanded(
                  child: TelemetryWidget(
                      'Empty', []),
                ),
                Expanded(
                  child: TelemetryWidget('Empty',
                      const []),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
