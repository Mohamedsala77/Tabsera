class Ayahs {
  int number;
  String text;
  int numberInSurah;
  int juz;
  int manzil;
  int page;
  int ruku;
  int hizbQuarter;
  bool sajda;

  Ayahs(
      {int number,
        String audio,
        List<String> audioSecondary,
        String text,
        int numberInSurah,
        int juz,
        int manzil,
        int page,
        int ruku,
        int hizbQuarter,
        bool sajda}) {
    this.number = number;
    this.text = text;
    this.numberInSurah = numberInSurah;
    this.juz = juz;
    this.manzil = manzil;
    this.page = page;
    this.ruku = ruku;
    this.hizbQuarter = hizbQuarter;
    this.sajda = sajda;
  }



  Ayahs.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    text = json['text'];
    numberInSurah = json['numberInSurah'];
    juz = json['juz'];
    manzil = json['manzil'];
    page = json['page'];
    ruku = json['ruku'];
    hizbQuarter = json['hizbQuarter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['text'] = this.text;
    data['numberInSurah'] = this.numberInSurah;
    data['juz'] = this.juz;
    data['manzil'] = this.manzil;
    data['page'] = this.page;
    data['ruku'] = this.ruku;

    data['hizbQuarter'] = this.hizbQuarter;
    data['sajda'] = this.sajda;
    return data;
  }
}