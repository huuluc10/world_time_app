import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WorldTime {
  late String location; //location name for the UI
  late String time; //time in that location
  late String flag; //url to an asset flag icon
  late String url; //location url for api endpoint
  late bool isDayTime; //true or false if daytime or not

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      //make the request
      Uri urlocators = Uri.parse("http://worldtimeapi.org/api/timezone/$url");
      http.Response response = await http.get(urlocators);
      Map data = jsonDecode(response.body);
      // print(data);

      //get properties from data
      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      // print(dateTime);
      // print(offset);

      //create a DateTime object
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set the time property
      time = DateFormat.jm().format(now);
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
    } catch (e) {
      print('cauth failed: $e');
      time = 'could not get time data';
    }
  }
}
