import 'package:hkflora/models/SpeciesData.dart';
import 'package:hkflora/models/GenusData.dart';
import 'package:hkflora/models/FamilyData.dart';

class TaxonomicUnit {
  final String type; // 'species', 'genus', or 'family'
  final dynamic data; // SpeciesData, GenusData, or FamilyData object

  TaxonomicUnit(this.type, this.data);

  String getFamilyNo() {
    switch (type) {
      case 'family':
        return (data as FamilyData).familyNo;
      case 'genus':
        return (data as GenusData).familyNo;
      case 'species':
        return (data as SpeciesData).familyNo;
      default:
        return '';
    }
  }

  String getName() {
    switch (type) {
      case 'family':
        return (data as FamilyData).familyName;
      case 'genus':
        return (data as GenusData).genusName;
      case 'species':
        return (data as SpeciesData).scientificName;
      default:
        return '';
    }
  }

  int getSortPriority() {
    switch (type) {
      case 'family':
        return 0;
      case 'genus':
        return 1;
      case 'species':
        return 1;
      default:
        return 2;
    }
  }
}

