import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'models/telemetry.dart';

final Map<String, String> propertyTitleMap = {
  'motor_temp': 'engine',
  'controller_volts': 'controller',
  'time_to_go': 'time to go',
  'motor_revols': 'revolutions'
};

class TelemetryProperty {
  String propName;
  TextStyle textStyle;
  TextStyle titleStyle;

  TelemetryProperty(this.propName, this.textStyle, this.titleStyle);
}

class TelemetryWidget extends StatefulWidget {
  final List<TelemetryProperty> properties;

  const TelemetryWidget(this.properties, {Key? key}) : super(key: key);

  @override
  State<TelemetryWidget> createState() => _TelemetryWidgetState();
}

class _TelemetryWidgetState extends State<TelemetryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 8.0,
      ),
      child: Card(
        color: const Color(0xFF21374A),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Consumer<TelemetryModel>(
                builder: (context, telemetry, child) => ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0),
                    itemCount: widget.properties.length,
                    itemBuilder: (BuildContext context, int index) {
                      final propName = widget.properties[index].propName;
                      final titleStyle = widget.properties[index].titleStyle;
                      final textStyle = widget.properties[index].textStyle;
                      final value = telemetry.getProp(propName);

                      Widget subtitle;
                      switch (propName) {
                        case 'distance_travelled':
                          subtitle = Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                propertyTitleMap[propName] ?? propName,
                                style: titleStyle,
                              ),
                              Text(
                                '$value',
                                style: textStyle,
                              ),
                            ],
                          );
                          break;
                        case 'created_at':
                          subtitle = Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                propertyTitleMap[propName] ?? propName,
                                style: titleStyle,
                              ),
                              Text(
                                '$value',
                                style: textStyle,
                              ),
                            ],
                          );
                          break;
                        case 'lap_point_lng':
                          subtitle = Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                propertyTitleMap[propName] ?? propName,
                                style: titleStyle,
                              ),
                              Text(
                                '$value',
                                style: textStyle,
                              ),
                            ],
                          );
                          break;
                        case 'lap_point_lat':
                          subtitle = Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                propertyTitleMap[propName] ?? propName,
                                style: titleStyle,
                              ),
                              Text(
                                '$value',
                                style: textStyle,
                              ),
                            ],
                          );
                          break;
                        case 'position_lng':
                          subtitle = Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                propertyTitleMap[propName] ?? propName,
                                style: titleStyle,
                              ),
                              Text(
                                '$value',
                                style: textStyle,
                              ),
                            ],
                          );
                          break;
                        case 'position_lat':
                          subtitle = Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                propertyTitleMap[propName] ?? propName,
                                style: titleStyle,
                              ),
                              Text(
                                '$value',
                                style: textStyle,
                              ),
                            ],
                          );
                          break;
                        case 'speed':
                          subtitle = Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  '$value',
                                  style: textStyle,
                                ),
                              ),
                              Center(
                                child: Text(
                                  'mps',
                                  style: TextStyle(
                                    fontSize: 40.sp,
                                    color: const Color(0xFF72BBFF),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          );
                          break;
                        case 'motor_revols':
                          subtitle = Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  '$value',
                                  style: textStyle,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Center(
                                child: Text(
                                  'rpm',
                                  style: TextStyle(
                                    fontSize: 40.sp,
                                    color: const Color(0xFF72BBFF),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          );
                          break;
                        case 'motor_temp':
                          subtitle = Stack(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/temp.png',
                                    // путь к изображению
                                    width: 85.w,
                                    height: 136.h,
                                  ),
                                  SizedBox(width: 25.w),
                                  // Добавьте отступ между картинкой и текстом
                                  Text(
                                    '$value',
                                    style: textStyle,
                                  ),
                                  SizedBox(width: 4.w),
                                ],
                              ),
                              Positioned(
                                left: 290.w,
                                bottom: 25,
                                child: Text(
                                  '°C',
                                  style: TextStyle(
                                    fontSize: 48.sp,
                                    color: const Color(0xFF72BBFF),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          );
                          break;
                        case 'controller_volts':
                          subtitle = Stack(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/controller.png',
                                    width: 93.w,
                                    height: 93.h,
                                  ),
                                  SizedBox(width: 15.w),
                                  Text(
                                    '$value',
                                    style: textStyle,
                                  ),
                                  SizedBox(width: 4.w),
                                ],
                              ),
                              Positioned(
                                left: 290.w,
                                bottom: 10,
                                child: Text(
                                  'B',
                                  style: TextStyle(
                                    fontSize: 48.sp,
                                    color: const Color(0xFF72BBFF),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          );
                          break;
                        case 'time_to_go':
                          subtitle = Stack(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/batary.png',
                                    width: 108.w,
                                    height: 105.h,
                                  ),
                                  SizedBox(width: 15.w),
                                  Text(
                                    '$value',
                                    style: textStyle,
                                  ),
                                  SizedBox(width: 4.w),
                                ],
                              ),
                              Positioned(
                                left: 290.w,
                                bottom: 10,
                                child: Text(
                                  'Min',
                                  style: TextStyle(
                                    fontSize: 48.sp,
                                    color: const Color(0xFF72BBFF),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          );
                          break;

                        default:
                          subtitle = Text(
                            '$value',
                            style: textStyle,
                          );
                          break;
                      }
                      return ListTile(
                        dense: true,
                        visualDensity: const VisualDensity(vertical: -4),
                        title: propName == 'position_lat'
                            ? Center(
                                child: Text(
                                  'GPS',
                                  style: titleStyle,
                                ),
                              )
                            : propName == 'created_at'
                                ? Center(
                                    child: Text(
                                      'parameters',
                                      style: titleStyle,
                                    ),
                                  )
                                : propName != 'position_lng' &&
                                        propName != 'lap_point_lat' &&
                                        propName != 'lap_point_lng' &&
                                        propName != 'distance_travelled'
                                    ? Center(
                                        child: Text(
                                          propertyTitleMap[propName] ??
                                              propName,
                                          style: titleStyle,
                                        ),
                                      )
                                    : null,
                        subtitle: Center(child: subtitle),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
