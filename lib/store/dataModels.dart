// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';

part 'dataModels.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TelemetryMetric {
  @JsonKey(name: 'MPPT_watts')
  double MPPTWatts;
  @JsonKey(name: 'MPPT_volts')
  double MPPTVolts;

  DateTime createdAt;
  double controllerWatts;
  double controllerVolts;
  double timeToGo;
  double motorTemp;
  double motorRevols;
  double speed;
  double positionLat;
  double positionLng;
  double distanceTravelled;
  int laps;
  double lapPointLng;
  double lapPointLat;

  TelemetryMetric(
      this.createdAt,
      this.controllerWatts,
      this.controllerVolts,
      this.timeToGo,
      this.motorTemp,
      this.motorRevols,
      this.MPPTVolts,
      this.MPPTWatts,
      this.distanceTravelled,
      this.lapPointLat,
      this.lapPointLng,
      this.laps,
      this.positionLat,
      this.positionLng,
      this.speed);

  dynamic getProp(String name) {
    var model = toJson();
    return model[name];
  }

  factory TelemetryMetric.fromJson(Map<String, dynamic> json) =>
      _$TelemetryMetricFromJson(json);

  Map<String, dynamic> toJson() => _$TelemetryMetricToJson(this);

  static TelemetryMetric dummy() {
    return TelemetryMetric(DateTime(0), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Settings {
  String name;
  int rate;

  Settings(this.name, this.rate);

  factory Settings.fromJson(Map<String, dynamic> json) =>
      _$SettingsFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsToJson(this);
  static Settings dummy() {
    return Settings('', 0);
  }
}
