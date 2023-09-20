// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:iotappver1/src/ServiceMQTT/variable_app.dart';
// import 'package:provider/provider.dart';
// import '../../../ServiceMQTT/MQTTManager.dart';
// import '../box/custom_card.dart';

// class RoomPage extends StatefulWidget {
//   final String roomName;
//   final String uid;
//   final String chosehub;

//   MQTTManager manager;
//   RoomPage(
//       {required this.manager,
//       required this.roomName,
//       required this.uid,
//       required this.chosehub});

//   @override
//   State<RoomPage> createState() => _RoomPageState();
// }

// class _RoomPageState extends State<RoomPage> {
//   DatabaseReference _databaseReference =
//       FirebaseDatabase.instance.reference().child('users');

//   List<Map<String, dynamic>> Device = [];
//         List<Map<String, dynamic>> settings3 = [];
//         List<Map<String, dynamic>> settings2 = [];

//   late List<List<bool>> allStates =
//       List.generate(3+Provider.of<AppData>(context, listen: false).lengthDevice +5, (index) => List.filled(11, false));
//   // late List<List<bool>> allStates = List.generate(
//   //     Provider.of<AppData>(context, listen: false).lengthDevice + 2,
//   //     (index) => List.filled(11, false));
//   // late List<List<bool>> allStates;
//   void toggle_d(int j, int i) {
//     allStates[j][i] = !allStates[j][i];
//     print(get_data_device(j));
//     upload(get_data_device(j), j);
//   }

//   // ignore: non_constant_identifier_names
//   int get_data_device(int j) {
//     int data = 0;
//     for (int i = 0; i < allStates[j].length; i++) {
//       if (allStates[j][i]) {
//         data += (1 << i);
//       }
//     }
//     return data;
//   }

//   void upload(int data, int j) {
//     String jsonData = "{\"data\":$data}";
//     try {
//       print("Quyefne1 :${widget.chosehub}_D_${j.toString().padLeft(4, '0')}");
//       widget.manager.publish(
//           jsonData, "${widget.chosehub}_D_${j.toString().padLeft(4, '0')}");
//     } on Exception catch (e) {
//       print(e.toString());
//     }
//   }

//   void ConnectMqtt() {
//     // Future.delayed(
//     //     const Duration(microseconds: 100), () => widget.manager.connect());
//     Future.delayed(const Duration(seconds: 1),
//         //() => _manager.subScribeTo("B4E62DB826BD_U"));
//         () {
//       // widget.manager.subScribeTo("94B5552C6778_A_0001");
//       // widget.manager.subScribeTo("94B5552C6778_A_0002");
//       for (int i = 0;
//           i <= (Provider.of<AppData>(context, listen: false).lengthDevice + 5);
//           i++) {
//         widget.manager.subScribeTo("94B5552C6778_A_000$i");
//       }
//     });

// // Future.delayed(
// //     const Duration(seconds: 4),
// //     () {
// //        widget.manager.subScribeTo("94B5552C6778_A"); // Thay thế "topic1" bằng tên thực tế của topic
// //       // widget.manager.subScribeTo("94B5552C6778_A_B"); // Thay thế "topic3" bằng tên thực tế của topic
// //       //  widget.manager.subScribeTo("94B5552C6778_A_C");
// //     },
// //   );
//     print("Quyền : ${widget.manager.currentState.getD(1)}");
//   }

//   @override
//   void initState() {
//     widget.manager.connect();
//     // allStates = List.generate(
//     //     Provider.of<AppData>(context, listen: false).lengthDevice + 2,
//     //     (index) => List.filled(11, false),
//     //   );
//     // Subscribe to the MQTT topic
//     ConnectMqtt();
//     widget.manager.onMessageReceived = (message) {
//       // Gọi setState để cập nhật trang
//       //print("Quyền : $message");
//       // print("Quyền : ${widget.manager.topic}");

//       setState(() {
//         String topic = widget.manager.topic;
//         print("Quyền : ${topic[topic.length - 1]}");

//         for (int i = 0; i < 11; i++) {
//           allStates[int.parse(topic[topic.length - 1])][i] =
//               widget.manager.currentState.getD(i);
//         }
//         // print("Quyền : -- ${widget.manager.currentState.getd1}");
//       });
//     };

