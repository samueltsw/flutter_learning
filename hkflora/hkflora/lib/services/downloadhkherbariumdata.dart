import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:hkflora/models/hkfloraonlinedata.dart';

bool isNotMoreThanSixtyDaysAgo(DateTime? dateTime) {
  if (dateTime == null) {
    return false; // Or handle the null case as desired
  }
  DateTime now = DateTime.now();
  DateTime oneMonthAgo = now.subtract(Duration(days: 60));
  return !dateTime.isBefore(oneMonthAgo);
}

Future<DateTime?> getLastEditDate(String jsonFileName) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/$jsonFileName');
  if (await file.exists()) {
    final stat = await file.stat();
    return stat.modified;
  }
  return null;
}

Future<bool> jsonFileExist(String jsonFileName) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/$jsonFileName');
  return await file.exists();
  }


Future<void> writeJsonToFile(String jsonData,String jsonFileName) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/$jsonFileName');
  await file.writeAsString(jsonData);
}

Future<List<OnlineFloraData>> readJsonFile(String jsonFileName) async {
  try {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/$jsonFileName');
  if (await file.exists()) {
      String jsonData = await file.readAsString();
      List<dynamic> jsonList = json.decode(jsonData);
      List<OnlineFloraData> onlineFloraDataList = jsonList.map((e) => OnlineFloraData.readFromStoredJson(e as Map<String, dynamic>)).toList();
      return onlineFloraDataList;
    } else {
      throw Exception('JSON file not found.');
    }
  } 
  catch (e) {
    throw Exception('Error reading JSON file: $e');
  } 
}
 
// Obtain scientific names from www.herbarium.gov.hk
Future<List<String>> fetchScientificName() async {
  // make the requests
  final httpPackageUrl = Uri.https('www.herbarium.gov.hk',
      '/plantdb/src/UHDMS_prd/js/scientificNameSuggestion.json');
  final httpPackageResponse  = await http.get(httpPackageUrl);
  final decodedResponse = utf8.decode(httpPackageResponse.body.runes.toList());

  if (httpPackageResponse.statusCode == 200) {
    
      final httpPackageJson = json.decode(decodedResponse).cast<String>();  
      return httpPackageJson;
  }
  throw Exception('Failed to fetch the scientific name JSON from the server');
}

// Obtain SID from scientific names from www.herbarium.gov.hk
Future<List<int>> fetchSid(scientificNameList) async {

  // initiate a list of empty sid
  List<int> sidList = [];

  // obtain the sid from the scientific name list
 for (int i = 0; i < 20; i++){
        final httpPackageUrl = Uri.https(
      'www.herbarium.gov.hk',
      '/plantdb/GetSpeciesList.php',
      {'quick_search':scientificNameList[i]});

  //for (String scientificName in scientificNameList){
  //  final httpPackageUrl = Uri.https(
  //    'www.herbarium.gov.hk',
  //    '/plantdb/GetSpeciesList.php',
  //    {'quick_search':scientificName});

    final httpPackageResponse  = await http.get(httpPackageUrl);
    
    if (httpPackageResponse.statusCode == 200) {
      final decodedResponse = utf8.decode(httpPackageResponse.body.runes.toList());
      final httpPackageJson = json.decode(decodedResponse) as Map<String, dynamic>; 
      final currentSid = int.parse(httpPackageJson['records'][0]['species_id']);

      if (!sidList.contains(currentSid)) {
        sidList.add(currentSid);
        //print(currentSid);
      }
  }   else 
  {
    throw Exception('Failed to fetch JSON data from the server');
  }

  }
  //String speciesIDJsonData = json.encode(sidList);
  //await writeJsonToFile(speciesIDJsonData,'SID_HKHerbarium.json');
  return sidList;
}

// Obtain plant details from www.herbarium.gov.hk
Future<List<OnlineFloraData>> fetchPlantDetails(sidList) async {

  List<OnlineFloraData> onlineFloraDataList = [];

  // make the request
  //for (int i = 0; i < 50; i++){
   //     final plantInfoPackageUrl = Uri.https(
   //   'www.herbarium.gov.hk',
   //   '/plantdb/GetSpecies.php',
   //   {'id': '${sidList[i]}'});

        //final hkFloraPackageUrl = Uri.https(
      //'www.herbarium.gov.hk',
      //'/plantdb/GetFloraOfHk.php',
      //{'id':'${sidList[i]}',
      //'parent_type':'species'});

  for (int sid in sidList){
    final plantInfoPackageUrl = Uri.https(
      'www.herbarium.gov.hk',
      '/plantdb/GetSpecies.php',
      {'id':'$sid'});

    final hkFloraPackageUrl = Uri.https(
      'www.herbarium.gov.hk',
      '/plantdb/GetFloraOfHk.php',
      {'id':'$sid',
      'parent_type':'species'});

    final plantInfoPackageResponse  = await http.get(plantInfoPackageUrl);
    final hkFloraPackageResponse  = await http.get(hkFloraPackageUrl);

    if (plantInfoPackageResponse.statusCode == 200) {
      final plantInfodecodedResponse = utf8.decode(plantInfoPackageResponse.body.runes.toList());
      final plantInfoPackageJson = json.decode(plantInfodecodedResponse) as Map<String, dynamic>; 
      final hkFloradecodedResponse = utf8.decode(hkFloraPackageResponse.body.runes.toList());
      final hkFloraPackageJson = json.decode(hkFloradecodedResponse) as Map<String, dynamic>; 
      var onlineFloraData = OnlineFloraData.fromJson(plantInfoPackageJson,hkFloraPackageJson);
      onlineFloraDataList.add(onlineFloraData);
      print('added flora data for ${onlineFloraData.scientificName}');
      }
 else 
  {
    throw Exception('Failed to fetch JSON data from the server');
  }
    
  }
  
  List<Map<String, dynamic>> jsonList = onlineFloraDataList.map((item) => item.toJson()).toList();
  String onlineFloraDataJsonData = json.encode(jsonList);
  await writeJsonToFile(onlineFloraDataJsonData,'floraData_HKHerbarium.json');
  return onlineFloraDataList;
}
