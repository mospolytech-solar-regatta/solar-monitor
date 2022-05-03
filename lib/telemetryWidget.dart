import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/telemetry.dart';

class TelemetryWidget extends StatefulWidget {
  String widgetName = '';
  List<String> propertyNames = [];

  TelemetryWidget(this.widgetName, this.propertyNames);

  @override
  State<TelemetryWidget> createState() => _TelemetryWidgetState();
}

class _TelemetryWidgetState extends State<TelemetryWidget> {
  String propertyName = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      padding: const EdgeInsets.all(8),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              widget.widgetName,
              style: TextStyle(fontSize: 17),
            ),
            const Divider(
              thickness: 2,
            ),
            // Consumer<TelemetryModel>(
            //     builder: (context, telemetry, child) => Container(
            //         height: 30,
            //         child: ListTile(
            //           leading: Icon(Icons.thermostat),
            //           title:
            //               Text('${telemetry.getProp(widget.propertyNames[0])}'),
            //           subtitle: Text(widget.propertyNames[0]),
            //         ))),
            Consumer<TelemetryModel>(
                builder: (context, telemetry, child) => ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(2),
                    itemCount: widget.propertyNames.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Icon(Icons.thermostat),
                        title: Text(
                            '${telemetry.getProp(widget.propertyNames[0])}'),
                        subtitle: Text(widget.propertyNames[0]),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
