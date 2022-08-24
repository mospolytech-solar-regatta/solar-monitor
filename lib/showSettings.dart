import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:solar_monitor/settings.dart';
import 'package:solar_monitor/store/dataModels.dart';

import 'models/telemetry.dart';

class ShowSettingsWidget extends StatefulWidget {
  const ShowSettingsWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShowSettingsState();
}

class _ShowSettingsState extends State<ShowSettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monitor settings'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Container(
              width: 500,
              child: Column(
                children: [
                  Consumer<TelemetryModel>(
                      builder: (context, model, child) => DataTable(
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'Name',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Value',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                            rows: <DataRow>[
                              DataRow(
                                cells: <DataCell>[
                                  const DataCell(Text('Port name')),
                                  DataCell(Text(model.settings.serialPort)),
                                ],
                              ),
                              DataRow(
                                cells: <DataCell>[
                                  const DataCell(Text('Port rate')),
                                  DataCell(
                                      Text(model.settings.serialRate.toString())),
                                ],
                              ),
                            ],
                          )),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Consumer<TelemetryModel>(
                              builder: (context, model, child) =>
                                  ElevatedButton(
                                onPressed: () {
                                  model.getSettings();
                                },
                                child: const Text('Update'),
                              ),
                            ),
                            const SizedBox(width: 5),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SettingsWidget()),
                                );
                              },
                              child: const Text('Edit'),
                            ),
                          ])),
                ],
              )),
        ),
      ),
    );
  }
}
