import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'models/telemetry.dart';

class TelemetryProperty {
  String propName;

  TelemetryProperty(this.propName);
}

class TelemetryWidget extends StatefulWidget {
  List<TelemetryProperty> properties = [];

  TelemetryWidget(this.properties, {Key? key}) : super(key: key);

  @override
  State<TelemetryWidget> createState() => _TelemetryWidgetState();
}

class _TelemetryWidgetState extends State<TelemetryWidget> {
  String propertyName = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      padding: const EdgeInsets.all(0),
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
                        title: Text(
                            '${telemetry.getProp(widget.properties[index].propName)}',
                            style: TextStyle(fontSize: 30.sp)),
                        subtitle: Text(widget.properties[index].propName,
                            style: TextStyle(fontSize: 30.sp)),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
