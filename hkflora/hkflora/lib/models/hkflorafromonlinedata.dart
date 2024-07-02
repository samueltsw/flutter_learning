class OnlineFloraData {
  
  OnlineFloraData({
    required this.speciesId,
    required this.familyId,
    required this.familyNo,
    required this.familyName,
    required this.chineseFamilyName,
    required this.scientificName,
    this.authority,
    this.chineseName1,
    this.chineseName2,
    this.chineseName3,
    this.synonym1,
    this.synonym2,
    required this.nativeToHk,
    required this.typeSpecimenCollectedInHk,
    required this.cap96,
    required this.cap586,
    this.chinaPlantRedDataBook,
    this.rareAndPreciousPlantsOfHk,
    this.locality,
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
  final String? chineseName3;
  final String? synonym1;
  final String? synonym2;
  final String nativeToHk;
  final String typeSpecimenCollectedInHk;
  final String cap96;
  final String cap586;
  final String? chinaPlantRedDataBook;
  final String? rareAndPreciousPlantsOfHk;
  final String? locality;
  final String plantType;
  final int? flowerFromValue;
  final int? flowerToValue;
  final int? fruitFromValue;
  final int? fruitToValue;
  final String? floraOfHKContent;

  factory OnlineFloraData.readFromStoredJson(Map<String, dynamic> data){
        final speciesId =  data['speciesId'];
        final familyId =  data['familyId'];
        final familyNo = data['familyNo'];
        final familyName = data['familyName'];
        final chineseFamilyName = data['chineseFamilyName'];
        final scientificName = data['scientificName'];
        final authority = data['authority'];
        final chineseName1 = data['chineseName1'];
        final chineseName2 = data['chineseName2'];
        final chineseName3 = data['chineseName3'];
        final synonym1 = data['synonym1'];
        final synonym2 = data['synonym2'];
        final nativeToHk = data['nativeToHk'];
        final typeSpecimenCollectedInHk = data['typeSpecimenCollectedInHk'];
        final cap96 = data['cap96'];
        final cap586 = data['cap586'];
        final chinaPlantRedDataBook = data['chinaPlantRedDataBook'];
        final rareAndPreciousPlantsOfHk = data['rareAndPreciousPlantsOfHk'];
        final locality = data['locality'];
        final plantType = data['plantType'];
        final flowerFromValue = data['flowerFromValue'];
        final flowerToValue = data['flowerToValue'];
        final fruitFromValue = data['fruitFromValue'];
        final fruitToValue = data['fruitToValue'];
        final floraOfHKContent = data['floraOfHKContent'];
     
      return OnlineFloraData(
        speciesId: speciesId,
        familyId: familyId,
        familyNo: familyNo,
        familyName: familyName,
        chineseFamilyName: chineseFamilyName,
        scientificName: scientificName,
        authority: authority,
        chineseName1: chineseName1,
        chineseName2: chineseName2,
        chineseName3: chineseName3,
        synonym1: synonym1,
        synonym2: synonym2,
        nativeToHk: nativeToHk,
        typeSpecimenCollectedInHk: typeSpecimenCollectedInHk,
        cap96: cap96,
        cap586: cap586,
        chinaPlantRedDataBook: chinaPlantRedDataBook,
        rareAndPreciousPlantsOfHk: rareAndPreciousPlantsOfHk,
        locality: locality,
        plantType: plantType,
        flowerFromValue: flowerFromValue,
        flowerToValue: flowerToValue,
        fruitFromValue: fruitFromValue,
        fruitToValue: fruitToValue,
        floraOfHKContent: floraOfHKContent);

  }
  
  factory OnlineFloraData.fromJson(Map<String, dynamic> data, Map<String, dynamic> floradata) {
    final speciesId = int.parse(data['id']);
    final familyId = int.parse(data['family_id']);
    final familyNo = data['family_no'];
    final familyName = data['family_name'];
    final chineseFamilyName = data['family_name_chi'];
    final scientificName = data['scientific_name'][0];
    final authority = data['species_authority'];
    final chineseName1 = 
      (data['chinese_name'].length > 0)? data['chinese_name'][0] : null;
    final chineseName2 = 
        (data['chinese_name'].length > 1)? data['chinese_name'][1] : null;
    final chineseName3 = 
        (data['chinese_name'].length > 2)? data['chinese_name'][2] : null;
    final synonym1 = 
      (data['scientific_name'].length > 2)? data['scientific_name'][1] : null;
    final synonym2 = 
      (data['scientific_name'].length > 3)? data['scientific_name'][2] : null;
    final nativeToHk = data['native'];
    final typeSpecimenCollectedInHk = data['type_specimen_in_hk'];
    final cap96 = data['cap96'];
    final cap586 = data['cap586'];
    final chinaPlantRedDataBook = data['china_plant_red_data'];
    final rareAndPreciousPlantsOfHk =
        data['rare_plant_china'];
    final locality = data['locality_eng'];
    final plantType = data['plant_type_eng'];
    final flowerFromValue =
        (data['flower_period'].isNotEmpty) ? data['flower_period'][0]['from_value'] : null;
    final flowerToValue =
        (data['flower_period'].isNotEmpty) ? data['flower_period'][0]['to_value']  : null;
    final fruitFromValue =
        (data['fruit_period'].isNotEmpty) ? data['fruit_period'][0]['from_value'] : null;
    final fruitToValue =
        (data['fruit_period'].isNotEmpty) ? data['fruit_period'][0]['to_value'] : null;
    final floraOfHKContent = 
        (floradata['eng'].isNotEmpty) ? floradata['eng'][0]['content'] : null;

    return OnlineFloraData(
        speciesId: speciesId,
        familyId: familyId,
        familyNo: familyNo,
        familyName: familyName,
        chineseFamilyName: chineseFamilyName,
        scientificName: scientificName,
        authority: authority,
        chineseName1: chineseName1,
        chineseName2: chineseName2,
        chineseName3: chineseName3,
        synonym1: synonym1,
        synonym2: synonym2,
        nativeToHk: nativeToHk,
        typeSpecimenCollectedInHk: typeSpecimenCollectedInHk,
        cap96: cap96,
        cap586: cap586,
        chinaPlantRedDataBook: chinaPlantRedDataBook,
        rareAndPreciousPlantsOfHk: rareAndPreciousPlantsOfHk,
        locality: locality,
        plantType: plantType,
        flowerFromValue: flowerFromValue,
        flowerToValue: flowerToValue,
        fruitFromValue: fruitFromValue,
        fruitToValue: fruitToValue,
        floraOfHKContent: floraOfHKContent);

  }
    Map<String, dynamic> toJson() => {
        'speciesId': speciesId,
        'familyId': familyId,
        'familyNo': familyNo,
        'familyName': familyName,
        'chineseFamilyName': chineseFamilyName,
        'scientificName': scientificName,
        'authority': authority,
        'chineseName1': chineseName1,
        'chineseName2': chineseName2,
        'chineseName3': chineseName3,
        'synonym1': synonym1,
        'synonym2': synonym2,
        'nativeToHk': nativeToHk,
        'typeSpecimenCollectedInHk': typeSpecimenCollectedInHk,
        'cap96': cap96,
        'cap586': cap586,
        'chinaPlantRedDataBook': chinaPlantRedDataBook,
        'rareAndPreciousPlantsOfHk': rareAndPreciousPlantsOfHk,
        'locality': locality,
        'plantType': plantType,
        'flowerFromValue': flowerFromValue,
        'flowerToValue': flowerToValue,
        'fruitFromValue': fruitFromValue,
        'fruitToValue': fruitToValue,
        'floraOfHKContent': floraOfHKContent};  
}

