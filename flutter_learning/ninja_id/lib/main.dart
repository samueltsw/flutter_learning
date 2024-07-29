import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: NinjaCard(),
    ));

class NinjaCard extends StatefulWidget {
  @override
  State<NinjaCard> createState() => _NinjaCardState();
}

class _NinjaCardState extends State<NinjaCard> {

  int ninjaLevel = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text('Nimja ID Card'),
          centerTitle: true,
          backgroundColor: Colors.grey[800],
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            setState(() {
              ninjaLevel += 1;
            });
          },
          child:Icon(Icons.add),
          backgroundColor: Colors.grey[800],
          ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/img-01.jpg'),
                  radius: 40,
                ),
              ),
              Divider(
                height: 100,
                color: Colors.grey[800],
              ),
              Text('NAME',
                  style: TextStyle(
                    color: Colors.grey,
                    letterSpacing: 2,
                  )),
              SizedBox(
                height: 10,
              ),
              Text('Siu-wa',
                  style: TextStyle(
                      color: Colors.amberAccent[200],
                      fontSize: 28,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 30,
              ),
              Text('CURRENT NINJA LEVEL',
                  style: TextStyle(
                    color: Colors.grey,
                    letterSpacing: 2,
                  )),
              SizedBox(
                height: 10,
              ),
              Text('$ninjaLevel',
                  style: TextStyle(
                      color: Colors.amberAccent[200],
                      fontSize: 28,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Icon(
                    Icons.email,
                    color: Colors.grey[400],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text('siuwa1995@yahoo.com.hk',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 18,
                        letterSpacing: 1,
                      ))
                ],
              )
            ],
          ),
        ));
  }
}
