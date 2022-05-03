import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:solar_monitor/store/dataModels.dart';

import '../store/boatConnector.dart';

@immutable
class Item {
  final String name;

  const Item(this.name);
}

class TelemetryModel extends ChangeNotifier {
  final List<Item> _items = [];
  late TelemetryMetric telemetryMetric;
  late Settings settings;
  late BoatConnector store;

  TelemetryModel() {
    Timer timer =
        Timer.periodic(Duration(seconds: 15), (Timer t) => updateData());
    store = BoatConnector();
    updateData();
    getSettings();
  }

  void updateData() {
    store.getLatestTelemetry().then(updateMetrics);
  }

  dynamic getProp(String name) {
    return telemetryMetric.getProp(name);
  }

  void updateMetrics(TelemetryMetric value) {
    telemetryMetric = value;
    notifyListeners();
  }

  updateSettings(Settings value) {
    settings = value;
    notifyListeners();
  }

  void getSettings() {
    store.getSettings().then(updateSettings);
  }

  void setSettings(Settings settings) {
    store.setSettings(settings).then(updateSettings);
  }
}
