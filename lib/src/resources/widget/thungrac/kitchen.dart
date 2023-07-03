import 'package:flutter/material.dart';

import '../box/widgetbox.dart';

class KitchenScreen extends StatefulWidget {
  const KitchenScreen({super.key});

  @override
  State<KitchenScreen> createState() => _KitchenScreenState();
}

class _KitchenScreenState extends State<KitchenScreen> {
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
      room: "Kitchen",
      imagePath: "assets/images/Light.png",
      text: "Light 1",
      onPressed: () {
        // Thực hiện hành động khi nút điều khiển được nhấn
      },
      onDelete: () {},
    ),
    IoTDeviceControlWidget(
      room: "Kitchen",
      imagePath: "assets/images/Fan Speed.png",
      text: "Fan 1",
      onPressed: () {
        // Thực hiện hành động khi nút điều khiển được nhấn
      },
      onDelete: () {},
    ),
  ];

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
            ],
          ),
        ),
      ),
    );
  }
}
