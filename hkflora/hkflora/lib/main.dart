import 'package:flutter/material.dart';
import 'package:hkflora/pages/home.dart';
import 'package:hkflora/pages/loading.dart';


void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => const Loading(), // '/' = base route
    '/home': (context) => const Home(),
  },
));
