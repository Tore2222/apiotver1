// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../box/widgetbox.dart';

// class LivingroomScreen extends StatefulWidget {
//   @override
//   _LivingroomScreenState createState() => _LivingroomScreenState();
// }

// class _LivingroomScreenState extends State<LivingroomScreen> {
//   bool isPressed = false;

//   void togglePressed() {
//     setState(() {
//       isPressed = !isPressed;
//     });
//   }

//   List<Widget> deviceWidgets = [
//     IoTDeviceControlWidget(
//       room: "Living Room",
//       imagePath: "assets/images/Light.png",
//       text: "ĐÈN 1",
//       onPressed: () {
//         // Thực hiện hành động khi nút điều khiển được nhấn
//       },
//     ),
//     IoTDeviceControlWidget(
//       room: "Living Room",
//       imagePath: "assets/images/Fan Speed.png",
//       text: "ĐÈN 2",
//       onPressed: () {
//         // Thực hiện hành động khi nút điều khiển được nhấn
//       },
//     ),
//   ];
//   @override
//   void initState() {
//     super.initState();
//     loadDeviceWidgets(); // Load trạng thái danh sách các thiết bị khi trang được khởi tạo
//   }

//   Future<void> loadDeviceWidgets() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> deviceList = prefs.getStringList('deviceWidgets') ?? [];

//     setState(() {
//       deviceWidgets = deviceList.map((device) {
//         // Chuyển đổi các thông tin của thiết bị từ dạng String thành Widget
//         // Ví dụ: "Living Room;assets/images/Light.png;ĐÈN 1" => IoTDeviceControlWidget(...)
//         List<String> deviceInfo = device.split(';');
//         return IoTDeviceControlWidget(
//           room: deviceInfo[0],
//           imagePath: deviceInfo[1],
//           text: deviceInfo[2],
//           onPressed: () {
//             // Thực hiện hành động khi nút điều khiển được nhấn
//           },
//         );
//       }).toList();
//     });
//   }

//   void addDeviceWidget() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         String deviceName = '';
//         String imagePath = "assets/images/Light.png";
//         bool isChosen = false;

//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             return AlertDialog(
//               title: Text('Thêm thiết bị'),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextField(
//                     onChanged: (value) {
//                       setState(() {
//                         deviceName = value; // Cập nhật trạng thái deviceName
//                       });
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'Tên thiết bị',
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Container(
//                     width: 100,
//                     height: 100,
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 imagePath = "assets/images/Light.png";
//                                 isChosen =
//                                     false; // Cập nhật trạng thái isChosen
//                               });
//                             },
//                             child: Container(
//                               height: 70,
//                               width: 70,
//                               decoration: BoxDecoration(
//                                 color: Color.fromARGB(255, 225, 227, 237),
//                                 borderRadius: BorderRadius.circular(20),
//                                 border: Border.all(
//                                   color: !isChosen
//                                       ? Color.fromARGB(255, 86, 227, 107)
//                                       : Colors.transparent,
//                                   width: 2,
//                                 ),
//                               ),
//                               padding: EdgeInsets.all(5),
//                               child: Image.asset(
//                                 "assets/images/Light.png",
//                                 fit: BoxFit.contain,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 imagePath = "assets/images/Fan Speed.png";
//                                 isChosen = true; // Cập nhật trạng thái isChosen
//                               });
//                             },
//                             child: Container(
//                               height: 70,
//                               width: 70,
//                               decoration: BoxDecoration(
//                                 color: Color.fromARGB(255, 225, 227, 237),
//                                 borderRadius: BorderRadius.circular(20),
//                                 border: Border.all(
//                                   color: isChosen
//                                       ? Color.fromARGB(255, 86, 227, 107)
//                                       : Colors.transparent,
//                                   width: 2,
//                                 ),
//                               ),
//                               padding: EdgeInsets.all(5),
//                               child: Image.asset(
//                                 "assets/images/Fan Speed.png",
//                                 fit: BoxFit.contain,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               actions: [
//                 ElevatedButton(
//                   onPressed: () async {
//                     setState(() {
//                       deviceWidgets.add(
//                         IoTDeviceControlWidget(
//                           room: "Living Room",
//                           imagePath: imagePath,
//                           text: deviceName,
//                           onPressed: () {
//                             // Thực hiện hành động khi nút điều khiển được nhấn
//                           },
//                         ),
//                       );
//                     });
//                     Navigator.of(context).pop();
//                     await saveDeviceWidgets();
//                     loadDeviceWidgets();
//                   },
//                   child: Text('Thêm'),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
//   void removeDeviceWidget(int index) async {
//   setState(() {
//     deviceWidgets.removeAt(index);
//   });
//   await saveDeviceWidgets();
//   loadDeviceWidgets();
// }

//   Future<void> saveDeviceWidgets() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     List<String> deviceList = deviceWidgets.map((deviceWidget) {
//       IoTDeviceControlWidget widget = deviceWidget as IoTDeviceControlWidget;
//       // Chuyển đổi thông tin của thiết bị thành String để lưu vào SharedPreferences
//       // Ví dụ: IoTDeviceControlWidget(...) => "Living Room;assets/images/Light.png;ĐÈN 1"
//       return "${deviceWidget.room};${deviceWidget.imagePath};${deviceWidget.text}";
//     }).toList();

//     prefs.setStringList('deviceWidgets', deviceList);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         margin: const EdgeInsets.only(top: 30),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               GridView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: deviceWidgets.length,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                 ),
//                 itemBuilder: (context, index) {
//                   return deviceWidgets[index];
//                 },
//               ),
//               ElevatedButton(
//                 onPressed: addDeviceWidget,
//                 child: Icon(Icons.add),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
