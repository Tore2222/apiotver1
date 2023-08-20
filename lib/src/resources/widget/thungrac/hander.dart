// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// void onLongPressHub(BuildContext context, String uid, DatabaseReference _databaseReference, TextEditingController controller) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text('Change Name Hub'),
//         content: TextField(
//           controller: controller,
//         ),
//         actions: <Widget>[
//           TextButton(
//             style: TextButton.styleFrom(
//               textStyle: Theme.of(context).textTheme.labelLarge,
//             ),
//             child: const Text('Disable'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           TextButton(
//             style: TextButton.styleFrom(
//               textStyle: Theme.of(context).textTheme.labelLarge,
//             ),
//             child: const Text('Enable'),
//             onPressed: () {
//               _databaseReference
//                   .child('$uid/hub/id${Hub.length}/name')
//                   .set('Hub ${Hub.length}');
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }