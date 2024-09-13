import 'package:flutter/material.dart';
import 'package:hkflora/models/TaxonomicUnit.dart';
import 'package:hkflora/models/SpeciesData.dart';
import 'package:hkflora/models/GenusData.dart';
import 'package:hkflora/models/FamilyData.dart';
import 'package:hkflora/models/FullFloraData.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hkflora/theme.dart';
import 'package:flutter/rendering.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class PlantDataPage extends StatefulWidget {
  final TaxonomicUnit taxonomicUnit;
  final List<GenusData> genusDataList;
  final List<SpeciesData> speciesDataList;

  const PlantDataPage({
    Key? key,
    required this.taxonomicUnit,
    required this.genusDataList,
    required this.speciesDataList,
  }) : super(key: key);

  @override
  State<PlantDataPage> createState() => _PlantDataPageState();
}

class _PlantDataPageState extends State<PlantDataPage> {
  late AutoScrollController _scrollController;

@override
  void initState() {
    super.initState();
    _scrollController = AutoScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
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
            body: Builder(
              builder: (context) => ListView(
                physics: const BouncingScrollPhysics(),
                children: <Widget>[
                  _buildHeader(),
                  _buildExternalLinks(),
                  _buildInfoSections(),
                  _buildFloraOfHongKongSection(context),
                ],
              ),
            ),
          ),
        ));
  }

  String _getPageTitle() {
    if (widget.taxonomicUnit.data is SpeciesData) return 'Species Information';
    if (widget.taxonomicUnit.data is GenusData) return 'Genus Information';
    if (widget.taxonomicUnit.data is FamilyData) return 'Family Information';
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
    if (widget.taxonomicUnit.data is SpeciesData)
      return (widget.taxonomicUnit.data as SpeciesData).scientificName;
    if (widget.taxonomicUnit.data is GenusData)
      return (widget.taxonomicUnit.data as GenusData).genusName;
    if (widget.taxonomicUnit.data is FamilyData)
      return (widget.taxonomicUnit.data as FamilyData).familyName;
    return '';
  }

  String _getChineseNames() {
    if (widget.taxonomicUnit.data is SpeciesData) {
      final species = widget.taxonomicUnit.data as SpeciesData;
      return [species.chineseName1, species.chineseName2, species.chineseName3]
          .where((name) => name != null && name.isNotEmpty)
          .join('、');
    }
    if (widget.taxonomicUnit.data is GenusData) {
      return [(widget.taxonomicUnit.data as GenusData).genusChineseName]
          .where((name) => name != null && name.isNotEmpty)
          .join('');
    }
    if (widget.taxonomicUnit.data is FamilyData) {
      return [(widget.taxonomicUnit.data as FamilyData).chineseFamilyName]
          .where((name) => name.isNotEmpty)
          .join('');
    }
    return '';
  }

  String _getSubtitle() {
    if (widget.taxonomicUnit.data is SpeciesData) {
      final species = widget.taxonomicUnit.data as SpeciesData;
      return '${species.familyNo} ${species.familyName} ${species.chineseFamilyName}';
    }
    if (widget.taxonomicUnit.data is GenusData) {
      final genus = widget.taxonomicUnit.data as GenusData;
      return '${genus.familyNo} ${genus.familyName} ${genus.chineseFamilyName}';
    }
    if (widget.taxonomicUnit.data is FamilyData) {
      final family = widget.taxonomicUnit.data as FamilyData;
      return '${family.familyNo} ${family.familyName} ${family.chineseFamilyName}';
    }
    return '';
  }

  Widget _buildExternalLinks() {
    // Implement external links based on the type of taxonomicUnit
    String getKeyword() {
      switch (widget.taxonomicUnit.type) {
        case 'family':
          return (widget.taxonomicUnit.data as FamilyData).familyName;
        case 'genus':
          return (widget.taxonomicUnit.data as GenusData).genusName;
        case 'species':
          return (widget.taxonomicUnit.data as SpeciesData).scientificName;
        default:
          return '';
      }
    }

    String getHKHLink() {
      switch (widget.taxonomicUnit.type) {
        case 'family':
          return 'family&oID=${(widget.taxonomicUnit.data as FamilyData).familyId}';
        case 'genus':
          return 'genus&oID=${(widget.taxonomicUnit.data as GenusData).genusId}';
        case 'species':
          return 'species&oID=${(widget.taxonomicUnit.data as SpeciesData).speciesId}';
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
      const SizedBox(width: 5), // Spacing between buttons
      _buildResourceButton(
        label: 'HKCWW',
        url:
            'https://hkcww.org/hkplant/readdb_photo_v7.php?f1=${getKeyword()}&f2=any&f2b=apg&f3=any&f4=any&f5=any&f6=any&f7=any&f8=any&f8a=any&f8b=any&f9=any&f10=any&f11=any',
      ),
      const SizedBox(width: 5), // Spacing between buttons
      _buildResourceButton(
        label: 'iPlant.cn',
        url: 'https://www.iplant.cn/info/${getKeyword()}?t=z',
      ),
      const SizedBox(width: 5), // Spacing between buttons
      _buildResourceButton(
        label: 'POWO',
        url: 'https://powo.science.kew.org/results?q=${getKeyword()}',
      ),
    ];

    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: buttons));
  }

  Widget _buildInfoSections() {
    if (widget.taxonomicUnit.data is SpeciesData) {
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
    } else if (widget.taxonomicUnit is GenusData) {
      return Column(
        children: [
          _buildTwoColumnSection(
            title: 'Genus Information',
            iconImage: 'assets/images/floradatumpage_table.png',
            children: _getGenusInfo(),
          ),
        ],
      );
    } else if (widget.taxonomicUnit is FamilyData) {
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
    final species = widget.taxonomicUnit.data as SpeciesData;
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
    final species = widget.taxonomicUnit.data as SpeciesData;
    return [
      _buildTableRow(label: 'Native', value: [species.nativeToHk]),
    ].whereType<TableRow>().toList();
  }

  List<TableRow> _getSpeciesConservationStatus() {
    final species = widget.taxonomicUnit.data as SpeciesData;
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
    final species = widget.taxonomicUnit.data as SpeciesData;
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
    final species = widget.taxonomicUnit.data as SpeciesData;
    return [
      _buildTableRow(
          label: 'Type Specimen Collected in Hong Kong',
          value: [species.typeSpecimenCollectedInHk]),
    ].whereType<TableRow>().toList();
  }

  List<TableRow> _getGenusInfo() {
    final genus = widget.taxonomicUnit as GenusData;
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
    final family = widget.taxonomicUnit as FamilyData;
    return [
      _buildTableRow(label: 'Family ID', value: [family.familyId.toString()]),
      _buildTableRow(label: 'Family No', value: [family.familyNo]),
      _buildTableRow(label: 'Family', value: [family.familyName]),
      _buildTableRow(
          label: 'Chinese Family', value: [family.chineseFamilyName]),
    ].whereType<TableRow>().toList();
  }

  Widget _buildFloraOfHongKongSection(BuildContext context) {
    FullFlora? _getFloraOfHK() {
      if (widget.taxonomicUnit.data is SpeciesData)
        return (widget.taxonomicUnit.data as SpeciesData).floraOfHKContent;
      if (widget.taxonomicUnit.data is GenusData)
        return (widget.taxonomicUnit.data as GenusData).floraOfHKContent;
      if (widget.taxonomicUnit.data is FamilyData)
        return (widget.taxonomicUnit.data as FamilyData).floraOfHKContent;
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
                const ImageIcon(
                    AssetImage('assets/images/floradatumpage_table.png')),
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
            child: _buildFullFloraContent(floraData, context),
          ),
        ],
      );
    }
    return Container();
  }

  Widget _buildFullFloraContent(FullFlora fullFlora, BuildContext context) {
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
          return _buildFloraTable(item, context); // Pass the context here
        } else {
          return Container(); // Handle other types if needed
        }
      }).toList(),
    );
  }

  Widget _buildFloraTable(FloraItem item, BuildContext context) {
    if (item.table == null || item.table!.isEmpty) {
      return Container();
    }

    // Sort according to index
    final sortedTableItems = List<TableItem>.from(item.table!)
      ..sort(
          (a, b) => _extractDivId(a.index).compareTo(_extractDivId(b.index)));

    final Map<ValueKey<String>, int> keyToIndex = {};

    for (int i = 0; i < sortedTableItems.length; i++) {
      keyToIndex[ValueKey(_extractDivId(sortedTableItems[i].index))] = i;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: sortedTableItems.length,
          itemBuilder: (context, index) {
            final tableItem = sortedTableItems[index];
            return AutoScrollTag(
              key: ValueKey(index),
              controller: _scrollController,
              index: index,
              child: Row(
                key: ValueKey(_extractDivId(tableItem.index)),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Column 1: Index part
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: HtmlWidget(
                        tableItem.index,
                        textStyle: const TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                  // Column 2: Content (HTML)
                  Expanded(
                    flex: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: HtmlWidget(
                        tableItem.content,
                        textStyle: const TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                  // Column 3: Reference value
                  Expanded(
                    flex: 12,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          if (tableItem.reference != null) {
                            switch (tableItem.reference!.refType) {
                              case 'genus':
                              case 'species':
                                _navigateToFloraDataPage(
                                    context, tableItem.reference!);
                                break;
                              case 'item':
                                int mathedIndex = keyToIndex[ValueKey(tableItem.reference!.refValue)] as int;
                                
                                _scrollToItem(mathedIndex);
                                break;
                            }
                          }
                        },
                        child: HtmlWidget(
                          tableItem.reference?.content ?? '',
                          textStyle: const TextStyle(
                            fontSize: 17,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _navigateToFloraDataPage(BuildContext context, Reference reference) {
    TaxonomicUnit? item;

    if (reference.refType == 'genus') {
      try {
        GenusData genusData = widget.genusDataList.firstWhere(
          (e) => e.genusId == int.parse(reference.refValue),
        );
        item = TaxonomicUnit('genus', genusData);
      } catch (e) {
        // No matching genus found
        print('No matching genus found for ID: ${reference.refValue}');
      }
    } else if (reference.refType == 'species') {
      try {
        SpeciesData speciesData = widget.speciesDataList.firstWhere(
          (e) => e.speciesId == int.parse(reference.refValue),
        );
        item = TaxonomicUnit('species', speciesData);
      } catch (e) {
        // No matching species found
        print('No matching species found for ID: ${reference.refValue}');
      }
    } else {
      print('Unknown reference type: ${reference.refType}');
    }

    if (item != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlantDataPage(
            taxonomicUnit: item!,
            genusDataList: widget.genusDataList,
            speciesDataList: widget.speciesDataList,
          ),
        ),
      );
    } else {
      // Handle the case where no matching data was found
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('No data found for the selected item.'),
            duration: const Duration(seconds: 1)),
      );
    }
  }

  void _scrollToItem(int mathedIndex) async {
    await _scrollController.scrollToIndex(
      mathedIndex,
      preferPosition: AutoScrollPosition.begin,
    );
    await _scrollController.highlight(mathedIndex);

  }

  String _extractDivId(String htmlString) {
    RegExp regExp = RegExp(r'<div id="([^"]+)"');
    Match? match = regExp.firstMatch(htmlString);
    return match?.group(1) ?? '';
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
              0: FlexColumnWidth(1.8),
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
}
