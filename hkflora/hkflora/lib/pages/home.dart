import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hkflora/models/hkflora.dart';
import 'package:hkflora/pages/floradatumpage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  final FloraDataList floraDataList;
  const Home({super.key, required this.floraDataList});

  @override
  _HomeState createState() => _HomeState(floraDataList: floraDataList);
}

class _HomeState extends State<Home> {
  FloraDataList floraDataList;
  late FloraDataList allFloraDataList;
  DateTime timeBackPressed = DateTime.now();
  final TextEditingController _controller = new TextEditingController();

  _HomeState({required this.floraDataList});

  @override
  void initState() {
    floraDataList = widget.floraDataList;
    allFloraDataList = widget.floraDataList;

    // Add a listener to the TextEditingController
    _controller.addListener(onTextChanged);

    super.initState();
  }

  void onTextChanged() {
  if (_controller.text.isEmpty) {
    // If the search field is cleared, reset the state to the initial value
    setState(() {
      floraDataList = allFloraDataList;
    });
  } else {
    onSearch(_controller.text);
  }
}
    String removeLeadingZeros(String text) {
      return text.replaceAll(RegExp('0+'), '');
    }

   void  onSearch(String query) {
      FloraDataList suggestions = FloraDataList(
          data: allFloraDataList.data
              .where((floraData) =>
                  floraData.scientificName
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  floraData.familyName
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  floraData.chineseFamilyName.contains(query) ||
                  removeLeadingZeros(floraData.familyNo.toLowerCase())
                      .contains(removeLeadingZeros(query.toLowerCase())) ||
                  floraData.chineseName1 != null &&
                      floraData.chineseName1.toString().contains(query) ||
                  floraData.chineseName2 != null &&
                      floraData.chineseName2.toString().contains(query) ||
                  floraData.synonym1 != null &&
                      floraData.synonym1
                          .toString()
                          .toLowerCase()
                          .contains(query.toLowerCase()) ||
                  floraData.synonym2 != null &&
                      floraData.synonym2
                          .toString()
                          .toLowerCase()
                          .contains(query.toLowerCase()))
              .toList());

      setState(() => floraDataList = suggestions);
    }


  @override
  Widget build(BuildContext context) {



    onBackPressed(didPop){
         if(didPop){
          return;
        }
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= Duration(seconds: 2);

        timeBackPressed = DateTime.now();

        if(isExitWarning) {
          final message = 'Press back again to exit';
          Fluttertoast.showToast(msg: message, fontSize: 16);
        } else {
          Fluttertoast.cancel();
          // Exit the app
          SystemNavigator.pop();
        }
      }


    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async{
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
                      onPressed: (){
                        _controller.clear();
                      },
                      icon: Icon(Icons.clear),)
                ),
              ),
            ),
          ),
          body: Container(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 5, 5,
                      5), // Adjust the padding values as per your requirement
                  child: Text(
                    "${floraDataList.data.length} search result(s)",
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                    itemCount: floraDataList.data.length,
                    itemBuilder: (context, index) {
                      final floraDatum = floraDataList.data[index];
                      return ListTile(
                          titleTextStyle:
                              const TextStyle(fontSize: 17, color: Colors.black),
                          subtitleTextStyle: TextStyle(
                              fontSize: 15, color: Colors.grey.shade700),
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FloraDatumPage(floraDatum: floraDatum))),
                          title: floraDatum.chineseName2 == null
                              ? Text('${floraDatum.scientificName} (${floraDatum.chineseName1})')
                              : floraDatum.chineseName1 == null ?
                                  Text(floraDatum.scientificName)
                                : Text('${floraDatum.scientificName} (${floraDatum.chineseName1}、${floraDatum.chineseName2})'),
                          subtitle: Text(
                              '${floraDatum.familyNo} ${floraDatum.familyName} ${floraDatum.chineseFamilyName}'));
                    },
                  ),
                )
              ]))),
    );
  }
}
