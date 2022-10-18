import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:triviabattlegame/pages/view_user_profile.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  State<LeaderboardPage> createState() => _LeaderboardPage();
}

class _LeaderboardPage extends State<LeaderboardPage> {

  int i = 0;
  Color my = Colors.brown, CheckMyColor = Colors.black;



  @override
  Widget build(BuildContext context) {
    var r = const TextStyle(color: Colors.purpleAccent, fontSize: 34);
    return MaterialApp(
        title: "Leaderboard interface",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: RichText(
              text: const TextSpan(
                  text: "Leader",
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: " Board",
                        style: TextStyle(
                            color: Colors.pink,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold))
                  ])),
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
            Container(
              padding: const EdgeInsets.all(20.0),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Top Rank Board: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection('users').
                          orderBy('userPoint', descending: true).snapshots(),
                          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                            if (streamSnapshot.hasData) {
                              i = 0;
                              return ListView.builder(
                                  itemCount: streamSnapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    print(index);
                                    if (index >= 1) {
                                      print('Greater than 1');
                                      if (streamSnapshot.data!.docs[index]['userPoint'] ==
                                          streamSnapshot.data!.docs[index - 1]['userPoint']) {
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
                                                  color: i == 0 ? Colors.amber : i == 1
                                                      ? Colors.grey : i == 2 ? Colors.brown : Colors.black,
                                                  width: 3.0,
                                                  style: BorderStyle.solid),
                                              borderRadius:
                                              BorderRadius.circular(5.0)),
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
                                                                        image: NetworkImage(streamSnapshot.data!.docs
                                                                        [index]['imageUrl']),
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
                                                            alignment: Alignment.centerLeft,
                                                            child: Text(streamSnapshot.data!.docs[index]['userName'],
                                                              style: const TextStyle(
                                                                  color: Colors.deepPurple,
                                                                  fontWeight: FontWeight.w500),
                                                              maxLines: 6,
                                                            )
                                                        ),
                                                        Text("Points: ${streamSnapshot.data!.docs[index]['userPoint']}"),
                                                      ],
                                                    ),
                                                  ),
                                                  Flexible(child: Container()),
                                                  i == 0 ? Text("🥇", style: r) : i == 1
                                                      ? Text("🥈",
                                                    style: r,
                                                  ) : i == 2 ? Text(
                                                    "🥉",
                                                    style: r,
                                                  ) : const Text(''),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 20.0,
                                                        top: 13.0,
                                                        right: 20.0),
                                                    child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: Colors.green,
                                                        textStyle: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            fontStyle: FontStyle.normal),
                                                      ),
                                                      child: const Text("View"),
                                                      onPressed: () {
                                                        FirebaseFirestore.instance.collection('users').doc(streamSnapshot.data!.docs[index]['userID']).get().then((ds) {
                                                          print(ds.data()!["userEmail"]); // print data to test
                                                        });
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewUserProfilePage(userID: streamSnapshot.data!.docs[index]['userID'],)));
                                                      },
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}