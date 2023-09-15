// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:iotappver1/src/resources/widget/apps/bedroom.dart';
// import 'package:iotappver1/src/resources/widget/apps/kitchen.dart';
// import 'package:iotappver1/src/resources/widget/thungrac/livingroom.dart';
// import 'package:iotappver1/src/resources/widget/apps/livingroom.dart';
// import 'package:iotappver1/src/resources/widget/apps/outside.dart';
// import 'package:provider/provider.dart';

// import '../../../ServiceMQTT/MQTTManager.dart';

// class Apps extends StatefulWidget {
//   Apps({
//     required this.navigateToFivethPage,
//     required this.navigateToFirstPage,
//   });
//   final VoidCallback navigateToFirstPage;
//   final VoidCallback navigateToFivethPage;

//   @override
//   State<Apps> createState() => _AppsState();
// }

// class _AppsState extends State<Apps> with TickerProviderStateMixin {
//   late TabController _tabController;
//   late List<Widget> _views; // Declare the variable here
//   String uid = '';
//   int admin = 1;
//   String ChoseHub = ' ';
//   List<Map<String, dynamic>> Room = [];
//   List<Map<String, dynamic>> Device = [];
  

//   DatabaseReference _databaseReference =
//       FirebaseDatabase.instance.reference().child('users');
//   MQTTManager _manager = MQTTManager();
//   FirebaseAuth auth = FirebaseAuth.instance;

//   //MQTTManager get manager => _manager;

//   void ConnectMqtt() {
//     Future.delayed(const Duration(microseconds: 100), () => _manager.connect());
//     Future.delayed(
//         const Duration(seconds: 4),
//         //() => _manager.subScribeTo("B4E62DB826BD_U"));
//         () => _manager.subScribeTo("${ChoseHub}_A"));
//     print(_manager.currentState.getAppConnectionState);
//   }

//   @override
//   void dispose() {
//     // ignore: todo
//     // TODO: implement dispose
//     Future.delayed(const Duration(microseconds: 300),
//         () => _manager.unSubscribeFromCurrentTopic());
//     Future.delayed(
//         const Duration(microseconds: 600), () => _manager.disconnect());
//     super.dispose();
//   }

//   @override
//   void initState() {
//     User? user = auth.currentUser;
//     if (user != null && admin == 1) {
//       uid = user.uid;
//       print("User UID: $uid");
//     } else {
//       print("User is not logged in.");
//     }
//     _databaseReference.child('$uid').onValue.listen((event) {
//       try {
//         if (event.snapshot != null) {
//           DataSnapshot snapshot = event.snapshot as DataSnapshot;
//           Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
//           ChoseHub = data['ChoseHub'].toString();
//           setState(() {});
//         }
//       } catch (e) {
//         print("Error: $e");
//       }
//     });
//     _databaseReference.child('$uid/room').onValue.listen((event) {
//       if (event.snapshot != null) {
//         DataSnapshot snapshot = event.snapshot as DataSnapshot;
//         Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

//         List<Map<String, dynamic>> settings3 = [];

//         data.forEach(
//           (key, value) {
//             if (value != null && value is Map<dynamic, dynamic>) {
//               if (value.containsKey('name')) {
//                 settings3.add(
//                   {
//                     'name': value['name'].toString(),
//                   },
//                 );
//               }
//               ;
//             }
//           },
//         );
//         setState(() {
//           Room = settings3;
//         });
//       }
//     });
//     _databaseReference.child('$uid/device').onValue.listen((event) {
//       if (event.snapshot != null) {
//         DataSnapshot snapshot = event.snapshot as DataSnapshot;
//         Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
//         List<Map<String, dynamic>> settings2 = [];
//         data.forEach(
//           (key, value) {
//             if (value != null && value is Map<dynamic, dynamic>) {
//               if (value.containsKey('mac') &&
//                   value.containsKey('name') &&
//                   value.containsKey('location') &&
//                   value.containsKey('location')) {
//                 if (value["idHub"] == ChoseHub) {
//                   settings2.add(
//                     {
//                       'type': value['type'].toString(),
//                       'mac': value['mac'].toString(),
//                       'name': value['name'].toString(),
//                       'location': value['location'].toString()
//                     },
//                   );
//                 }
//               }
//               ;
//             }
//           },
//         );
//         setState(() {
//           Device = settings2;
//         });
//       }
//     });
//     // ignore: todo
//     // TODO: implement initState
//     _tabController = TabController(length: 4, vsync: this);
//     //_tabController.animateTo(2);
//     ConnectMqtt();
//     // _views = [
//     //   Center(
//     //       child: LivingRoom(
//     //     manager: _manager,
//     //     state_d1: _manager.currentState.getd1,
//     //     state_d2: _manager.currentState.getd2,
//     //     state_d3: _manager.currentState.getd3,
//     //     state_d4: _manager.currentState.getd4,
//     //   )),
//     //   Center(child: Container()),
//     //   Center(child: Container()),
//     // ];
//     //   Center(child: Container()),

