import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'information.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

_InfoExamPageState pageState;

class InfoExamPage extends StatefulWidget {
  @override
  _InfoExamPageState createState() {
    pageState = _InfoExamPageState();
    return pageState;
  }
}

//파이어베이스 출력 연습
class _InfoExamPageState extends State<InfoExamPage> {
  @override
  Widget build(BuildContext parentcontext) {
    return Scaffold(
      appBar: AppBar(title: Text("상세정보 테스트")),
      body: Column(
        children: <Widget>[
          Container(
            height: 500,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("아파트")
                  .doc("매매")
                  .collection("서울")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return Text("Error: ${snapshot.error}");
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Text("Loading...");
                  default:
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          return SingleChildScrollView(
                              child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      snapshot.data.docs[index]["아파트"],
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    ElevatedButton(
                                      child: Text(
                                        '상세정보',
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            parentcontext,
                                            CupertinoPageRoute(
                                                builder: (parentcontext) =>
                                                    InfoPage(
                                                        id: snapshot.data
                                                            .docs[index].id)));
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ));
                        });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

Widget _isPrintMenu(var n, var m) {
  if (n) {
    return (Text(
      m,
      style: TextStyle(
        color: Colors.blueGrey,
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
    ));
  } else {
    return (Text("CCTV X"));
  }
}
