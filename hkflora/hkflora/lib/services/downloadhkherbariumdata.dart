import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:hkflora/models/SpeciesData.dart';
import 'package:hkflora/models/GenusData.dart';
import 'package:hkflora/models/FamilyData.dart';
import 'package:http/retry.dart';

bool isNotMoreThanSixtyDaysAgo(DateTime? dateTime) {
  if (dateTime == null) return false;
  return DateTime.now().difference(dateTime).inDays <= 60;
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

Future<void> writeJsonToFile(String jsonData, String jsonFileName) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/$jsonFileName');
  await file.writeAsString(jsonData);
}

Future<List<T>> readJsonFile<T>(String jsonFileName) async {
 /*  try { */
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/$jsonFileName');
    if (await file.exists()) {
      String jsonData = await file.readAsString();
      List<dynamic> jsonList = json.decode(jsonData);
      
      switch (T) {
        case SpeciesData:
          return jsonList.map((e) => SpeciesData.readFromStoredJson(e as Map<String, dynamic>) as T).toList();
        case GenusData:
          return jsonList.map((e) => GenusData.readFromStoredJson(e as Map<String, dynamic>) as T).toList();
        case FamilyData:
          return jsonList.map((e) => FamilyData.readFromStoredJson(e as Map<String, dynamic>) as T).toList();
        default:
          throw Exception('Unsupported type: $T');
      }
    } else {
      throw Exception('JSON file not found: $jsonFileName');
    }
  } /* catch (e) {
    throw Exception('Error reading JSON file $jsonFileName: $e');
  }
} */

// Obtain scientific names from www.herbarium.gov.hk
Future<List<String>> fetchScientificName() async {
  // make the requests
  final httpPackageUrl = Uri.https('www.herbarium.gov.hk',
      '/plantdb/src/UHDMS_prd/js/scientificNameSuggestion.json');
  final httpPackageResponse = await http.get(httpPackageUrl);
  final decodedResponse = utf8.decode(httpPackageResponse.body.runes.toList());

  if (httpPackageResponse.statusCode == 200) {
    final httpPackageJson = json.decode(decodedResponse).cast<String>();
    return httpPackageJson;
  }
  throw Exception('Failed to fetch the scientific name JSON from the server');
}

// Obtain SID from scientific names from www.herbarium.gov.hk
Future<(List<int>, List<int>, List<int>)> fetchSid(
    scientificNameList, Function(double) updateProgress) async {
  // initiate a list of empty sid, gid, and fid
  Set<int> sidSet = {}, gidSet = {}, fidSet = {};
  int noRequest = 0;

  // obtain the sid from the scientific name list

  final client = RetryClient(http.Client());
  try {
/*       for (int i = 0; i < 50; i++){
        final httpPackageUrl = Uri.https(
      'www.herbarium.gov.hk',
      '/plantdb/GetSpeciesList.php',
      {'quick_search':scientificNameList[i]}); */
    for (String scientificName in scientificNameList) {
      final httpPackageUrl = Uri.https('www.herbarium.gov.hk',
          '/plantdb/GetSpeciesList.php', {'quick_search': scientificName});

      final httpPackageResponse = await client.get(httpPackageUrl);
      final progress = noRequest / scientificNameList.length;
      updateProgress(progress);

      noRequest += 1;

      if (httpPackageResponse.statusCode == 200) {
        final decodedResponse =
            utf8.decode(httpPackageResponse.body.runes.toList());
        final httpPackageJson =
            json.decode(decodedResponse) as Map<String, dynamic>;
        final recordCount = httpPackageJson['record_count'];
        for (int i = 0; i < recordCount; i++) {
          sidSet.add(int.parse(httpPackageJson['records'][i]['species_id']));
          gidSet.add(int.parse(httpPackageJson['records'][i]['genus_id']));
          fidSet.add(int.parse(httpPackageJson['records'][i]['family_id']));
        }
      } else {
        throw Exception('Failed to fetch JSON data from the server');
      }
    }
  } finally {
    //print("length of SID: ${sidList.length}");
    client.close();
  }

  //String speciesIDJsonData = json.encode(sidList);
  //await writeJsonToFile(speciesIDJsonData,'SID_HKHerbarium.json');
  return (sidSet.toList(), gidSet.toList(), fidSet.toList());
}

// Obtain plant details from www.herbarium.gov.hk
Future<List<T>> fetchDetails<T>(List<int> idList, String endpoint, String parentType, T Function(Map<String, dynamic>, Map<String, dynamic>) fromJson, Function(double) updateProgress) async {
  List<T> dataList = [];
  final client = RetryClient(http.Client());

  try {
    for (int i = 0; i < idList.length; i++) {
      final id = idList[i];
      final infoUrl = Uri.https('www.herbarium.gov.hk', '/plantdb/$endpoint.php', {'id': '$id'});
      final floraUrl = Uri.https('www.herbarium.gov.hk', '/plantdb/GetFloraOfHk.php', {'id': '$id', 'parent_type': parentType});

      final infoResponse = await client.get(infoUrl);
      final floraResponse = await client.get(floraUrl);
      updateProgress(i / idList.length);

      if (infoResponse.statusCode == 200 && floraResponse.statusCode == 200) {
        final infoJson = json.decode(utf8.decode(infoResponse.body.runes.toList()));
        final floraJson = json.decode(utf8.decode(floraResponse.body.runes.toList()));
        dataList.add(fromJson(infoJson, floraJson));
      } else {
        throw Exception('Failed to fetch JSON data from the server');
      }
    }
  } finally {
    client.close();
  }

  return dataList;
}

Future<List<SpeciesData>> fetchSpeciesDetails(List<int> sidList, Function(double) updateProgress) async {
  final speciesDataList = await fetchDetails(sidList, 'GetSpecies', 'species', SpeciesData.fromJson, updateProgress);
  await writeJsonToFile(json.encode(speciesDataList.map((item) => item.toJson()).toList()), 'speciesData_HKHerbarium.json');
  return speciesDataList;
}

Future<List<GenusData>> fetchGenusDetails(List<int> gidList, Function(double) updateProgress) async {
  final genusDataList = await fetchDetails(gidList, 'GetGenus', 'genus', GenusData.fromJson, updateProgress);
  await writeJsonToFile(json.encode(genusDataList.map((item) => item.toJson()).toList()), 'genusData_HKHerbarium.json');
  return genusDataList;
}

Future<List<FamilyData>> fetchFamilyDetails(List<int> fidList, Function(double) updateProgress) async {
  final familyDataList = await fetchDetails(fidList, 'GetFamily', 'family', FamilyData.fromJson, updateProgress);
  await writeJsonToFile(json.encode(familyDataList.map((item) => item.toJson()).toList()), 'familyData_HKHerbarium.json');
  return familyDataList;
}