import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localjson/constants.dart';
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

  final dataKey = new GlobalKey();
  final _controller = ScrollController();

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
    return Stack(
      children: [
        Container(
          color: Colors.blueAccent,
          height: 170,
          width: MediaQuery.of(context).size.width,
        ),
        Container(
          height: 220,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (BuildContext context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 60),
              child: Card(
                  child: list[index].parentId == null
                      ? InkWell(
                          onTap: () {
                            _animateToIndex(index);
                          },
                          child: Card(
                            child: Image.network(
                              list[index].picture,
                              width: 100,
                              height: 100,
                            ),
                          ),
                        )
                      : null),
            ),
          ),
        ),
        // Divider(thickness: 2,color: Colors.grey,),
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 3 / 13,
          ),
          child: ListView.builder(
            controller: _controller,
            itemCount: list.length,
            shrinkWrap: true,
           // physics: const ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 1 / 10,
                    ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15,),
                    Text(
                      list[index].parentId == null ? list[index].name : "",
                      style: grey,
                    ),

                    list[index].parentId != null
                        ? Container(
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
                                  offset: Offset(
                                      0, 2), // changes position of shadow
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
                                      left: MediaQuery.of(context).size.width *
                                          1 /
                                          6),
                                  child: Text(
                                    list[index].name,
                                    style: black,
                                  ),
                                )),
                              ],
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              );
            },
          ),
        ),

      ],
    );
  }

  _animateToIndex(i) => _controller.animateTo(152.0 * i,
      duration: Duration(seconds: 2), curve: Curves.fastOutSlowIn);
}
