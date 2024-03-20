import 'package:flutter/material.dart';
import 'package:world_time/pages/home.dart';
import 'package:world_time/pages/loading.dart';
import 'package:world_time/pages/choose_location.dart';
//import './pages/home.dart'


void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => Loading(), // '/' = base route
    '/home': (context) => Home(),
    '/location': (context) => ChooseLocation(),
  },
));
