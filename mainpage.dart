import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:untitled7221014/secondpage.dart';
import 'model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  double lat = 0.0, lng = 0.0, lat1 = 0.0, lng1 = 0.0;
  double tracklat =0.0, tracklng =0.0;
  double streamlat =0.0, streamlng =0.0;
  String subwayName = 'invaild location',foundedName = 'not recoded';
  late int countvalue = subwayName.length;

  void getLocation() async{
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print('MYLOCATION:${position}');

    lat = position.latitude;
    lng = position.longitude;
  }
  Future<void> trackLastLocation() async {
    Position? lastPosition = await Geolocator.getLastKnownPosition();
    print('TRACKLOCATION:${lastPosition}');
    tracklat = lastPosition?.latitude as double;
    tracklng = lastPosition?.longitude as double;

  }

  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  Future<void> streamTrackLocation() async {
    StreamSubscription<Position> positionStream = await Geolocator.getPositionStream().listen(
            (Position? position) {
          print(position == null ? 'Unknown' : '  ${position.latitude.toString()}, ${position.longitude.toString()}');
        });
  }

  @override
  void initState() {
    getLocation();
    trackLastLocation();
    streamTrackLocation();
    super.initState();
  }

  void findMyposition(List<SubwayModel> subway,
      double lat, double lng, String subwaName,)
  {
    final index = subway.indexWhere((element) => element.name == subwayName);

    lat1 = subway[index].lat;
    lng1 = subway[index].lng;

    if(lat.toStringAsFixed(3) == lat1.toStringAsFixed(3) || lng.toStringAsFixed(3) == lng1.toStringAsFixed(3)){
      print('노티피케이션을 소환해 ${subway[index].name},');
    } else{
      return print('아무것도안나와 ${lat1} ${lng1} 글자수 ${countvalue}');
    }
  }

  void extractLocation(List<SubwayModel> subway, double tracklat, double tracklng, String foundedName)
  {
    final index1 = subway.indexWhere((element)
    => element.lat.toStringAsFixed(2) == tracklat.toStringAsFixed(2) ||
        element.lng.toStringAsFixed(2) == tracklng.toStringAsFixed(2));

    foundedName = subway[index1].name;

    if(lat.toStringAsFixed(3) == tracklat.toStringAsFixed(3) || lng.toStringAsFixed(3) == tracklng.toStringAsFixed(3)){
      print('UI상에서 중계해 ${subway[index1].name},');
    } else{
      return print('아무것도안나와 ${lat1} ${lng1} 글자수 ${countvalue}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(onPressed: (){}, child: Text('Back')),
                TextButton(onPressed: () async {
                  var typedName = await Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => AutocompleteBasicExample(),
                    ),
                  );
                  if (typedName != null){
                    subwayName = typedName;
                    countvalue = subwayName.length;
                  }
                }, child: Text('SearchingLocation')),
              ],
            ),
            SizedBox(height: 55,),
            TextButton(onPressed: (){
              setState(() {
                findMyposition(SubwayInfo2,lat,lng,subwayName);
                extractLocation(SubwayInfo2,tracklat,tracklng,foundedName);
              });
            }, child: Text('Set Location')),
            SizedBox(height: 35,),
            Container(

              child: Center(
                child: Column(
                  children: <Widget>[
                    Text('현재위치(내위치)'),
                    SizedBox(height: 10,),
                    Text("lat:${lat.toStringAsFixed(5)}\nlng:${lng.toStringAsFixed(5)}"   /// 현재위치
                      ,style: TextStyle(fontSize: 15),),
                  ],
                ),
              ),
            ),
            SizedBox(height: 25,),
            Container(

              child: Center(
                child: Column(
                  children: <Widget>[
                    Text('목적지: ${subwayName}',style: TextStyle(fontSize: 15),),
                    Text('lat :${lat1.toStringAsFixed(5)}\nlng;${lng1.toStringAsFixed(5)}')
                  ],
                ),
              ),
            ),
            SizedBox(height: 25,),
            Container(
              child: Column(
                children: <Widget>[
                  Text('마지막위치(내위치):${foundedName}',style: TextStyle(fontSize: 15),),
                  Text("lat:${tracklat.toStringAsFixed(5)}\nlng:${tracklng.toStringAsFixed(5)}"
                    ,style: TextStyle(fontSize: 15),),

                ],
              ),
            ),
            SizedBox(height: 25,),
            Container(
              child: Column(
                children: <Widget>[
                  Text('스트림(내위치):',style: TextStyle(fontSize: 15),),
                  // Text("lat:${tracklat.toStringAsFixed(5)}\nlng:${tracklng.toStringAsFixed(5)}"
                  //   ,style: TextStyle(fontSize: 15),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
