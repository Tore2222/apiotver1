// import 'package:flutter/material.dart';

// import '../box/widgetbox.dart';

// class LivingroomScreen extends StatefulWidget {
//   @override
//   _LivingroomScreenState createState() => _LivingroomScreenState();
// }

// class _LivingroomScreenState extends State<LivingroomScreen> {
//   bool isPressed = false;
//   bool ischose = false;

//   void togglePressed() {
//     setState(() {
//       isPressed = !isPressed;
//     });
//   }

//   void Pressed() {
//     setState(() {
//       ischose = !ischose;
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

//   void addDeviceWidget() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         String deviceName = '';
//         String imagePath = "assets/images/Light.png";
//         return AlertDialog(
//           title: Text('Thêm thiết bị'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 onChanged: (value) {
//                   deviceName = value;
//                 },
//                 decoration: InputDecoration(
//                   labelText: 'Tên thiết bị',
//                 ),
//               ),
//               SizedBox(height: 10),
//               Container(
//                 width: 100,
//                 height: 100,
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             imagePath = "assets/images/Light.png";
//                             // Đặt trạng thái đã chọn là false
//                             Pressed();
//                           }); // Xử lý khi người dùng nhấp vào Container
//                         },
//                         child: Container(
//                           height: 70,
//                           width: 70,
//                           decoration: BoxDecoration(
//                             color: Color.fromARGB(255, 225, 227, 237),
//                             borderRadius: BorderRadius.circular(20),
//                             border: Border.all(
//                               color: !ischose
//                                   ? Color.fromARGB(255, 86, 227, 107)
//                                   : Colors.transparent,
//                               width: 2,
//                             ),
//                           ),
//                           padding: EdgeInsets.all(5),
//                           child: Image.asset("assets/images/Light.png",
//                               fit: BoxFit.contain),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             imagePath = "assets/images/Light.png";
//                             // Đặt trạng thái đã chọn là false
//                             Pressed();
//                           });
//                           // Xử lý khi người dùng nhấp vào Container
//                         },
//                         child: Container(
//                           height: 70,
//                           width: 70,
//                           decoration: BoxDecoration(
//                             color: Color.fromARGB(255, 225, 227, 237),
//                             borderRadius: BorderRadius.circular(20),
//                             border: Border.all(
//                               color: ischose
//                                   ? Color.fromARGB(255, 86, 227, 107)
//                                   : Colors.transparent,
//                               width: 2,
//                             ),
//                           ),
//                           padding: EdgeInsets.all(5),
//                           child: Image.asset("assets/images/Fan Speed.png",
//                               fit: BoxFit.contain),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   deviceWidgets.add(
//                     IoTDeviceControlWidget(
//                       room: "Living Room",
//                       imagePath: imagePath,
//                       text: deviceName,
//                       onPressed: () {
//                         // Thực hiện hành động khi nút điều khiển được nhấn
//                       },
//                     ),
//                   );
//                 });
//                 Navigator.of(context).pop();
//               },
//               child: Text('Thêm'),
//             ),
//           ],
//         );
//       },
//     );
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


































// -----------------------------------------------------------------------
import 'package:flutter/material.dart';

import '../box/widgetbox.dart';

class LivingroomScreen extends StatefulWidget {
  @override
  _LivingroomScreenState createState() => _LivingroomScreenState();
}

class _LivingroomScreenState extends State<LivingroomScreen> {
  bool isPressed = false;
  bool ischose = false;

  void togglePressed() {
    setState(() {
      isPressed = !isPressed;
    });
  }

  void Pressed() {
    setState(() {
      ischose = !ischose;
    });
  }

  List<Widget> deviceWidgets = [
    IoTDeviceControlWidget(
      room: "Living Room",
      imagePath: "assets/images/Light.png",
      text: "Light 1",
      onPressed: () {
        // Thực hiện hành động khi nút điều khiển được nhấn
      },
      onDelete: () {},
    ),
    IoTDeviceControlWidget(
      room: "Living Room",
      imagePath: "assets/images/Fan Speed.png",
      text: "Fan 1",
      onPressed: () {
        // Thực hiện hành động khi nút điều khiển được nhấn
      },
      onDelete: () {},
    ),
  ];

  // void addDeviceWidget() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       String deviceName = '';
  //       String imagePath = "assets/images/Light.png";
  //       return AlertDialog(
  //         title: Text('Thêm thiết bị'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             TextField(
  //               onChanged: (value) {
  //                 deviceName = value;
  //               },
  //               decoration: InputDecoration(
  //                 labelText: 'Tên thiết bị',
  //               ),
  //             ),
  //             SizedBox(height: 10),
  //             Container(
  //               width: 100,
  //               height: 100,
  //               child: Row(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Expanded(
  //                     child: GestureDetector(
  //                       onTap: () {
  //                         setState(() {
  //                           imagePath = "assets/images/Light.png";
  //                           // Đặt trạng thái đã chọn là false
  //                           Pressed();
  //                         }); // Xử lý khi người dùng nhấp vào Container
  //                       },
  //                       child: Container(
  //                         height: 70,
  //                         width: 70,
  //                         decoration: BoxDecoration(
  //                           color: Color.fromARGB(255, 225, 227, 237),
  //                           borderRadius: BorderRadius.circular(20),
  //                           border: Border.all(
  //                             color: !ischose
  //                                 ? Color.fromARGB(255, 86, 227, 107)
  //                                 : Colors.transparent,
  //                             width: 2,
  //                           ),
  //                         ),
  //                         padding: EdgeInsets.all(5),
  //                         child: Image.asset("assets/images/Light.png",
  //                             fit: BoxFit.contain),
  //                       ),
  //                     ),
  //                   ),
  //                   Expanded(
  //                     child: GestureDetector(
  //                       onTap: () {
  //                         setState(() {
  //                           imagePath = "assets/images/Light.png";
  //                           // Đặt trạng thái đã chọn là false
  //                           Pressed();
  //                         });
  //                         // Xử lý khi người dùng nhấp vào Container
  //                       },
  //                       child: Container(
  //                         height: 70,
  //                         width: 70,
  //                         decoration: BoxDecoration(
  //                           color: Color.fromARGB(255, 225, 227, 237),
  //                           borderRadius: BorderRadius.circular(20),
  //                           border: Border.all(
  //                             color: ischose
  //                                 ? Color.fromARGB(255, 86, 227, 107)
  //                                 : Colors.transparent,
  //                             width: 2,
  //                           ),
  //                         ),
  //                         padding: EdgeInsets.all(5),
  //                         child: Image.asset("assets/images/Fan Speed.png",
  //                             fit: BoxFit.contain),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           ElevatedButton(
  //             onPressed: () {
  //               setState(() {
  //                 deviceWidgets.add(
  //                   IoTDeviceControlWidget(
  //                     room: "Living Room",
  //                     imagePath: imagePath,
  //                     text: deviceName,
  //                     onPressed: () {
  //                       // Thực hiện hành động khi nút điều khiển được nhấn
  //                     },
  //                     onDelete: () {},
  //                   ),
  //                 );
  //               });
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('Thêm'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: deviceWidgets.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return deviceWidgets[index];
                },
              ),
              // ElevatedButton(
              //   onPressed: addDeviceWidget,
              //   child: Icon(Icons.add),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
