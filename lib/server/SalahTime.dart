import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:tabsera/Model/SalahTimeMOdel.dart';
class Timeing {
  Future<SalahTime> salahTimeing(String country,String city) async {
    final response =
    await http.get("https://api.aladhan.com/v1/timingsByCity?city=a&country=${country}&method=8");
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["data"];
      return SalahTime(
        Asr: data["timings"]["Asr"],
        Dhuhr: data["timings"]["Dhuhr"],
        Fajr: data["timings"]["Fajr"],
        Imsak:  data["timings"]["Asr"],
        Isha:  data["timings"]["Isha"],
        Maghrib:  data["timings"]["Maghrib"],
        Midnight: data["timings"]["Midnight"],
        Sunrise: data["timings"]["Sunrise"],
        Sunset: data["timings"]["Sunset"],
       gregoriandata: data["date"]["gregorian"]["date"],
        hijridate:  data["date"]["hijri"]["date"],
        timezone:  data["meta"]["timezone"]
      );

    } else {
      throw Exception('Failed to load ');
    }
  }
}