//     // Sử dụng widget.manager để truy cập MQTTManager
//     _databaseReference.child('${widget.uid}/ChoseHub').onValue.listen((event) {
//       if (event.snapshot != null) {
//         DataSnapshot snapshot = event.snapshot as DataSnapshot;
//         Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

//         setState(() {});
//       }
//     });
//     _databaseReference.child('${widget.uid}/device1').onValue.listen((event) {
//       if (event.snapshot != null) {
//         DataSnapshot snapshot = event.snapshot as DataSnapshot;
//         Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
//          settings3 = [];
//         data.forEach(
//           (key, value) {
//             if (value != null && value is Map<dynamic, dynamic>) {
//               if (value["location"] == widget.roomName) {
//                 settings3.add(
//                   {
//                     'type': value['type'].toString(),
//                     'mac': value['mac'].toString(),
//                     'name': value['name'].toString(),
//                     'location': value['location'].toString(),
//                     'panID': value['panID'].toString(),
//                     'status': value['status'].toString()
//                   },
//                 );
//               }
//               ;
//             }
//           },
//         );
//         Device = [];
//         settings3.sort((a, b) => a['mac'].compareTo(b['mac']));
//         Provider.of<AppData>(context, listen: false)
//             .setlengthDevice1(settings3.length);

//         Device.addAll(settings3);
//         print(
//             "Quyeenf1 :${(Device[0]['panID'])[(Device[0]['panID']).length - 1]}");
//       }
//     });

//     _databaseReference.child('${widget.uid}/device').onValue.listen((event) {
//       if (event.snapshot != null) {
//         DataSnapshot snapshot = event.snapshot as DataSnapshot;
//         Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
//         settings2 = [];
//         data.forEach(
//           (key, value) {
//             if (value != null && value is Map<dynamic, dynamic>) {
//               if (value.containsKey('mac') &&
//                   value.containsKey('name') &&
//                   value.containsKey('location') &&
//                   value.containsKey('type') &&
//                   value.containsKey('idHub') &&
//                   value.containsKey('panID')) {
//                 if (value["idHub"] == widget.chosehub &&
//                     value["location"] == widget.roomName) {
//                   settings2.add(
//                     {
//                       'type': value['type'].toString(),
//                       'mac': value['mac'].toString(),
//                       'name': value['name'].toString(),
//                       'location': value['location'].toString(),
//                       'panID': value['panID'].toString(),
//                     'status': value['status'].toString()
//                     },
//                   );
//                 }
//               }
//               ;
//             }
//           },
//         );

//         Device.addAll(settings2);
//         for (int i = 0; i < Device.length; i++) {
//           print("QUYỀN : ${Device[i]['name']}");
//         }
//         // Provider.of<AppData>(context, listen: false)
//         //     .setlengthDevice1(settings2.length);
//       }
//     });
  
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       body: Container(
//         margin: EdgeInsets.all(size.width * 0.05),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 5),
//                 child: Wrap(spacing: 20, runSpacing: 30, children: [
//                   for (int i = 0; i < Device.length; i++)
//                     CustomCard(
//                         size: size,
//                         icon: Icon(
//                           Icons.home_outlined,
//                           size: 55,
//                           color: Colors.grey.shade400,
//                         ),
//                         title: Device[i]['name'],
//                         statusOn: Device[i]['name'] == "Cổng" ||
//                                 Device[i]['name'] == "Cửa Cuốn"
//                             ? "OPEN"
//                             : "ON",
//                         statusOff: Device[i]['name'] == "Cổng" ||
//                                 Device[i]['name'] == "Cửa Cuốn"
//                             ? "LOCKED"
//                             : "OFF",
//                         isChecked: i>(settings3.length-1)?allStates[int.parse((Device[i]
//                             ['panID'])[(Device[i]['panID']).length - 1])][0]: allStates[int.parse((Device[i]
//                             ['panID'])[(Device[i]['panID']).length - 1])][i],
//                         toggle:i>(settings3.length-1)? () => toggle_d(
//                             int.parse((Device[i]['panID'])[(Device[i]['panID']).length - 1]),
//                             0): () => toggle_d(
//                             int.parse((Device[i]['panID'])[(Device[i]['panID']).length - 1]),
//                             i)
//                           ),
//                 ]),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
