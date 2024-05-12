import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hkflora/services/hkflora.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  String time = 'loading';


    void readJsonData() async {
      Map<String, dynamic> jsonData = await loadJsonFromAssets('assets/PlantInfo_HKHerbarium.json');
      var floradatalist = FloraDataList.fromJson(jsonData);

      if (!context.mounted) return;
      Navigator.pushReplacementNamed(context, '/home',arguments: floradatalist); // will not sit on the stack
    }


  @override
  void initState() {
    super.initState(); //run the original function we originally riding on
    readJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
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
