import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
                      child: Text(choice),);
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

 /*return Scaffold(
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.green,
        overlayOpacity: 0.4,
        spacing: 12,
        openCloseDial: isDialOpen,
        elevation: 5,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.logout),
            label: 'Logout',
            onTap: choiceAction
          ),
          SpeedDialChild(
            child: const Icon(Icons.person),
            label: 'Edit Profile',
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex:5,
                child:Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green,Colors.green],
                    ),
                  ),
                  child: Column(
                      children: const [
                        SizedBox(height: 110.0,),
                        CircleAvatar(
                          radius: 65.0,
                          backgroundImage: AssetImage('assets/tbag-logo-2.png'),
                          backgroundColor: Colors.white,
                        ),
                        SizedBox(height: 10.0,),
                        Text('Username',
                            style: TextStyle(
                              color:Colors.white,
                              fontSize: 20.0,
                            )),
                        SizedBox(height: 10.0,),
                        Text('Course',
                          style: TextStyle(
                            color:Colors.white,
                            fontSize: 15.0,
                          ),)
                      ]
                  ),
                ),
              ),

              Expanded(
                flex:5,
                child: Container(
                  color: Colors.grey[200],
                  child: Center(
                      child:Card(
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
                                      ),),
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
              ),

            ],
          ),
          Positioned(
              top:MediaQuery.of(context).size.height*0.40,
              left: 20.0,
              right: 20.0,
              child: Card(
                  child: Padding(
                    padding:const EdgeInsets.all(16.0),
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
                                ),)
                            ]
                        ),
                      ],
                    ),
                  )
              )
          )
        ],

      ),
    );
  }

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
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(height: 50,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MaterialButton(
                              onPressed: () {
                                choiceAction();
                              },
                              color: Colors.black,
                              height: 45,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 4),
                              child: Center(
                                child: Text("LOG OUT", style: GoogleFonts.robotoSlab(
                                    fontSize: 16,
                                    color: Colors.white
                                ),),)
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void choiceAction() {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) => CupertinoAlertDialog(
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
  }*/
}