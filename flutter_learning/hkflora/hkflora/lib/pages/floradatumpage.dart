import 'package:flutter/material.dart';
import 'package:hkflora/models/TaxonomicUnit.dart';
import 'package:hkflora/models/SpeciesData.dart';
import 'package:hkflora/models/GenusData.dart';
import 'package:hkflora/models/FamilyData.dart';
import 'package:hkflora/models/FullFloraData.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hkflora/theme.dart';

class PlantDataPage extends StatelessWidget {
  final TaxonomicUnit taxonomicUnit;

  const PlantDataPage({
    Key? key,
    required this.taxonomicUnit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: const MaterialTheme(TextTheme()).light(),
      darkTheme: const MaterialTheme(TextTheme()).dark(),
      highContrastDarkTheme:
          const MaterialTheme(TextTheme()).darkHighContrast(),
      highContrastTheme: const MaterialTheme(TextTheme()).lightHighContrast(),
      themeMode: ThemeMode.light,
      home: SelectionArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              _getPageTitle(),
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              _buildHeader(),
              _buildExternalLinks(),
              _buildInfoSections(),
              _buildFloraOfHongKongSection(),
            ],
          ),
        ),
      ),
    );
  }

  String _getPageTitle() {
    if (taxonomicUnit.data is SpeciesData) return 'Species Information';
    if (taxonomicUnit.data is GenusData) return 'Genus Information';
    if (taxonomicUnit.data is FamilyData) return 'Family Information';
    return 'Plant Information';
  }

  Widget _buildHeader() {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.lightGreen.shade50,
              backgroundImage:
                  const AssetImage('assets/images/floradatumpage_card.png'),
              radius: 20,
            ),
            const SizedBox(height: 5),
            Text(
              _getMainTitle(),
              style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
              Text(
                _getChineseNames(),
                style: const TextStyle(fontSize: 20),
              ),
            Text(
              _getSubtitle(),
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  String _getMainTitle() {
    if (taxonomicUnit.data is SpeciesData)
      return (taxonomicUnit.data as SpeciesData).scientificName;
    if (taxonomicUnit.data is GenusData)
      return (taxonomicUnit.data as GenusData).genusName;
    if (taxonomicUnit.data is FamilyData)
      return (taxonomicUnit.data as FamilyData).familyName;
    return '';
  }

  String _getChineseNames() {
    if (taxonomicUnit.data is SpeciesData){
      final species = taxonomicUnit.data as SpeciesData;
      return [species.chineseName1, species.chineseName2, species.chineseName3]
        .where((name) => name != null && name.isNotEmpty)
        .join('、');
    }
    if (taxonomicUnit.data is GenusData){
      return [(taxonomicUnit.data as GenusData).genusChineseName].where((name) => name != null && name.isNotEmpty).join('');
    }
    if (taxonomicUnit.data is FamilyData){
      return [(taxonomicUnit.data as FamilyData).chineseFamilyName].where((name) => name.isNotEmpty).join('');
    }
    return '';
  }

  String _getSubtitle() {
    if (taxonomicUnit.data is SpeciesData) {
      final species = taxonomicUnit.data as SpeciesData;
      return '${species.familyNo} ${species.familyName} ${species.chineseFamilyName}';
    }
    if (taxonomicUnit.data is GenusData) {
      final genus = taxonomicUnit.data as GenusData;
      return '${genus.familyNo} ${genus.familyName} ${genus.chineseFamilyName}';
    }
    if (taxonomicUnit.data is FamilyData) {
      final family = taxonomicUnit.data as FamilyData;
      return '${family.familyNo} ${family.familyName} ${family.chineseFamilyName}';
    }
    return '';
  }

  Widget _buildExternalLinks() {
    // Implement external links based on the type of taxonomicUnit
    String getKeyword() {
      switch (taxonomicUnit.type) {
        case 'family':
          return (taxonomicUnit.data as FamilyData).familyName;
        case 'genus':
          return (taxonomicUnit.data as GenusData).genusName;
        case 'species':
          return (taxonomicUnit.data as SpeciesData).scientificName;
        default:
          return '';
      }
    }

    String getHKHLink(){
            switch (taxonomicUnit.type) {
        case 'family':
          return 'family&oID=${(taxonomicUnit.data as FamilyData).familyId}';
        case 'genus':
          return 'genus&oID=${(taxonomicUnit.data as GenusData).genusId}';
        case 'species':
          return 'species&oID=${(taxonomicUnit.data as SpeciesData).speciesId}';
        default:
          return '';
      }
    }

    Widget _buildResourceButton({required String label, required String url}) {
      return Expanded(
        child: OutlinedButton(
          onPressed: () {
            _launchURL(Uri.parse(url));
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(15),
          ),
          child: Text(label, style: const TextStyle(fontSize: 14.0)),
        ),
      );
    }

    final buttons = [
      _buildResourceButton(
        label: 'HKH',
        url:
            'https://www.herbarium.gov.hk/en/hk-plant-database/plant-detail/index.html?pType=${getHKHLink()}',
      ),
      const SizedBox(width: 5),  // Spacing between buttons
      _buildResourceButton(
        label: 'HKCWW',
        url:
            'https://hkcww.org/hkplant/readdb_photo_v7.php?f1=${getKeyword()}&f2=any&f2b=apg&f3=any&f4=any&f5=any&f6=any&f7=any&f8=any&f8a=any&f8b=any&f9=any&f10=any&f11=any',
      ),
      const SizedBox(width: 5),  // Spacing between buttons
      _buildResourceButton(
        label: 'iPlant.cn',
        url: 'https://www.iplant.cn/info/${getKeyword()}?t=z',
      ),
      const SizedBox(width: 5),  // Spacing between buttons
      _buildResourceButton(
        label: 'POWO',
        url: 'https://powo.science.kew.org/results?q=${getKeyword()}',
      ),
    ];

    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: buttons
        ));
  }

  Widget _buildInfoSections() {
    if (taxonomicUnit.data is SpeciesData) {
      return Column(
        children: [
          _buildTwoColumnSection(
            title: 'Basic Information',
            iconImage: 'assets/images/floradatumpage_table.png',
            children: _getSpeciesBasicInfo(),
          ),
          _buildTwoColumnSection(
            title: 'Ecological Information',
            iconImage: 'assets/images/floradatumpage_table.png',
            children: _getSpeciesEcologicalInfo(),
          ),
          _buildTwoColumnSection(
            title: 'Conservation Status',
            iconImage: 'assets/images/floradatumpage_table.png',
            children: _getSpeciesConservationStatus(),
          ),
          _buildTwoColumnSection(
            title: 'Flower & Fruit',
            iconImage: 'assets/images/floradatumpage_table.png',
            children: _getSpeciesFlowerFruitInfo(),
          ),
          _buildTwoColumnSection(
            title: 'Other',
            iconImage: 'assets/images/floradatumpage_table.png',
            children: _getSpeciesOtherInfo(),
          ),
        ],
      );
    } else if (taxonomicUnit is GenusData) {
      return Column(
        children: [
          _buildTwoColumnSection(
            title: 'Genus Information',
            iconImage: 'assets/images/floradatumpage_table.png',
            children: _getGenusInfo(),
          ),
        ],
      );
    } else if (taxonomicUnit is FamilyData) {
      return Column(
        children: [
          _buildTwoColumnSection(
            title: 'Family Information',
            iconImage: 'assets/images/floradatumpage_table.png',
            children: _getFamilyInfo(),
          ),
        ],
      );
    }
    return Container();
  }

  List<TableRow> _getSpeciesBasicInfo() {
    final species = taxonomicUnit.data as SpeciesData;
    return [
      _buildTableRow(label: 'Common Name', value: [
        species.commonName1,
        species.commonName2,
        species.commonName3
      ]),
      _buildTableRow(
          label: 'Synonym', value: [species.synonym1, species.synonym2]),
      _buildTableRow(label: 'Plant Type', value: [species.plantType]),
    ].whereType<TableRow>().toList();
  }

  List<TableRow> _getSpeciesEcologicalInfo() {
    final species = taxonomicUnit.data as SpeciesData;
    return [
      _buildTableRow(label: 'Native', value: [species.nativeToHk]),
    ].whereType<TableRow>().toList();
  }

  List<TableRow> _getSpeciesConservationStatus() {
    final species = taxonomicUnit.data as SpeciesData;
    return [
      _buildTableRow(label: 'Cap. 96', value: [species.cap96]),
      _buildTableRow(label: 'Cap. 586', value: [species.cap586]),
      _buildTableRow(
          label: 'Rare and Precious Plants of Hong Kong',
          value: [species.rareAndPreciousPlantsOfHk]),
      _buildTableRow(
          label: 'Plant Red Data Book', value: [species.chinaPlantRedDataBook]),
    ].whereType<TableRow>().toList();
  }

  List<TableRow> _getSpeciesFlowerFruitInfo() {
    final species = taxonomicUnit.data as SpeciesData;
    return [
      _buildTableRow(
          label: 'Flowering Period',
          value: ['${species.flowerFromValue} - ${species.flowerToValue}']),
      _buildTableRow(
          label: 'Fruiting Period',
          value: ['${species.fruitFromValue} - ${species.fruitToValue}']),
    ].whereType<TableRow>().toList();
  }

  List<TableRow> _getSpeciesOtherInfo() {
    final species = taxonomicUnit.data as SpeciesData;
    return [
      _buildTableRow(
          label: 'Type Specimen Collected in Hong Kong',
          value: [species.typeSpecimenCollectedInHk]),
    ].whereType<TableRow>().toList();
  }

  List<TableRow> _getGenusInfo() {
    final genus = taxonomicUnit as GenusData;
    return [
      _buildTableRow(label: 'Genus ID', value: [genus.genusId.toString()]),
      _buildTableRow(label: 'Genus Name', value: [genus.genusName]),
      _buildTableRow(
          label: 'Chinese Genus Name', value: [genus.genusChineseName]),
      _buildTableRow(label: 'Family No', value: [genus.familyNo]),
      _buildTableRow(label: 'Family Name', value: [genus.familyName]),
      _buildTableRow(
          label: 'Chinese Family Name', value: [genus.chineseFamilyName]),
    ].whereType<TableRow>().toList();
  }

  List<TableRow> _getFamilyInfo() {
    final family = taxonomicUnit as FamilyData;
    return [
      _buildTableRow(label: 'Family ID', value: [family.familyId.toString()]),
      _buildTableRow(label: 'Family No', value: [family.familyNo]),
      _buildTableRow(label: 'Family', value: [family.familyName]),
      _buildTableRow(
          label: 'Chinese Family', value: [family.chineseFamilyName]),
    ].whereType<TableRow>().toList();
  }



