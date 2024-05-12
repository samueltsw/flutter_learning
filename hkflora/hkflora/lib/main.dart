import 'package:flutter/material.dart';
import 'package:hkflora/pages/loading.dart';


void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/',
  routes: {
    '/': (context) => const Loading(), // '/' = base route
  },
));
