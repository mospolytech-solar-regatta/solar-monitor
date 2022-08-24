// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dataModels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TelemetryMetric _$TelemetryMetricFromJson(Map<String, dynamic> json) =>
    TelemetryMetric(
      DateTime.parse(json['created_at'] as String),
      (json['controller_watts'] as num).toDouble(),
      (json['controller_volts'] as num).toDouble(),
      (json['time_to_go'] as num).toDouble(),
      (json['motor_temp'] as num).toDouble(),
      (json['motor_revols'] as num).toDouble(),
      (json['MPPT_volts'] as num).toDouble(),
      (json['MPPT_watts'] as num).toDouble(),
      (json['distance_travelled'] as num).toDouble(),
      (json['lap_point_lat'] as num?)?.toDouble(),
      (json['lap_point_lng'] as num?)?.toDouble(),
      json['laps'] as int,
      (json['position_lat'] as num).toDouble(),
      (json['position_lng'] as num).toDouble(),
      (json['speed'] as num).toDouble(),
    );

Map<String, dynamic> _$TelemetryMetricToJson(TelemetryMetric instance) =>
    <String, dynamic>{
      'MPPT_watts': instance.MPPTWatts,
      'MPPT_volts': instance.MPPTVolts,
      'created_at': instance.createdAt.toIso8601String(),
      'controller_watts': instance.controllerWatts,
      'controller_volts': instance.controllerVolts,
      'time_to_go': instance.timeToGo,
      'motor_temp': instance.motorTemp,
      'motor_revols': instance.motorRevols,
      'speed': instance.speed,
      'position_lat': instance.positionLat,
      'position_lng': instance.positionLng,
      'distance_travelled': instance.distanceTravelled,
      'laps': instance.laps,
      'lap_point_lng': instance.lapPointLng,
      'lap_point_lat': instance.lapPointLat,
    };

Settings _$SettingsFromJson(Map<String, dynamic> json) => Settings(
      json['serial_port'] as String,
      json['serial_rate'] as int,
    );

Map<String, dynamic> _$SettingsToJson(Settings instance) => <String, dynamic>{
      'serial_port': instance.serialPort,
      'serial_rate': instance.serialRate,
    };
