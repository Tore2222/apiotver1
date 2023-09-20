import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iotappver1/src/resources/widget/apps/bedroom.dart';
import 'package:iotappver1/src/resources/widget/apps/kitchen.dart';
import 'package:iotappver1/src/resources/widget/apps/room_page.dart';
import 'package:iotappver1/src/resources/widget/thungrac/livingroom.dart';
import 'package:iotappver1/src/resources/widget/apps/livingroom.dart';
import 'package:iotappver1/src/resources/widget/apps/outside.dart';
import 'package:provider/provider.dart';

import '../../../ServiceMQTT/MQTTManager.dart';

class Apps extends StatefulWidget {
  Apps({
    required this.navigateToFivethPage,
    required this.navigateToFirstPage,
  });
  final VoidCallback navigateToFirstPage;
  final VoidCallback navigateToFivethPage;

  @override
  State<Apps> createState() => _AppsState();
}

class _AppsState extends State<Apps> with TickerProviderStateMixin {
  late TabController _tabController;
  List<Widget> _tab = [];
  List<Widget> _views = []; // Declare the variable here
  // Declare the variable here
  String uid = '';
  int admin = 1;
  String ChoseHub = ' ';
  List<Map<String, dynamic>> Room = [];

  DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child('users');
  MQTTManager _manager = MQTTManager();
  FirebaseAuth auth = FirebaseAuth.instance;

  //MQTTManager get manager => _manager;
  void updateRoom() {
    _databaseReference.child('$uid/room${ChoseHub}').onValue.listen((event) {
      if (event.snapshot != null) {
        DataSnapshot snapshot = event.snapshot as DataSnapshot;
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

        List<Map<String, dynamic>> settings3 = [];

        data.forEach(
          (key, value) {
            if (value != null && value is Map<dynamic, dynamic>) {
              if (value.containsKey('name')) {
                settings3.add(
                  {
                    'name': value['name'].toString(),
                  },
                );
              }
              ;
            }
          },
        );
        if (context.mounted) {
          setState(() {
            Room = settings3;
            _tabController = TabController(length: Room.length, vsync: this);
            _tab = Room.map((room) {
              return Tab(
                child: Center(
                  child: Text(
                    room['name'],
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            }).toList();
            _views = Room.map((room) {
              return Center(
                child: RoomPage(
                    roomName: room['name'],
                    manager: _manager,
                    uid: uid,
                    chosehub: ChoseHub),
              );
            }).toList();
          });
        }
      }
    });
  }

  // void ConnectMqtt() {
  //   Future.delayed(const Duration(microseconds: 100), () => _manager.connect());
  //   Future.delayed(
  //       const Duration(seconds: 4),
  //       //() => _manager.subScribeTo("B4E62DB826BD_U"));
  //       () => _manager.subScribeTo("${ChoseHub}_A"));
  //   print(_manager.currentState.getAppConnectionState);
  // }
  void ConnectMqtt() {
    // Future.delayed(
    //     const Duration(microseconds: 100), () => widget.manager.connect());
    Future.delayed(const Duration(seconds: 1),
        () => _manager.subScribeTo("${ChoseHub}_A_0000}"));
  }

  @override
  void initState() {
    _manager.connect();

    User? user = auth.currentUser;
    if (user != null && admin == 1) {
      uid = user.uid;
      print("User UID: $uid");
    } else {
      print("User is not logged in.");
    }
    _databaseReference.child('$uid').onValue.listen((event) {
      try {
        if (event.snapshot != null) {
          DataSnapshot snapshot = event.snapshot as DataSnapshot;
          Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

          if (context.mounted) {
            setState(() {
              ChoseHub = data['ChoseHub'].toString();
              updateRoom();
            });
          }
        }
      } catch (e) {
        print("Error: $e");
      }
    });
    ConnectMqtt();
  

    super.initState();
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    _tabController?.dispose();
    Future.delayed(const Duration(microseconds: 300),
        () => _manager.unSubscribeFromCurrentTopic());
    Future.delayed(
        const Duration(microseconds: 600), () => _manager.disconnect());
    super.dispose();
  }

  /// List of Tab Bar Item

  int current = 0;

  @override
  Widget build(BuildContext context) {
    // = Provider.of<MQTTManager>(context);
    //updateRoom();
    // _tabController.index = 1;
    // _views = Room.map((room) {
    //   return Center(
    //     child: RoomPage(
    //         roomName: room['name'],
    //         manager: _manager,
    //         uid: uid,
    //         chosehub: ChoseHub),
    //   );
    // }).toList();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MQTTManager>.value(
          value: _manager,
        ),
      ],
      child: Scaffold(
        /// APPBAR
        appBar: AppBar(
          toolbarHeight: 80,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            color: Colors.blue[400],
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              widget.navigateToFirstPage();
            },
          ),
          title: const Text(
            'Rooms',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 25,
              color: Color.fromRGBO(0, 0, 0, 0.8),
              fontFamily: 'Roboto',
            ),
          ),
          // actions: [
          //   InkWell(
          //     onTap: () {
          //       // Xử lý khi người dùng nhấp vào hình ảnh
          //       // Chuyển sang một trang khác
          //       widget.navigateToFivethPage();
          //     },
          //     child: CircleAvatar(
          //       child: Container(
          //         height: 70,
          //         width: 70,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(90),
          //           color: Colors.white,
          //         ),
          //         padding: EdgeInsets.all(5),
          //         child: Image.asset("assets/images/person.png",
          //             fit: BoxFit.contain),
          //       ),
          //     ),
          //   ),
          // ],
        ),

        ///Điện năng tiêu thụ
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [
                Colors.white70,
                Colors.blue.shade200,
              ],
            ),
          ),
          child: Column(
            children: [
              Container(
                child: Center(
                  child: Container(
                      width: 300,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Container(
                              width: 65,
                              height: 65,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(90),
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/images/ic_electric.png',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Temp : ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                  Text(
                                   // "${_manager.currentState.gettemp} °C ",
                                    "31 °C ",

                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                  Text(
                                    "Humi : ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                  Text(
                                    // "${_manager.currentState.gethum} %",
                                    "83 % ",

                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "30",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'kWh',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Power usage today',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: double.infinity,
                height: 500,
                child: DefaultTabController(
                  length: Room.length,
                  child: Scaffold(
                    body: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: TabBar(
                            controller: _tabController,
                            isScrollable: true,
                            tabs: _tab,
                            onTap: (index) {
                              setState(() {
                                current = index;
                                _tabController.animateTo(
                                    index); // Update selected room index
                                _tab = Room.map((room) {
                                  return Tab(
                                    child: Center(
                                      child: Text(
                                        room['name'],
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList();
                                _views = Room.map((room) {
                                  return Center(
                                    child: RoomPage(
                                        roomName: room['name'],
                                        manager: _manager,
                                        uid: uid,
                                        chosehub: ChoseHub),
                                  );
                                }).toList();
                              });
                            },
                            // Add more properties if needed
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: _views,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
