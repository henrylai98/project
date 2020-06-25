import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:comforrtzone2020/constants.dart';

class OrderDetailScreen extends StatefulWidget {
  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  TextEditingController _addressEditingController = new TextEditingController();

  List<Widget> itemsData = [];

  void getPostsData() {
    List<dynamic> responseList = CATEGORY_DATA;
    List<Widget> listItems = [];
    responseList.forEach((post) {
      listItems.add(Container(
          height: 150,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      post["type"],
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "\RM ${post["price"]}",
                      style: const TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
          )));
    });
    setState(() {
      itemsData = listItems;
    });
  }

  @override
  void initState() {
    super.initState();
    getPostsData();
    controller.addListener(() {
      double value = controller.offset / 119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search, color: Colors.black),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.person, color: Colors.black),
                onPressed: () {},
              )
            ],
          ),
          body: Container(
              height: size.height,
              child: Column(
                children: <Widget>[
                  Card(
                      elevation: 10,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Address",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            TextField(
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                controller: _addressEditingController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: 'address',
                                  icon: Icon(Icons.email),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  "Categories",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Expanded(
                                child: ListView.builder(
                                    controller: controller,
                                    itemCount: itemsData.length,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      double scale = 1.0;
                                      if (topContainer > 0.5) {
                                        scale = index + 0.5 - topContainer;
                                        if (scale < 0) {
                                          scale = 0;
                                        } else if (scale > 1) {
                                          scale = 1;
                                        }
                                      }
                                      return Opacity(
                                        opacity: scale,
                                        child: Transform(
                                          transform: Matrix4.identity()
                                            ..scale(scale, scale),
                                          alignment: Alignment.bottomCenter,
                                          child: Align(
                                              heightFactor: 0.7,
                                              alignment: Alignment.topCenter,
                                              child: itemsData[index]),
                                        ),
                                      );
                                    })),
                          ],
                        ),
                      ))
                ],
              ))),
    );
  }
}
