import 'package:flutter/material.dart';
import 'package:hkflora/services/hkflora.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
   var allFloraDataList =
        ModalRoute.of(context)!.settings.arguments as FloraDataList;
    var floraDataList = allFloraDataList;
    //onSearch(String query) {
     // FloraDataList suggestions = FloraDataList(
      //    data: allFloraDataList.data
      //        .where((floraData) => floraData.scientificName
      //            .toLowerCase()
      //            .contains(query.toLowerCase()))
      //        .toList());

     // for (var data in suggestions.data) {
     //   print(data.scientificName);
     // }

    //  setState(() => floraDataList = suggestions);
    //}

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[200],
          title: SizedBox(
            height: 38,
            child: TextField(
              // onChanged: (value) => onSearch(value),
              onChanged: (value) {
                FloraDataList suggestions = FloraDataList(
                    data: allFloraDataList.data
                        .where((floraData) => floraData.scientificName
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList());

                for (var data in suggestions.data) {
                  debugPrint(data.scientificName);
                }

                setState(() {
                  floraDataList = suggestions;
                });
              },

              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.all(0),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none),
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                  hintText: "Search..."),
            ),
          ),
        ),
        body: Container(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: floraDataList.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                    titleTextStyle:
                        const TextStyle(fontSize: 13, color: Colors.black),
                    subtitleTextStyle:
                        TextStyle(fontSize: 11, color: Colors.grey.shade700),
                    onTap: () {},
                    title: Text(
                        '${floraDataList.data[index].scientificName} (${floraDataList.data[index].chineseName1})'),
                    subtitle: Text(
                        '${floraDataList.data[index].familyNo} ${floraDataList.data[index].familyName} ${floraDataList.data[index].chineseFamilyName}'));
              },
            )));
  }
}
