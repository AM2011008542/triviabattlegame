import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:provider/provider.dart';
import '../animated/constants.dart';
import '../auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {

  final isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Profile interface",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Profile"),
          centerTitle: true,
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: popupAction,
                itemBuilder: (BuildContext context){
                  return Constants.choices.map((String choice){
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                  },
              )
            ]
        ),
        body: Stack(
          children: <Widget>[
            ClipPath(
              clipper: WaveClipperTwo(),
              child: Container(
                decoration:
                const BoxDecoration(color: Colors.green),
                height: 200,
              ),
            ),
            Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      flex:5,
                      child:SizedBox(
                        width: double.infinity,
                        child: Column(
                            children: const [
                              SizedBox(height: 50.0,),
                              CircleAvatar(
                                radius: 65.0,
                                backgroundImage: AssetImage('assets/tbag-logo-1.png'),
                                backgroundColor: Colors.black,
                              ),
                              SizedBox(height: 10.0,),
                              Text('Username',
                                  style: TextStyle(
                                    color:Colors.black,
                                    fontSize: 20.0,
                                  )),
                              SizedBox(height: 10.0,),
                              Text('Course',
                                style: TextStyle(
                                  color:Colors.black,
                                  fontSize: 15.0,
                                ),
                              )
                            ]
                        ),
                      ),
                    ),

                    /*Expanded(
                      flex: 5,
                      child: Container(
                        color: Colors.grey[200],
                        child: Center(
                            child: Card(
                                margin: const EdgeInsets.fromLTRB(10, 0, 0, 20),
                                child: SizedBox(
                                    width: 310.0,
                                    height:290.0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text("Information",
                                            style: TextStyle(
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          Divider(color: Colors.grey[300],),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.home,
                                                color: Colors.blueAccent[400],
                                                size: 35,
                                              ),
                                              const SizedBox(width: 40.0,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Text("Bio",
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                    ),),
                                                  Text("FairyTail, Magnolia",
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.grey[400],
                                                    ),)
                                                ],
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 40.0,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.auto_awesome,
                                                color: Colors.yellowAccent[400],
                                                size: 35,
                                              ),
                                              const SizedBox(width: 40.0,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Text("Phone",
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                    ),),
                                                  Text("Spatial & Sword Magic, Telekinesis",
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.grey[400],
                                                    ),)
                                                ],
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 40.0,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.favorite,
                                                color: Colors.pinkAccent[400],
                                                size: 35,
                                              ),
                                              const SizedBox(width: 40.0,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Text("Location",
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                    ),),
                                                  Text("Eating cakes",
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.grey[400],
                                                    ),)
                                                ],
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 40.0,)
                                        ],
                                      ),
                                    )
                                )
                            )
                        ),
                      ),
                    ),*/
                  ],
                ),
                Positioned(
                    top:MediaQuery.of(context).size.height*0.33,
                    left: 20.0,
                    right: 20.0,
                    child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text('Total Questions',
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 14.0
                                    ),),
                                  const SizedBox(height: 5.0,),
                                  const Text('0',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),)
                                ],
                              ),
                              Column(
                                  children: [
                                    Text('Points',
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 14.0
                                      ),),
                                    const SizedBox(height: 5.0,),
                                    const Text('?',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    )
                                  ]
                              ),
                            ],
                          ),
                        )
                    )
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void logOutAction() {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) =>
          CupertinoAlertDialog(
            title: const Text('Logging Out'),
            content: const Text('Are you sure you want to log out?'),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text("No"),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              CupertinoDialogAction(
                  child: const Text("Yes"),
                  onPressed: () {
                    print("User Log Out");
                    Navigator.of(context).pop(true);
                    context.read<AuthenticationService>().signOut();
                  }),
            ],
          ),
    );
  }

  void popupAction(String choice){
    if(choice == Constants.editProfile){
      print('Edit Profile');
    }
    else if(choice == Constants.logOut){
      print('Logout');
      logOutAction();
    }
  }
}