//     //   // Center(child: const Kitchen()),
//     //   // Center(child: const BedRoom()),
//     //   // Center(child: const OutSide()),
//     // ];

//     super.initState();
//   }

//   @override

//   /// List of Tab Bar Item

//   int current = 0;

//   @override
//   Widget build(BuildContext context) {
//     // = Provider.of<MQTTManager>(context);
//     // _tabController.index = 1;
//     _views = [
//       Consumer<MQTTManager>(
//         builder: (context, manager, _) {
//           return Center(
//             child: LivingRoom(
//               manager: _manager,
//               state_d1: _manager.currentState.getd1,
//               state_d2: _manager.currentState.getd2,
//               state_d3: _manager.currentState.getd3,
//               state_d4: _manager.currentState.getd4,
//             ),
//           );
//         },
//       ),
//       Center(child: Container()),
//       Center(child: Container()),
//       Center(child: OutSide()),
//     ];

//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<MQTTManager>.value(
//           value: _manager,
//         ),
//       ],
//       child: Scaffold(
//         /// APPBAR
//         appBar: AppBar(
//           toolbarHeight: 80,
//           centerTitle: true,
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           leading: IconButton(
//             color: Colors.blue[400],
//             icon: Icon(Icons.arrow_back),
//             onPressed: () {
//               widget.navigateToFirstPage();
//             },
//           ),
//           title: const Text(
//             'Rooms',
//             style: TextStyle(
//               fontWeight: FontWeight.w500,
//               fontSize: 25,
//               color: Color.fromRGBO(0, 0, 0, 0.8),
//               fontFamily: 'Roboto',
//             ),
//           ),
//           actions: [
//             InkWell(
//               onTap: () {
//                 // Xử lý khi người dùng nhấp vào hình ảnh
//                 // Chuyển sang một trang khác
//                 widget.navigateToFivethPage();
//               },
//               child: CircleAvatar(
//                 child: Container(
//                   height: 70,
//                   width: 70,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(90),
//                     color: Colors.white,
//                   ),
//                   padding: EdgeInsets.all(5),
//                   child: Image.asset("assets/images/person.png",
//                       fit: BoxFit.contain),
//                 ),
//               ),
//             ),
//           ],
//         ),

//         ///Điện năng tiêu thụ
//         body: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomLeft,
//               colors: [
//                 Colors.white70,
//                 Colors.blue.shade200,
//               ],
//             ),
//           ),
//           child: Column(
//             children: [
//               Container(
//                 child: Center(
//                   child: Container(
//                       width: 300,
//                       height: 100,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(
//                           color: Colors.blue,
//                           width: 2,
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.only(left: 20),
//                             child: Container(
//                               width: 70,
//                               height: 70,
//                               decoration: BoxDecoration(
//                                 color: Colors.red,
//                                 borderRadius: BorderRadius.circular(90),
//                               ),
//                               child: Center(
//                                 child: Image.asset(
//                                   'assets/images/ic_electric.png',
//                                   width: 70,
//                                   height: 70,
//                                   fit: BoxFit.contain,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 30,
//                           ),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Row(
//                                 children: [
//                                   Text(
//                                     "${ChoseHub}",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 28,
//                                       color: Colors.black,
//                                       fontFamily: 'Roboto',
//                                     ),
//                                   ),
//                                   SizedBox(width: 5),
//                                   Text(
//                                     'kWh',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 28,
//                                       color: Colors.black,
//                                       fontFamily: 'Roboto',
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Text(
//                                 'Power usage today',
//                                 style: GoogleFonts.poppins(
//                                   fontWeight: FontWeight.w700,
//                                   fontSize: 14,
//                                   color: Colors.black54,
//                                 ),
//                               ),
//                             ],
//                           )
//                         ],
//                       )),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               SizedBox(
//                 width: double.infinity,
//                 height: 500,
//                 child: DefaultTabController(
//                   length: Room.length,
//                   child: Scaffold(
//                     body: Column(
//                       children: [
//                         SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: TabBar(
//                             controller: _tabController,
//                             isScrollable: true,
//                             tabs: Room.map((room) {
//                               return Tab(
//                                 child: Center(
//                                   child: Text(
//                                     room['name'],
//                                     style: GoogleFonts.poppins(
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             }).toList(),
//                             // Add more properties if needed
//                           ),
//                         ),
//                         Expanded(
//                           child: TabBarView(
//                             controller: _tabController,
//                             children: _views,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
