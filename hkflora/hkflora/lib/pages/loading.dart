import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hkflora/models/hkflora.dart';
import 'package:hkflora/pages/home.dart';
import 'package:hkflora/services/downloadhkherbariumdata.dart';
import 'package:hkflora/models/hkfloraonlinedata.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String time = 'loading';

  void readJsonData() async {
    Map<String, dynamic> jsonData =
        await loadJsonFromAssets('assets/PlantInfo_HKHerbarium_20240614.json');
    var floraDataList = FloraDataList.fromJson(jsonData);

    if (!context.mounted) return;
    //Navigator.pushReplacementNamed(context, '/home',arguments: floradatalist); // will not sit on the stack
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Home(
          floraDataList: floraDataList,
        ),
      ),
    );
  }

   void readDownloadedJsonData() async {
    List<OnlineFloraData> onlineFloraDataList = await readJsonFile('floraData_HKHerbarium.json');
    print('complete reading downloaded json data');
  }
  
 
  void downloadHerbariumData() async {
    if (!await jsonFileExist('floraData_HKHerbarium.json') ||
        !isNotMoreThanSixtyDaysAgo(
            await getLastEditDate('floraData_HKHerbarium.json'))) {
      try {
        // Check whether the json file exist
        final scientificNames = await fetchScientificName();
        //print(scientificNames);
        if (scientificNames.isNotEmpty) {
          final sidList = await fetchSid(scientificNames);
          fetchPlantDetails(sidList);
          //print(sidList.length);
          //print(hkPlantData);
        } else {
          print('No scientific names found.');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState(); //run the original function we originally riding on
    //readJsonData();
    downloadHerbariumData();
    readDownloadedJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
            child: SpinKitRing(
          color: Colors.white,
          size: 50.0,
        )));
  }
}
