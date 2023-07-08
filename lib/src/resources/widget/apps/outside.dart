// import 'package:flutter/material.dart';

// import '../box/custom_card.dart';
// import '../box/widgetbox.dart';

// class OutSide extends StatefulWidget {
//   const OutSide({super.key});

//   @override
//   State<OutSide> createState() => _OutSideState();
// }

// class _OutSideState extends State<OutSide> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Container(
//         margin: EdgeInsets.all(size.width * 0.05),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(height: size.height * 0.025),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   CustomCard(
//                     size: size,
//                     icon: Icon(
//                       Icons.home_outlined,
//                       size: 55,
//                       color: Colors.grey.shade400,
//                     ),
//                     title: "ENTRY",
//                     statusOn: "OPEN",
//                     statusOff: "LOCKED",
//                   ),
//                   CustomCard(
//                     size: size,
//                     icon: Icon(
//                       Icons.lightbulb_outline,
//                       size: 55,
//                       color: Colors.grey.shade400,
//                     ),
//                     title: "LIGHTS",
//                     statusOn: "ON",
//                     statusOff: "OFF",
//                   ),
//                 ],
//               ),
//               SizedBox(height: size.height * 0.025),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   CustomCard(
//                     size: size,
//                     icon: Icon(
//                       Icons.home_outlined,
//                       size: 55,
//                       color: Colors.grey.shade400,
//                     ),
//                     title: "ENTRY",
//                     statusOn: "OPEN",
//                     statusOff: "LOCKED",
//                   ),
//                   CustomCard(
//                     size: size,
//                     icon: Icon(
//                       Icons.lightbulb_outline,
//                       size: 55,
//                       color: Colors.grey.shade400,
//                     ),
//                     title: "LIGHTS",
//                     statusOn: "ON",
//                     statusOff: "OFF",
//                   ),
//                 ],
//               ),
//               SizedBox(height: size.height * 0.025),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   CustomCard(
//                     size: size,
//                     icon: Icon(
//                       Icons.opacity,
//                       size: 55,
//                       color: Colors.grey.shade400,
//                     ),
//                     title: "LEAKS",
//                     statusOn: "DETECTED",
//                     statusOff: "NOT DETECTED",
//                   ),
//                   CustomCard(
//                     size: size,
//                     icon: Icon(
//                       Icons.thermostat_outlined,
//                       size: 55,
//                       color: Colors.grey.shade400,
//                     ),
//                     title: "THERMOSTAT",
//                     statusOn: "ON",
//                     statusOff: "OFF",
//                   ),
//                 ],
//               ),
//               SizedBox(height: size.height * 0.025),
//               Container(
//                 height: 75,
//                 width: size.width * 0.8,
//                 decoration: BoxDecoration(
//                   color: Color(0xFFecf5fb),
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 8,
//                       offset: Offset(3, 3),
//                     ),
//                     BoxShadow(
//                       color: Colors.white,
//                       blurRadius: 0,
//                       offset: Offset(-3, -3),
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(15),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "ADD",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black54,
//                             ),
//                           ),
//                           Text(
//                             "NEW CONTROL",
//                             style: TextStyle(
//                               color: Colors.black45,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           )
//                         ],
//                       ),
//                       Icon(
//                         Icons.add,
//                         size: 40,
//                         color: Colors.black54,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
