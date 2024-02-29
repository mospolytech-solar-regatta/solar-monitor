import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'models/telemetry.dart';

class TelemetryProperty {
  String propName;

  TelemetryProperty(this.propName);
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
      // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 8.0,),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Consumer<TelemetryModel>(
                builder: (context, telemetry, child) => ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0),
                    itemCount: widget.properties.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        dense: true,
                        visualDensity: const VisualDensity(vertical: -4),
                        subtitle: Text(widget.properties[index].propName,
                            style: TextStyle(fontSize: 30.sp)),
                        title: Text(
                            '${telemetry.getProp(widget.properties[index].propName)}',
                            style: TextStyle(fontSize: 30.sp)),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
