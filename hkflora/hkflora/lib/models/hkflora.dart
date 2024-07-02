import 'dart:convert';
import 'package:flutter/services.dart';

Future<Map<String, dynamic>> loadJsonFromAssets(String filePath) async {
  String jsonString = await rootBundle.loadString(filePath);
  return jsonDecode(jsonString);
}

class FloraDataList {
  FloraDataList({required this.data});

  final List<FloraData> data;

  factory FloraDataList.fromJson(Map<String, dynamic> jsonData) {
    String jsonDataKey = jsonData.keys.elementAt(0);
    return FloraDataList(
        data: (jsonData[jsonDataKey] as List)
            .map((e) => FloraData.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}

class FloraData {
  FloraData({
    required this.speciesId,
    required this.familyId,
    required this.familyNo,
    required this.familyName,
    required this.chineseFamilyName,
    required this.scientificName,
    this.authority,
    this.chineseName1,
    this.chineseName2,
    this.synonym1,
    this.synonym2,
    required this.nativeToHk,
    required this.typeSpecimenCollectedInHk,
    required this.cap96,
    required this.cap586,
    this.chinaPlantRedDataBook,
    this.rareAndPreciousPlantsOfHk,
    this.locality,
    required this.exportToWebsite,
    required this.plantType,
    this.flowerFromValue,
    this.flowerToValue,
    this.fruitFromValue,
    this.fruitToValue,
    this.floraOfHKContent,
  });

  final int? speciesId;
  final int familyId;
  final String familyNo;
  final String familyName;
  final String chineseFamilyName;
  final String scientificName;
  final String? authority;
  final String? chineseName1;
  final String? chineseName2;
  final String? synonym1;
  final String? synonym2;
  final String nativeToHk;
  final String typeSpecimenCollectedInHk;
  final String cap96;
  final String cap586;
  final String? chinaPlantRedDataBook;
  final String? rareAndPreciousPlantsOfHk;
  final String? locality;
  final String exportToWebsite;
  final String plantType;
  final int? flowerFromValue;
  final int? flowerToValue;
  final int? fruitFromValue;
  final int? fruitToValue;
  final String? floraOfHKContent;

  factory FloraData.fromJson(Map<String, dynamic> data) {
    final speciesId = data['Species ID'];
    final familyId = data['Family ID'];
    final familyNo = data['Family No.'];
    final familyName = data['Family Name'];
    final chineseFamilyName = data['Chinese Family Name'];
    final scientificName = data['Scientific Name'];
    final authority = data['Authority'];
    final chineseName1 = data['Chinese Name 1'];
    final chineseName2 = data['Chinese Name 2'];
    final synonym1 = data['Synonym 1'];
    final synonym2 = data['Synonym 2'];
    final nativeToHk = data['Native to HK (Y/N)'];
    final typeSpecimenCollectedInHk = data['Type Specimen Collected in HK'];
    final cap96 = data['Cap. 96'];
    final cap586 = data['Cap. 586'];
    final chinaPlantRedDataBook = data['China Plant Red Data Book'];
    final rareAndPreciousPlantsOfHk =
        data['Rare and Precious Plants of HK (Status in China)'];
    final locality = data['Locality (FOHK English Version)'];
    final exportToWebsite = data['Export to Website'];
    final plantType = data['Plant Type'];
    final flowerFromValue =
        (data['flower_from_value'] is int) ? data['flower_from_value'] : null;
    final flowerToValue =
        (data['flower_to_value'] is int) ? data['flower_to_value'] : null;
    final fruitFromValue =
        (data['fruit_from_value'] is int) ? data['fruit_from_value'] : null;
    final fruitToValue =
        (data['fruit_to_value'] is int) ? data['fruit_to_value'] : null;
    final floraOfHKContent = data['flora_of_hk_content'];

    return FloraData(
        speciesId: speciesId,
        familyId: familyId,
        familyNo: familyNo,
        familyName: familyName,
        chineseFamilyName: chineseFamilyName,
        scientificName: scientificName,
        authority: authority,
        chineseName1: chineseName1,
        chineseName2: chineseName2,
        synonym1: synonym1,
        synonym2: synonym2,
        nativeToHk: nativeToHk,
        typeSpecimenCollectedInHk: typeSpecimenCollectedInHk,
        cap96: cap96,
        cap586: cap586,
        chinaPlantRedDataBook: chinaPlantRedDataBook,
        rareAndPreciousPlantsOfHk: rareAndPreciousPlantsOfHk,
        locality: locality,
        exportToWebsite: exportToWebsite,
        plantType: plantType,
        flowerFromValue: flowerFromValue,
        flowerToValue: flowerToValue,
        fruitFromValue: fruitFromValue,
        fruitToValue: fruitToValue,
        floraOfHKContent: floraOfHKContent);
  }
}
