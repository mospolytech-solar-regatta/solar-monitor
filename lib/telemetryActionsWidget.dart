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

class TelemetryActionsWidget extends StatefulWidget {
  String widgetName = '';

  TelemetryActionsWidget(this.widgetName);

  @override
  State<TelemetryActionsWidget> createState() => _TelemetryActionsWidgetState();
}

class _TelemetryActionsWidgetState extends State<TelemetryActionsWidget> {
  String propertyName = '';
  final ButtonStyle style =
  ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

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
                builder: (context, telemetry, child) => Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ElevatedButton(
                        style: style,
                        onPressed: null,
                        child: const Text('Disabled'),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: style,
                        onPressed: () {},
                        child: const Text('Enabled'),
                      ),
                    ],
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
