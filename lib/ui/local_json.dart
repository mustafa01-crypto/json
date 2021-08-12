import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/models/person_model.dart';

class LocalJson extends StatefulWidget {
  const LocalJson({Key key}) : super(key: key);

  @override
  _LocalJsonState createState() => _LocalJsonState();
}

class _LocalJsonState extends State<LocalJson> {
  int counter = 0;

  List<Person> personList = List<Person>();
  final String localJsonPath = 'assets/dummy_data.json';

  Future<void> loadLocalJson() async {
    var dummyData = await rootBundle.loadString(localJsonPath);
    List<dynamic> decodedJson = json.decode(dummyData);
    personList = decodedJson.map((user) => Person.fromJson(user)).toList();
    setState(() {
      return personList;
    });
  }

  @override
  void initState() {
    super.initState();
    loadLocalJson();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: personList.length == 0
            ? const Center(child: const CircularProgressIndicator())
            : listItems(context, personList),
      ),
    );
  }

  Widget listItems(BuildContext context, List<Person> list) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 3,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (BuildContext context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Container(
                color: Colors.blue,

                  child: list[index].parentId == null
                      ? Card(
                        child: Image.network(
                            list[index].picture,
                            width: 100,
                            height: 100,
                          ),
                      )
                      : null),
            ),
          ),
        ),
        Divider(thickness: 2,color: Colors.grey,),
        Expanded(
          flex: 10,
          child: ListView.builder(
            itemCount: list.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 4),
                child:  Column(
                  children: [
                    Text(list[index].parentId ==null? list[index].name : ""),
                    list[index].parentId !=null ?  Container(
                      width: MediaQuery.of(context).size.width * 4 / 5,
                      height: 135,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.network(
                            list[index].picture,
                            width: 100,
                            height: 135,
                          ),
                          Center(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width * 1 / 6),
                                child: Text(list[index].name),
                              )),
                        ],
                      ),
                    ) : SizedBox(),
                  ],
                ) ,
              );
            },
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
