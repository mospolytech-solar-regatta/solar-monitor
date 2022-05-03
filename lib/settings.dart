import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_monitor/store/dataModels.dart';

import 'models/telemetry.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final rateController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<TelemetryModel>(builder: (context, model, child) {
      rateController.text = model.settings.rate.toString();
      nameController.text = model.settings.name.toString();
      return Scaffold(
        appBar: AppBar(
          title: const Text('Monitor settings'),
        ),
        body: Center(
            child: Container(
          width: 500,
          child: Form(
            key: _formKey,
            child: Consumer<TelemetryModel>(
              builder: (context, model, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: rateController,
                    decoration: const InputDecoration(
                      hintText: 'rate',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: 'port name',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        int rate = int.parse(rateController.text);
                        var s = Settings(nameController.text, rate);
                        model.setSettings(s);
                        model.getSettings();
                        Navigator.pop(context);
                      },
                      child: const Text('Update'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )),
      );
    });
  }
}
