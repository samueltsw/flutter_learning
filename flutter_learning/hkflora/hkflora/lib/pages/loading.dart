import 'package:flutter/material.dart';
import 'package:hkflora/models/FamilyData.dart';
import 'package:hkflora/models/GenusData.dart';
import 'package:hkflora/pages/home.dart';
import 'package:hkflora/services/downloadhkherbariumdata.dart';
import 'package:hkflora/models/SpeciesData.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin {
  String linearProgressText = 'Downloading Data from Hong Kong Herbarium';
  double progressValue = 0.0;

/*   void readJsonData() async {
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
  } */

  Future<void> downloadHerbariumData() async {
    if (!await jsonFileExist('speciesData_HKHerbarium.json') || !await jsonFileExist('genusData_HKHerbarium.json')  || !await jsonFileExist('familyData_HKHerbarium.json') ||
        !isNotMoreThanSixtyDaysAgo(await getLastEditDate('speciesData_HKHerbarium.json')) || !isNotMoreThanSixtyDaysAgo(await getLastEditDate('genusData_HKHerbarium.json')) || !isNotMoreThanSixtyDaysAgo(await getLastEditDate('familyData_HKHerbarium.json'))
        ) {
      try {
        // Check whether the json file exist
        setState(() {
          linearProgressText = 'Stage 1/5: Fetching Scientific Names';
        });
        final scientificNames = await fetchScientificName();
        setState(() {
          progressValue = 0.1;
        });
        //print(scientificNames);
        if (scientificNames.isNotEmpty) {
          final (sidList, gidList, fidList) = await fetchSid(scientificNames, (progress) {
            setState(() {
              linearProgressText = 'Stage 2/5: Fetching Species ID (${(progress * scientificNames.length).toInt()}/${scientificNames.length})';
              progressValue = 0.1 +
                  (0.1 * progress); // Adjust the progress calculation as needed
            });
          });
          await fetchSpeciesDetails(sidList, (progress) {
            setState(() {
              linearProgressText = 'Stage 3/5:Fetching Species Details (${(progress * sidList.length).toInt()}/${sidList.length})';
              progressValue = 0.2 +
                  (0.4 * progress); // Adjust the progress calculation as needed
            });
          });
          await fetchGenusDetails(gidList, (progress) {
            setState(() {
              linearProgressText = 'Stage 4/5:Fetching Genus Details (${(progress * gidList.length).toInt()}/${gidList.length})';
              progressValue = 0.6 +
                  (0.2 * progress); // Adjust the progress calculation as needed
            });
          });          
          await fetchFamilyDetails(fidList, (progress) {
            setState(() {
              linearProgressText = 'Stage 5/5:Fetching Family Details (${(progress * fidList.length).toInt()}/${fidList.length})';
              progressValue = 0.8 +
                  (0.2 * progress); // Adjust the progress calculation as needed
            });
          });

          //print(sidList.length);
          //print(hkPlantData);
        } else {
          //print('No scientific names found.');
        }
      } catch (e) {
        throw Exception('Error downloading data: $e');
        //print('Error: $e');
      } 
    }
  }

  Future<void> readDownloadedJsonData() async {
    List<SpeciesData> speciesDataList =
        await readJsonFile('speciesData_HKHerbarium.json');
    List<GenusData> genusDataList =
        await readJsonFile('genusData_HKHerbarium.json');
    List<FamilyData> familyDataList =
        await readJsonFile('familyData_HKHerbarium.json');

  
    if (!context.mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Home(
            speciesDataList: speciesDataList,
            genusDataList: genusDataList,
            familyDataList: familyDataList,
        ),
      ),
    );
  }

  Future<void> loadData() async {
    await downloadHerbariumData();
    await readDownloadedJsonData();
  }

  @override
  void initState() {
    super.initState(); //run the original function we originally riding on

    loadData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.blue,
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            linearProgressText,
            style: const TextStyle(fontSize: 15),
          ),
          const SizedBox(height: 30),
          LinearProgressIndicator(
            value: progressValue,
            semanticsLabel: 'Downloading Data',
          ),
          const SizedBox(height: 10),
        ],
      ),
    )
        /*   child: SpinKitRing(
          color: Colors.white,
          size: 50.0,
        ) */
        );
  }
}
