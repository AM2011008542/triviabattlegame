import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  State<LeaderboardPage> createState() => _LeaderboardPage();
}

class _LeaderboardPage extends State<LeaderboardPage> {

  int i = 0;
  Color my = Colors.brown, CheckMyColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Leaderboard interface",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Leaderboard"),
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
            ClipPath(
              clipper: WaveClipperTwo(),
              child: Container(
                decoration:
                const BoxDecoration(color: Colors.blue),
                height: 200,
              ),
            ),
            Scaffold(
                body: Container(
                  margin: const EdgeInsets.only(top: 65.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(left: 15.0, top: 10.0),
                        child: RichText(
                            text: const TextSpan(
                                text: "Leader",
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                      text: " Board",
                                      style: TextStyle(
                                          color: Colors.pink,
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.bold))
                                ])),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Global Rank Board: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      /*Flexible(
                          child: StreamBuilder<QuerySnapshot>(
                              stream: Firestore.instance
                                  .collection('users')
                                  .where('class', isEqualTo: '12')
                                  .orderBy('MyPoints', descending: true)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  i = 0;
                                  return ListView.builder(
                                      itemCount: snapshot.data.documents.length,
                                      itemBuilder: (context, index) {
                                        print(index);
                                        if (index >= 1) {
                                          print('Greater than 1');
                                          if (snapshot.data.documents[index]
                                              .data['MyPoints'] ==
                                              snapshot.data.documents[index - 1]
                                                  .data['MyPoints']) {
                                            print('Same');
                                          } else {
                                            i++;
                                          }
                                        }
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0, vertical: 5.0),
                                          child: InkWell(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: i == 0 ? Colors.amber : i == 1 ? Colors.grey : i == 2 ? Colors.brown : Colors.white,
                                                      width: 3.0,
                                                      style: BorderStyle.solid),
                                                  borderRadius: BorderRadius.circular(5.0)
                                              ),
                                              width: MediaQuery.of(context).size.width,
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            top: 10.0, left: 15.0),
                                                        child: Row(
                                                          children: <Widget>[
                                                            CircleAvatar(
                                                                child: Container(
                                                                    decoration: BoxDecoration(
                                                                        shape: BoxShape.circle,
                                                                        image: DecorationImage(
                                                                            image: NetworkImage(snapshot.data.documents[index].data['photoUrl']),
                                                                            fit: BoxFit.fill)
                                                                    )
                                                                )
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            left: 20.0, top: 10.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  snapshot
                                                                      .data
                                                                      .documents[index]
                                                                      .data['Name'],
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .deepPurple,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                                  maxLines: 6,
                                                                )
                                                            ),
                                                            Text("Points: ${snapshot.data.documents[index].data['MyPoints']}"
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Flexible(child: Container()),
                                                      //i == 0 ? Text("🥇", style: r) : i == 1 ? Text("🥈", style: r,) : i == 2 ? Text("🥉", style: r,) : const Text(''),
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            left: 20.0,
                                                            top: 13.0,
                                                            right: 20.0),
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                          },
                                                          child: const Text("Challenge",
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight:
                                                                FontWeight.bold),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              })
                      )*/
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}