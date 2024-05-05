import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context)  {
    //data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
    //print(data);
    //printJsonData();

return Scaffold(
      appBar: AppBar(
        title: Text('Hong Kong Flora'),
        backgroundColor: Colors.yellow[100]
        )
        );
  }
}

Future<Map<String, dynamic>> loadJsonFromAssets(String filePath) async {
  String jsonString = await rootBundle.loadString(filePath);
  return jsonDecode(jsonString);
}

void printJsonData() async {
    Map<String, dynamic> jsonData = await loadJsonFromAssets('PlantInfo_HKHerbarium.json');
    print(jsonData);
}