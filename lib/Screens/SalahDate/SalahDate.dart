import 'package:flutter/material.dart';
import 'package:tabsera/Model/SalahTimeMOdel.dart';
import 'package:tabsera/server/SalahTime.dart';
class PrayingDate extends StatefulWidget {
  @override
  _PrayingDateState createState() => _PrayingDateState();
}

class _PrayingDateState extends State<PrayingDate> {
  Timeing timeing=Timeing();
  var Cityname;
  var country;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("توقيت الصلاة"),),
      body: Container(
        child: ListView(children: [


          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(

                onChanged: (value){
                  setState(() {
                    country=value;
                  });
                },

                decoration: InputDecoration(
                    fillColor: Colors.grey,
                    focusColor: Colors.grey,
                    enabledBorder: OutlineInputBorder(

                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                          width: 2
                        ),
                        borderRadius: BorderRadius.circular(50.0)),
                    focusedBorder: OutlineInputBorder(

                        borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width: 2
                        ),
                        borderRadius: BorderRadius.circular(50.0)) ,
                    hintText: "Add your Country",
                    labelText: "الدولة",
                    suffix: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: (){
                        setState(() {

                        });
                      },
                    )
                )),
          ),
          SizedBox(height: 30,),
          FutureBuilder(
            future: timeing.salahTimeing(country,Cityname),
            builder: (context,snapshot){
              SalahTime salahTime=snapshot.data;
              if(snapshot.hasData){
                return Column(
                  children: [
                    Text(salahTime.Fajr,style: TextStyle(fontSize: 30),)  ,
                    Text(salahTime.Sunrise,style: TextStyle(fontSize: 30),)  ,
                    Text(salahTime.Dhuhr,style: TextStyle(fontSize: 30),)  ,
                    Text(salahTime.Asr,style: TextStyle(fontSize: 30),)  ,
                    Text(salahTime.Sunset,style: TextStyle(fontSize: 30),)  ,
                    Text(salahTime.Maghrib,style: TextStyle(fontSize: 30),)  ,
                    Text(salahTime.Isha,style: TextStyle(fontSize: 30),)  ,
                    Text(salahTime.timezone,style: TextStyle(fontSize: 30),)  ,

                  ],
                );
              }else{
                return Center(child: Container(
                  child: CircularProgressIndicator(),
                ),);
              }
            },

          )
        ],),
      ),
    );
  }
}