Widget _buildFloraOfHongKongSection() {
    FullFlora? _getFloraOfHK() {
    if (taxonomicUnit.data is SpeciesData) return (taxonomicUnit.data as SpeciesData).floraOfHKContent;
    if (taxonomicUnit.data is GenusData) return (taxonomicUnit.data as GenusData).floraOfHKContent;
    if (taxonomicUnit.data is FamilyData) return (taxonomicUnit.data as FamilyData).floraOfHKContent;
    return null;
  }

    final floraData = _getFloraOfHK();
    if (floraData != null) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
            child: Row(
              children: [
                const ImageIcon(AssetImage('assets/images/floradatumpage_table.png')),
                Text(
                  ' Flora of Hong Kong',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.lightGreen[900]),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
            child: _buildFullFloraContent(floraData),
          ),
        ],
      );
    }
    return Container();
  }
}

Widget _buildFullFloraContent(FullFlora fullFlora) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: fullFlora.engItems.map((item) {
      if (item.type == 'paragraph') {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: HtmlWidget(
            item.content,
            textStyle: const TextStyle(fontSize: 17),
          ),
        );
      } else if (item.type == 'table') {
        return _buildFloraTable(item);
      } else {
        return Container(); // Handle other types if needed
      }
    }).toList(),
  );
}

