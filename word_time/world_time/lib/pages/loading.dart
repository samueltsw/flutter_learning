import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  String time = 'loading';

  void setupWorldTime() async {
    WorldTime instance = WorldTime(location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin');
    await instance.getTime(); // make sure the future is delcared in the original getTime function as well as the original function its situated
    // Navigator.pushNamed(context, '/home'); // push on top of the loading route 
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location, // send the location, time and flag
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime': instance.isDaytime,
    }); // will not sit on the stack
    //print(instance.time);
    //setState((){
    // time = instance.time;
    //});
  }

  @override
  void initState() {
    super.initState(); //run the original function we originally riding on
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: SpinKitRing(
          color: Colors.white,
          size: 50.0,
          )
      )
    );
  }
}
