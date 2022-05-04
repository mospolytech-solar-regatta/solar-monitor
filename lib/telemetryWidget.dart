import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/telemetry.dart';

class TelemetryProperty {
  Icon icon = const Icon(Icons.device_unknown);
  String propName;

  TelemetryProperty(IconData iconName, this.propName) {
    icon = Icon(iconName);
  }
}

class TelemetryWidget extends StatefulWidget {
  String widgetName = '';
  List<TelemetryProperty> properties = [];

  TelemetryWidget(this.widgetName, this.properties);

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
              style: const TextStyle(fontSize: 17),
            ),
            const Divider(
              thickness: 2,
            ),
            Consumer<TelemetryModel>(
                builder: (context, telemetry, child) => ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(2),
                    itemCount: widget.properties.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: widget.properties[index].icon,
                        title: Text(
                            '${telemetry.getProp(widget.properties[index].propName)}'),
                        subtitle: Text(widget.properties[index].propName),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
