import 'dart:convert';

import 'package:solar_monitor/store/dataModels.dart';
import 'package:http/http.dart' as http;

class BoatConnector {
  var url = '';
  var currentStateEndpoint = '';
  var settingsEndpoint = '';
  final jsonHeaders = const {
    'content-type': 'application/json',
    "Access-Control-Allow-Origin": "*"
  };

  final webHeaders = const {
    "Access-Control-Allow-Origin": "*"
  };

  BoatConnector() {
    url = 'http://localhost:8000';
    currentStateEndpoint = '/state/';
    settingsEndpoint = '/serial/config/';
  }

  Future<TelemetryMetric> getLatestTelemetry() async {
    var resp = await http.get(Uri.parse(url + currentStateEndpoint), headers: webHeaders);
    if (resp.statusCode == 200) {
      return TelemetryMetric.fromJson(jsonDecode(resp.body));
    } else {
      throw Exception('Failed to load telemetryMetric');
    }
  }

  Future<Settings> getSettings() async {
    var resp = await http.get(Uri.parse(url + settingsEndpoint), headers: webHeaders);
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
        headers: jsonHeaders, body: jsonEncode(body));
    if (resp.statusCode == 200) {
      return Settings.fromJson(jsonDecode(resp.body));
    } else {
      throw Exception('Failed to load telemetryMetric');
    }
  }


}
