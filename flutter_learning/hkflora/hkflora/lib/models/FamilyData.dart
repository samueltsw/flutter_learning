import 'package:hkflora/models/FullFloraData.dart';

class FamilyData {
  FamilyData({
    required this.familyId,
    required this.familyNo,
    required this.familyName,
    required this.chineseFamilyName,
    this.floraOfHKContent,
  });

  final int familyId;
  final String familyNo;
  final String familyName;
  final String chineseFamilyName;
  final FullFlora? floraOfHKContent;

  factory FamilyData.readFromStoredJson(Map<String, dynamic> data) {
    final familyId = data['familyId'];
    final familyNo = data['familyNo'];
    final familyName = data['familyName'];
    final chineseFamilyName = data['chineseFamilyName'];
    final floraOfHKContent =  (data['floraOfHKContent']!= null) ? FullFlora.readFromStoredJson(data['floraOfHKContent']) : null;

    return FamilyData(
        familyId: familyId,
        familyNo: familyNo,
        familyName: familyName,
        chineseFamilyName: chineseFamilyName,
        floraOfHKContent: floraOfHKContent);
  }

  factory FamilyData.fromJson(
      Map<String, dynamic> data, Map<String, dynamic> floradata) {
    final familyId = int.parse(data['family_id']);
    final familyNo = data['family_no'];
    final familyName = data['family_name'];
    final chineseFamilyName = data['family_name_chi'];
    final floraOfHKContent =
        (floradata['eng'].isNotEmpty) ? (FullFlora.fromJson(floradata)): null;

    return FamilyData(
        familyId: familyId,
        familyNo: familyNo,
        familyName: familyName,
        chineseFamilyName: chineseFamilyName,
        floraOfHKContent: floraOfHKContent);
  }
  Map<String, dynamic> toJson() => {
        'familyId': familyId,
        'familyNo': familyNo,
        'familyName': familyName,
        'chineseFamilyName': chineseFamilyName,
        'floraOfHKContent': floraOfHKContent?.toJson()
      };
}