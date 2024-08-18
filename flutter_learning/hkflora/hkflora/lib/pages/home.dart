import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hkflora/models/TaxonomicUnit.dart';
import 'package:hkflora/models/SpeciesData.dart';
import 'package:hkflora/models/GenusData.dart';
import 'package:hkflora/models/FamilyData.dart';
import 'package:hkflora/pages/floradatumpage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  final List<SpeciesData> speciesDataList;
  final List<GenusData> genusDataList;
  final List<FamilyData> familyDataList;

  const Home({
    Key? key,
    required this.speciesDataList,
    required this.genusDataList,
    required this.familyDataList,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState(
      speciesDataList: speciesDataList,
      genusDataList: genusDataList,
      familyDataList: familyDataList);
}

class _HomeState extends State<Home> {
  late List<TaxonomicUnit> plantList;
  late List<TaxonomicUnit> allplantList;
  DateTime timeBackPressed = DateTime.now();
  final TextEditingController _controller = TextEditingController();

  _HomeState(
      {required List<SpeciesData> speciesDataList,
      required List<GenusData> genusDataList,
      required List<FamilyData> familyDataList});

  @override
  void initState() {
    plantList = [
      ...widget.speciesDataList
          .map((species) => TaxonomicUnit('species', species)),
      ...widget.genusDataList.map((genus) => TaxonomicUnit('genus', genus)),
      ...widget.familyDataList.map((family) => TaxonomicUnit('family', family)),
    ];
    allplantList = plantList;
    allplantList.sort((a, b) {
    // First, compare by family number
    int familyComparison = a.getFamilyNo().compareTo(b.getFamilyNo());
    if (familyComparison != 0) return familyComparison;

    // If family numbers are the same, sort by priority (FamilyData first)
    int priorityComparison = a.getSortPriority().compareTo(b.getSortPriority());
    if (priorityComparison != 0) return priorityComparison;

    // If priorities are the same (both genus or species), sort alphabetically
    return a.getName().compareTo(b.getName());
  });


    // Add a listener to the TextEditingController
    _controller.addListener(onTextChanged);

    super.initState();
  }

  void onTextChanged() {
    if (_controller.text.isEmpty) {
      // If the search field is cleared, reset the state to the initial value
      setState(() {
        plantList = allplantList;
      });
    } else {
      onSearch(_controller.text);
    }
  }

  String removeLeadingZeros(String text) {
    return text.replaceAll(RegExp('0+'), '');
  }

  void onSearch(String query) {
    setState(() {
      plantList = allplantList.where((item) {
        if (item.type == 'species') {
          SpeciesData species = item.data;
          return species.scientificName
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              (species.synonym1 != null &&
                  species.synonym1!
                      .toLowerCase()
                      .contains(query.toLowerCase())) ||
              (species.synonym2 != null &&
                  species.synonym2!
                      .toLowerCase()
                      .contains(query.toLowerCase())) ||
              species.familyName.toLowerCase().contains(query.toLowerCase()) ||
              species.chineseFamilyName.contains(query) ||
              removeLeadingZeros(species.familyNo.toLowerCase())
                  .contains(removeLeadingZeros(query.toLowerCase())) ||
              (species.chineseName1 != null &&
                  species.chineseName1.toString().contains(query)) ||
              (species.chineseName2 != null &&
                  species.chineseName2.toString().contains(query));
        } else if (item.type == 'genus') {
          GenusData genus = item.data;
          return genus.genusName.toLowerCase().contains(query.toLowerCase()) ||
              genus.familyName.toLowerCase().contains(query.toLowerCase()) ||
              genus.chineseFamilyName.contains(query) ||
              removeLeadingZeros(genus.familyNo.toLowerCase())
                  .contains(removeLeadingZeros(query.toLowerCase()));
        } else if (item.type == 'family') {
          FamilyData family = item.data;
          return family.familyName
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              family.chineseFamilyName.contains(query) ||
              removeLeadingZeros(family.familyNo.toLowerCase())
                  .contains(removeLeadingZeros(query.toLowerCase()));
        }
        return false;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    onBackPressed(didPop) {
      if (didPop) {
        return;
      }
      final difference = DateTime.now().difference(timeBackPressed);
      final isExitWarning = difference >= const Duration(seconds: 2);

      timeBackPressed = DateTime.now();

      if (isExitWarning) {
        const message = 'Press back again to exit';
        Fluttertoast.showToast(msg: message, fontSize: 16);
      } else {
        Fluttertoast.cancel();
        // Exit the app
        SystemNavigator.pop();
      }
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        onBackPressed(didPop);
      },
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.grey[200],
            title: SizedBox(
              height: 38,
              child: TextField(
                //onChanged: (value) => onSearch(value),
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  // Add more styling properties as needed
                ),
                controller: _controller,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: const EdgeInsets.all(0),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none),
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[500],
                    ),
                    hintText: "Search...",
                    suffixIcon: IconButton(
                      onPressed: () {
                        _controller.clear();
                      },
                      icon: const Icon(Icons.clear),
                    )),
              ),
            ),
          ),
          body: Container(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 5,
                          5), // Adjust the padding values as per your requirement
                      child: Text(
                        "${plantList.length} search result(s)",
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey.shade700),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                        itemCount: plantList.length,
                        itemBuilder: (context, index) {
                          final item = plantList[index];
                          if (item.type == 'species') {
                            SpeciesData species = item.data;
                            return ListTile(
                              title: ((species.chineseName1 == null) || (species.chineseName1 == "")) ?
                                  Text(species.scientificName) : species.chineseName2 == null
                              ? Text('${species.scientificName} (${species.chineseName1})')
                              : Text('${species.scientificName} (${species.chineseName1}、${species.chineseName2})'),
                              subtitle: Text(
                                  '${species.familyNo} ${species.familyName} ${species.chineseFamilyName}'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PlantDataPage(
                                          taxonomicUnit: item,
                                          genusDataList: widget.genusDataList,
                                          speciesDataList: widget.speciesDataList,
                                          ),
                                  ),
                                );
                              },
                            );
                          } else if (item.type == 'genus') {
                            GenusData genus = item.data;
                            return ListTile(
                              title: ((genus.genusChineseName == null) ?
                                  Text('${genus.genusName}')
                              : Text('${genus.genusName} (${genus.genusChineseName})')
                              ),
                              subtitle: Text(
                                  '${genus.familyNo} ${genus.familyName} ${genus.chineseFamilyName}'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PlantDataPage(
                                          taxonomicUnit: item,
                                          genusDataList: widget.genusDataList,
                                          speciesDataList: widget.speciesDataList,
                                          ),
                                  ),
                                );
                              },
                            );
                          } else if (item.type == 'family') {
                            FamilyData family = item.data;
                            return ListTile(
                              title: ((family.chineseFamilyName == null) ?
                                  Text('${family.familyName}')
                              : Text('${family.familyName} (${family.chineseFamilyName})')
                              ),
                              subtitle: Text('${family.familyNo} ${family.familyName} ${family.chineseFamilyName}'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PlantDataPage(
                                          taxonomicUnit: item,
                                          genusDataList: widget.genusDataList,
                                          speciesDataList: widget.speciesDataList,
                                          ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    )
                  ]))),
    );
  }
}