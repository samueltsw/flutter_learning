import 'package:flutter/material.dart';
import 'package:hkflora/services/hkflora.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class FloraDatumPage extends StatelessWidget {
  final FloraData floraDatum;
  const FloraDatumPage({
    super.key,
    required this.floraDatum,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Plant Infomration',
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      )),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Card(
            color: Colors.lightGreen.shade50,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                   Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.lightGreen.shade50,
                          backgroundImage: AssetImage(
                              'assets/images/floradatumpage_card.png'),
                          radius: 20,
                        ),
                      ]),
                  Container(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('${floraDatum.scientificName} ',
                          style: const TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          )),
                      Text(
                          (floraDatum.chineseName1 != null &&
                                  floraDatum.chineseName2 != null)
                              ? '${floraDatum.chineseName1}、${floraDatum.chineseName2}'
                              : (floraDatum.chineseName1 != null)
                                  ? '${floraDatum.chineseName1}'
                                  : "",
                          style: const TextStyle(
                            fontSize: 18,
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                          '${floraDatum.familyNo} ${floraDatum.familyName} ${floraDatum.chineseFamilyName}',
                          style: const TextStyle(
                            fontSize: 16,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(height: 5),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
            child: Row(
              children: [
                const ImageIcon(
                    AssetImage('assets/images/floradatumpage_table.png')),
                Text(
                  ' Ecological Information',
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
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
              children: [
                TableRow(
                  children: [
                    TableCell(
                        child: Text('Native', style: TextStyle(fontSize: 15))),
                    TableCell(
                        child: Text(floraDatum.nativeToHk,
                            style: TextStyle(fontSize: 15))),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
            child: Row(
              children: [
                const ImageIcon(
                    AssetImage('assets/images/floradatumpage_table.png')),
                Text(
                  ' Conservation Status',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
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
              children: [
                TableRow(
                  children: [
                    TableCell(
                        child: Text('Cap. 96', style: TextStyle(fontSize: 15))),
                    TableCell(
                        child: Text(floraDatum.cap96,
                            style: TextStyle(fontSize: 15))),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                        child:
                            Text('Cap. 586', style: TextStyle(fontSize: 15))),
                    TableCell(
                        child: Text(floraDatum.cap586,
                            style: TextStyle(fontSize: 15))),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                        child: Text('Rare and Precious Plants of Hong Kong',
                            style: TextStyle(fontSize: 15))),
                    TableCell(
                        child: Text(floraDatum.rareAndPreciousPlantsOfHk ?? "",
                            style: TextStyle(fontSize: 15))),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                        child: Text('Plant Red Data Book',
                            style: TextStyle(fontSize: 15))),
                    TableCell(
                        child: Text(floraDatum.chinaPlantRedDataBook ?? "",
                            style: TextStyle(fontSize: 15))),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
            child: Row(
              children: [
                const ImageIcon(
                    AssetImage('assets/images/floradatumpage_table.png')),
                Text(
                  ' Flower & Fruit',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
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
              children: [
                TableRow(
                  children: [
                    TableCell(
                        child: Text('Flowering Period',
                            style: TextStyle(fontSize: 15))),
                    TableCell(
                        child: Text(
                            '${floraDatum.flowerFromValue.toString()} - ${floraDatum.flowerToValue.toString()}',
                            style: TextStyle(fontSize: 15))),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                        child: Text('Fruiting Period',
                            style: TextStyle(fontSize: 15))),
                    TableCell(
                        child: Text(
                            '${floraDatum.fruitFromValue.toString()} - ${floraDatum.fruitToValue.toString()}',
                            style: TextStyle(fontSize: 15))),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
            child: Row(
              children: [
                const ImageIcon(
                    AssetImage('assets/images/floradatumpage_table.png')),
                Text(
                  ' Other',
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
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
              children: [
                TableRow(
                  children: [
                    TableCell(
                        child: Text('Type Specimen Collected in Hong Kong',
                            style: TextStyle(fontSize: 15))),
                    TableCell(
                        child: Text(floraDatum.typeSpecimenCollectedInHk,
                            style: TextStyle(fontSize: 15))),
                  ],
                ),
              ],
            ),
          ),
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.lightGreen[900]),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 10, 10),
            child: HtmlWidget("${floraDatum.floraOfHKContent}"),
          ),
        ],
      ),
    );
  }
}
