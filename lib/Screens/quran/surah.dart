import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabsera/Model/Ahya.dart';
import 'package:tabsera/Model/QuranModel.dart';
import 'package:tabsera/server/quranApi.dart';
import 'package:flutter_circular_slider/flutter_circular_slider.dart';
import 'Quran-Home.dart';

class SorahList extends StatefulWidget {
  @override
  _SorahListState createState() => _SorahListState();
}

class _SorahListState extends State<SorahList> {
  @override
  Widget build(BuildContext context) {
    QuranServer quranServer = QuranServer();
    return FutureBuilder(
        future: quranServer.QuranData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Surah> surah = snapshot.data;
            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: surah.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Container(
                    color: (index % 2 == 0
                        ? Color(0xff457b9d).withOpacity(.2)
                        : Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: ScreenUtil().setWidth(70),
                                width: ScreenUtil().setWidth(70),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/sura_num.png",
                                    ),
                                  ),
                                ),
                                child: Text(
                                  surah[index].number.toString(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(36),
                                      color: Color(0xff457b9d)),
                                ),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(30),
                              ),
                              Text(
                                surah[index].name.toString(),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(40),
                                  color: Color(0xff1d3557),
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(
                                      width: 1,
                                      color: (index % 2 == 0
                                          ? Color(0xff1d3557)
                                          : Color(0xff457b9d)))),
                              child: Icon(Icons.play_arrow_outlined,
                                  color: (index % 2 == 0
                                      ? Color(0xff1d3557)
                                      : Color(0xff457b9d))),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => QuranAudio(
                                            ayat: surah[index].ayahs,

                                            // surah: surah[index],
                                          ))));
                              //Audio for Surah ...........
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    // List<Ayahs> ayah = snapshot.data;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => QHome(
                                  surah: surah[index],
                                  nomPageF: surah[index].ayahs.first.page,
                                  nomPageL: surah[index].ayahs.last.page,

                                  // surah: surah[index],
                                ))));
                  },
                );
              },
            );
          } else {
            return Center(
              // ignore: deprecated_member_use
              child: FlatButton(child: Text("data"),onPressed: (){
              print("ddd");
              },),
            );
          }
        });
  }
}

class QuranAudio extends StatefulWidget {
  List<Ayahs> ayat;

  QuranAudio({this.ayat});

  @override
  _QuranAudioState createState() => _QuranAudioState();
}

class _QuranAudioState extends State<QuranAudio> {
  AudioCache audioCache;
  AudioPlayer audioPlayer;
  Duration _duration = Duration();
  Duration _position = Duration();
  bool playing = false;
  int allduration;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlayer();
  }

  void initPlayer() {
    audioPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: audioPlayer);
  }

  Future<bool> onStop() {
    audioPlayer.pause();
  }
  int endtime=0;
int initime=0;
  @override
  Widget build(BuildContext context) {
    List<String> ayat = [];
    List<String> AduoAyah() {
      widget.ayat.forEach((element) {
        ayat.add(element.audio);
      });
      print(ayat[0]);
      return ayat;
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Stack(
        children: [
          /* Container(
            child: Image.asset(
              "assets/images/audio2.jpg",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),*/
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: ScreenUtil().setHeight(0),
                  ),
                  Container(
                    color: Colors.grey,
                    child: DoubleCircularSlider(
                      endtime,initime,endtime
                    ),
                  ),
                  Slider(
                      activeColor: Colors.blue.withOpacity(0.2),
                      inactiveColor: Colors.grey,
                      value: _position.inSeconds.toDouble(),
                      max: _duration.inSeconds.toDouble(),
                      onChanged: (double value) {
                        setState(() {
                          audioPlayer.seek(Duration(seconds: value.toInt()));
                        });
                      }),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${_position.inSeconds.toDouble()}"),
                        Text("${_duration.inSeconds.toDouble()}"),
                      ],
                    ),
                  ),
                  IconButton(
                    color: Colors.black54,
                    onPressed: () {
                      setState(() {
                        playing = !playing;
                      });
                      if (playing) {
                        nextTrack(AduoAyah(), 0);
                      } else {
                        onStop();
                      }
                      audioPlayer.onDurationChanged.listen((d) {
                        setState(() {
                          _duration = d;
                          endtime=_duration.inSeconds.toInt();
                        });

                      });
                      audioPlayer.onAudioPositionChanged.listen((p) {
                        setState(() {

                          _position = p;
                        });
                      });
                    },
                    icon: Icon(
                      playing
                          ? Icons.pause_circle_outline
                          : Icons.play_circle_outline,
                      size: 60,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  play(List<String> urlList, int currentIndex) async {
    int result = await audioPlayer.play(urlList[currentIndex]);
    if (result == 1) {
      //  print('Success: is playing');
    } else {
      //  print('Error on audio play');
    }
    audioPlayer.onPlayerCompletion.listen((event) {
      if (currentIndex < urlList.length - 1) {
        currentIndex = currentIndex + 1;
        nextTrack(urlList, currentIndex);
setState(() {
      _position = _duration;
    });
        //    print("NEXT AUDIO! $currentIndex");
      } else {
        //   print("AUDIO COMPLETED PLAYING");
      }
    });
  }

  void nextTrack(List<String> urlList, int currentIndex) {
    play(urlList, currentIndex);
  }
}
