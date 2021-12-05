import "package:http/http.dart";
import "dart:convert";
import "package:intl/intl.dart";

class WorldTime {
  String location;
  String time;
  String flag;
  String url;
  bool isDay;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      var uri = Uri.http("worldtimeapi.org", "/api/timezone/$url");

      Response res = await get(uri);
      Map data = jsonDecode(res.body);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      print(datetime);
      print(offset);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDay = now.hour > 5 && now.hour < 18 ? true : false;
      // set Time property
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('Caught erro: $e');
      time = "Unable to get time";
    }
  }
}
