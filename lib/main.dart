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
import 'package:flutter_windowmanager/flutter_windowmanager.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    backgroundColor: Color(0xFF20242D),
    skipTaskbar: true,
    titleBarStyle: TitleBarStyle.hidden,
    fullScreen: true,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.setFullScreen(false);
    await windowManager.focus();
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TelemetryModel()),
        ],
        child: ScreenUtilInit(
            designSize: const Size(1280, 800),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  textTheme:
                      Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
                ),
                home: child,
              );
            },
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(),
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
    return const Scaffold(
      backgroundColor: Color(0xFF20242D),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            WidgetBlock(),
            ButtonBlock(),
          ],
        ),
      ),
    );
  }
}

class WidgetBlock extends StatelessWidget {
  const WidgetBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: TelemetryWidget([
              TelemetryProperty(('motor_temp'),TextStyle(fontSize: 80.sp, color: const Color(0xFFFFFFFF), fontWeight: FontWeight.bold,fontFamily: 'Inter',), TextStyle(fontSize: 32.sp, color: const Color(0xFF72BBFF), fontWeight: FontWeight.bold,fontFamily: 'Inter',)),
              TelemetryProperty(('controller_volts'),TextStyle(fontSize: 80.sp, color: const Color(0xFFFFFFFF), fontWeight: FontWeight.bold,fontFamily: 'Inter',), TextStyle(fontSize: 32.sp, color: const Color(0xFF72BBFF), fontWeight: FontWeight.bold,fontFamily: 'Inter',)),
              TelemetryProperty(('time_to_go'),TextStyle(fontSize: 80.sp, color: const Color(0xFFFFFFFF), fontWeight: FontWeight.bold,fontFamily: 'Inter',), TextStyle(fontSize: 32.sp, color: const Color(0xFF72BBFF), fontWeight: FontWeight.bold,fontFamily: 'Inter',))
            ]),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: TelemetryWidget([
                    TelemetryProperty(('created_at'),TextStyle(fontSize: 24.sp, color: const Color(0xFFFFFFFF), fontWeight: FontWeight.bold,fontFamily: 'Inter',), TextStyle(fontSize: 24.sp, color: const Color(0xFF72BBFF), fontWeight: FontWeight.bold,fontFamily: 'Inter',)),
                    TelemetryProperty(('distance_travelled'),TextStyle(fontSize: 24.sp, color: const Color(0xFFFFFFFF), fontWeight: FontWeight.bold,fontFamily: 'Inter',), TextStyle(fontSize: 24.sp, color: const Color(0xFF72BBFF), fontWeight: FontWeight.bold,fontFamily: 'Inter',))
                  ]),
                ),
                Expanded(
                  flex: 5,
                  child: TelemetryWidget([TelemetryProperty(('motor_revols'), TextStyle(fontSize: 128.sp, color: const Color(0xFFFFFFFF),fontWeight: FontWeight.bold,fontFamily: 'Inter',), TextStyle(fontSize: 50.sp, color: const Color(0xFF72BBFF), fontWeight: FontWeight.bold,fontFamily: 'Inter',))]),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: TelemetryWidget([
                    TelemetryProperty(('position_lat'), TextStyle(fontSize: 30.sp, color: const Color(0xFFFFFFFF), fontWeight: FontWeight.bold,fontFamily: 'Inter',), TextStyle(fontSize: 30.sp, color: const Color(0xFF72BBFF), fontWeight: FontWeight.bold,fontFamily: 'Inter',)),
                    TelemetryProperty(('position_lng'),TextStyle(fontSize: 30.sp, color: const Color(0xFFFFFFFF), fontWeight: FontWeight.bold,fontFamily: 'Inter',), TextStyle(fontSize: 30.sp, color: const Color(0xFF72BBFF), fontWeight: FontWeight.bold,fontFamily: 'Inter',)),
                    TelemetryProperty(('lap_point_lat'),TextStyle(fontSize: 30.sp, color: const Color(0xFFFFFFFF), fontWeight: FontWeight.bold,fontFamily: 'Inter',), TextStyle(fontSize: 30.sp, color: const Color(0xFF72BBFF), fontWeight: FontWeight.bold,fontFamily: 'Inter',)),
                    TelemetryProperty(('lap_point_lng'),TextStyle(fontSize: 30.sp, color: const Color(0xFFFFFFFF), fontWeight: FontWeight.bold,fontFamily: 'Inter',), TextStyle(fontSize: 30.sp, color: const Color(0xFF72BBFF), fontWeight: FontWeight.bold,fontFamily: 'Inter',))
                  ]),
                ),
                Expanded(
                  child: TelemetryWidget([
                    TelemetryProperty(('speed'),TextStyle(fontSize: 96.sp, color: const Color(0xFFFFFFFF), fontWeight: FontWeight.bold,), TextStyle(fontSize: 40.sp, color: const Color(0xFF72BBFF), fontWeight: FontWeight.bold,))
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
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
    const double width = 220 * 0.85;
    const double height = 114 * 0.75;

    return SizedBox(
      width: width, // Новая ширина
      height: height, // Новая высота
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: backgroundColor,
          textStyle: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
          elevation: 10,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}

class ButtonBlock extends StatelessWidget {
  const ButtonBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 10.0,
      ),
      margin: const EdgeInsets.only(
          top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
      decoration: BoxDecoration(
        color: const Color(0xFF21374A),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TelemetryButton(
              text: "Reset point",
              backgroundColor: const Color(0xFF72BBFF),
              onPressed: () => ConnectorAPI.resetPoint()),
          TelemetryButton(
              text: "Reset distance",
              backgroundColor: const Color(0xFF72BBFF),
              onPressed: () => ConnectorAPI.resetDistance()),
          TelemetryButton(
              text: "Start",
              backgroundColor: const Color(0xFF75FF72),
              onPressed: () => ConnectorAPI.startCompetition()),
          TelemetryButton(
              text: "Stop",
              backgroundColor: const Color(0xFFFF7272),
              onPressed: () => ConnectorAPI.stopCompetition()),
          TelemetryButton(
              text: "Set lap point",
              backgroundColor: const Color(0xFFFFFFFF),
              onPressed: () => ConnectorAPI.setLapPoint()),
        ],
      ),
    );
  }
}
