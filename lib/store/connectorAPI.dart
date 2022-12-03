import 'package:http/http.dart' as http;

class ConnectorAPI{
  static var url ='http://localhost:8000';
  static var reset_point = '/action/reset_point/';
  static var reset_distance = '/action/reset_distance/';
  static var lap_point = '/action/lap_point/';
  static var start = '/race/start';
  static var stop ='/race/stop';

  static const jsonHeaders = {
    'content-type': 'application/json',
    "Access-Control-Allow-Origin": "*"
  };

  static const webHeaders = {
    "Access-Control-Allow-Origin": "*"
  };


  static resetPoint() async{
    var resp = await http.get(Uri.parse(url + reset_point), headers: webHeaders);
    if (resp.statusCode == 200) {
      print("ok");
    } else {
      throw Exception('Failed to resetPoint');
    }
  }

  static resetDistance() async{
    var resp = await http.get(Uri.parse(url + reset_distance), headers: webHeaders);
    if (resp.statusCode == 200) {
      print("ok");
    } else {
      throw Exception('Failed to resetDistance');
    }
  }

  static setLapPoint() async{
    var resp = await http.get(Uri.parse(url + lap_point), headers: webHeaders);
    if (resp.statusCode == 200) {
      print("ok");
    } else {
      throw Exception('Failed to setLapPoint');
    }
  }

  static startCompetition() async{
    var resp = await http.get(Uri.parse(url + start), headers: webHeaders);
    if (resp.statusCode == 200) {
      print("ok");
    } else {
      throw Exception('Failed to start');
    }
  }

  static stopCompetition() async{
    var resp = await http.get(Uri.parse(url + stop), headers: webHeaders);
    if (resp.statusCode == 200) {
      print("ok");
    } else {
      throw Exception('Failed to start');
    }
  }
}