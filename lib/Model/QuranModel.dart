
import 'Ahya.dart';
class Surah {
  int number;
  String name;
  String englishName;
  String englishNameTranslation;
  String revelationType;
  List<Ayahs> ayahs;

  Surah(
      {int number,
        String name,
        String englishName,
        String englishNameTranslation,
        String revelationType,
        List<Ayahs> ayahs}) {
    this.number = number;
    this.name = name;
    this.englishName = englishName;
    this.englishNameTranslation = englishNameTranslation;
    this.revelationType = revelationType;
    this.ayahs = ayahs;
  }



  Surah.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    name = json['name'];
    englishName = json['englishName'];
    englishNameTranslation = json['englishNameTranslation'];
    revelationType = json['revelationType'];
    if (json['ayahs'] != null) {
      ayahs = new List<Ayahs>();
      json['ayahs'].forEach((v) {
        ayahs.add(new Ayahs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['name'] = this.name;
    data['englishName'] = this.englishName;
    data['englishNameTranslation'] = this.englishNameTranslation;
    data['revelationType'] = this.revelationType;
    if (this.ayahs != null) {
      data['ayahs'] = this.ayahs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

