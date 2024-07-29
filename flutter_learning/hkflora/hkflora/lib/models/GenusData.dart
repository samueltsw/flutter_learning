import 'package:hkflora/models/FullFloraData.dart';

class GenusData {
  GenusData({
    required this.genusId,
    required this.genusName,
    this.genusChineseName,
    this.genusAuthority,
    required this.familyId,
    required this.familyNo,
    required this.familyName,
    required this.chineseFamilyName,
    this.floraOfHKContent,
  });

  final int genusId;
  final String genusName;
  final String? genusChineseName;
  final String? genusAuthority;
  final int familyId;
  final String familyNo;
  final String familyName;
  final String chineseFamilyName;
  final FullFlora? floraOfHKContent;

  factory GenusData.readFromStoredJson(Map<String, dynamic> data) {
    final genusId = data['genusId'];
    final genusName = data['genusName'];
    final genusChineseName = data['genusChineseName'];
    final genusAuthority = data['genusAuthority'];
    final familyId = data['familyId'];
    final familyNo = data['familyNo'];
    final familyName = data['familyName'];
    final chineseFamilyName = data['chineseFamilyName'];
    final floraOfHKContent =  (data['floraOfHKContent']!= null) ? FullFlora.readFromStoredJson(data['floraOfHKContent']) : null;

    return GenusData(
        genusId: genusId,
        genusName: genusName,
        genusChineseName: genusChineseName,
        genusAuthority: genusAuthority,
        familyId: familyId,
        familyNo: familyNo,
        familyName: familyName,
        chineseFamilyName: chineseFamilyName,
        floraOfHKContent: floraOfHKContent);
  }

  factory GenusData.fromJson(
      Map<String, dynamic> data, Map<String, dynamic> floradata) {
    final genusId = int.parse(data['genus_id']);
    final genusName = data['genus_name'];
    final genusChineseName = data['genus_name_chi'];
    final genusAuthority = data['genus_authority'];
    final familyId = int.parse(data['family_id']);
    final familyNo = data['family_no'];
    final familyName = data['family_name'];
    final chineseFamilyName = data['family_name_chi'];
    final floraOfHKContent =
        (floradata['eng'].isNotEmpty) ? (FullFlora.fromJson(floradata)) : null;

    return GenusData(
        genusId: genusId,
        genusName: genusName,
        genusChineseName: genusChineseName,
        genusAuthority: genusAuthority,
        familyId: familyId,
        familyNo: familyNo,
        familyName: familyName,
        chineseFamilyName: chineseFamilyName,
        floraOfHKContent: floraOfHKContent);
  }
  Map<String, dynamic> toJson() => {
        'genusId': genusId,
        'genusName': genusName,
        'genusChineseName': genusChineseName,
        'genusAuthority': genusAuthority,
        'familyId': familyId,
        'familyNo': familyNo,
        'familyName': familyName,
        'chineseFamilyName': chineseFamilyName,
        'floraOfHKContent': floraOfHKContent?.toJson()
      };
}

List<GenusData> sortGenusData(List<GenusData> data) {
  data.sort((a, b) {
    // Compare by familyNo
    int familyNoComparison = a.familyNo.compareTo(b.familyNo);
    if (familyNoComparison != 0) {
      return familyNoComparison;
    }

    // If familyNo is the same, compare by scientificName
    return a.genusName.compareTo(b.genusName);
  });

  return data;
}
