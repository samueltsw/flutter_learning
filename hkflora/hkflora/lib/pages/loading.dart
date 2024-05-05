import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hkflora/pages/home.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  String time = 'loading';

  void setupWorldTime() {
    Navigator.push(context, new MaterialPageRoute(
   builder: (context) => new Home())); // push on top of the loading route 
    //Navigator.pushReplacementNamed(context, '/search'); // will not sit on the stack
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
