import 'dart:convert';

import 'package:solar_monitor/store/dataModels.dart';
import 'package:http/http.dart' as http;

class BoatConnector {
  var url = '';
  var currentStateEndpoint = '';
  var settingsEndpoint = '';
  final jsonHeaders = const {
    'content-type': 'application/json',
  };

  BoatConnector() {
    url = 'http://localhost:8000';
    currentStateEndpoint = '/current_state/';
    settingsEndpoint = '/serial_config/';
  }

  Future<TelemetryMetric> getLatestTelemetry() async {
    var resp = await http.get(Uri.parse(url + currentStateEndpoint));
    if (resp.statusCode == 200) {
      return TelemetryMetric.fromJson(jsonDecode(resp.body));
    } else {
      throw Exception('Failed to load telemetryMetric');
    }
  }

  Future<Settings> getSettings() async {
    var resp = await http.get(Uri.parse(url + settingsEndpoint));
    if (resp.statusCode == 200) {
      return Settings.fromJson(jsonDecode(resp.body));
    } else {
      throw Exception('Failed to load Settings');
    }
  }

  Future<Settings> setSettings(Settings settings) async {
    var body = settings.toJson();
    print(body);
    var resp = await http.post(Uri.parse(url + settingsEndpoint),
        headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode(body));
    if (resp.statusCode == 200) {
      return Settings.fromJson(jsonDecode(resp.body));
    } else {
      throw Exception('Failed to load telemetryMetric');
    }
  }
}