Widget _buildFloraTable(FloraItem item) {
  if (item.table == null || item.table!.isEmpty) {
    return Container();
  }
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Table(
      columnWidths: const {
        0: FlexColumnWidth(0.7),
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(1),
      },
      children: item.table!.map((tableItem) {
        // Extract the part after the last underscore        
        return TableRow(
          children: [
            // Column 1: Index part
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: HtmlWidget(
                  tableItem.index,
                  textStyle: const TextStyle(fontSize: 17),
                ),
              ),
            ),
            // Column 2: Content (HTML)
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: HtmlWidget(
                  tableItem.content,
                  textStyle: const TextStyle(fontSize: 17),
                ),
              ),
            ),
            // Column 3: Reference value
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  tableItem.reference?.refValue.split('_').last ?? '',
                  style: const TextStyle(fontSize: 17),
                ),
              ),
            ),
          ],
        );
      }).toList(),
    ),
  );
}


  void _navigateToDetailPage(BuildContext context, FloraItem item) {
    // Implement navigation to detail page based on the item type
    // You may need to fetch more data or use a different page based on whether it's a species, genus, or family
  }

  Widget _buildTwoColumnSection(
      {required String title,
      required String iconImage,
      required List<TableRow> children}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
          child: Row(
            children: [
              ImageIcon(AssetImage(iconImage)),
              Text(
                ' $title',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Divider(color: Colors.lightGreen[900]),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 10, 20),
          child: Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1),
            },
            children: children,
          ),
        ),
      ],
    );
  }

  TableRow? _buildTableRow(
      {required String label, required List<String?> value}) {
    final filteredValue =
        value.where((v) => v != null && v.isNotEmpty).toList();
    if (filteredValue.isEmpty) {
      return null; // Omit the table row if all values are empty
    }
    return TableRow(
      children: [
        TableCell(
          child: Text(label, style: const TextStyle(fontSize: 17)),
        ),
        TableCell(
          child: Text(
            filteredValue.join(', '),
            style: const TextStyle(fontSize: 17),
          ),
        ),
      ],
    );
  }

void _launchURL(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
