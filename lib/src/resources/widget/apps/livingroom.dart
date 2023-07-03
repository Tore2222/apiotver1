import 'package:flutter/material.dart';
import '../../../ServiceMQTT/MQTTManager.dart';
import '../box/custom_card.dart';
class LivingRoom extends StatefulWidget {
  LivingRoom({super.key, required this.manager,
      required this.state_d1,
      required this.state_d2,
      required this.state_d3,
      required this.state_d4});
  MQTTManager manager;
  bool state_d1;
  bool state_d2;
  bool state_d3;
  bool state_d4;

  @override
  State<LivingRoom> createState() => _LivingRoomState();
}

class _LivingRoomState extends State<LivingRoom> {
  void toggle_d1() {
    setState(() {
      widget.state_d1 = !widget.state_d1;
    });
    print(get_data_device());
    upload(get_data_device());

    // _manager.publish(parse_json_data(get_data_device()),"test");
  }

  void toggle_d2() {
    setState(() {
      widget.state_d2 = !widget.state_d2;
    });
    print(get_data_device());
    upload(get_data_device());
    // _manager.publish(parse_json_data(get_data_device()),"test");
  }

  void toggle_d3() {
    setState(() {
      widget.state_d3 = !widget.state_d3;
    });
    print(get_data_device());
    upload(get_data_device());
    //  _manager.publish(parse_json_data(get_data_device()),"test");
  }

  void toggle_d4() {
    setState(() {
      widget.state_d4 = !widget.state_d4;
    });
    print(get_data_device());
    upload(get_data_device());
    // _manager.publish(parse_json_data(get_data_device()),"test");
  }

  int get_data_device() {
    int data = 0;
    if (widget.state_d1) {
      data += 1;
    } else {
      data += 0;
    }
    if (widget.state_d2) {
      data += 2;
    } else {
      data += 0;
    }
    if (widget.state_d3) {
      data += 4;
    } else {
      data += 0;
    }
    if (widget.state_d4) {
      data += 8;
    } else {
      data += 0;
    }
    return data;
  }

  
  void upload(int data) {
    String jsonData = "{\"data\":$data}";
    try {
      widget.manager.publish(jsonData, "B4E62DB826BD_D");
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(size.width * 0.05),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.025),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomCard(
                    size: size,
                    icon: Icon(
                      Icons.home_outlined,
                      size: 55,
                      color: Colors.grey.shade400,
                    ),
                    title: "ENTRY",
                    statusOn: "OPEN",
                    statusOff: "LOCKED",
                  ),
                  CustomCard(
                    size: size,
                    icon: Icon(
                      Icons.lightbulb_outline,
                      size: 55,
                      color: Colors.grey.shade400,
                    ),
                    title: "LIGHTS",
                    statusOn: "ON",
                    statusOff: "OFF",
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.025),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomCard(
                    size: size,
                    icon: Icon(
                      Icons.home_outlined,
                      size: 55,
                      color: Colors.grey.shade400,
                    ),
                    title: "ENTRY",
                    statusOn: "OPEN",
                    statusOff: "LOCKED",
                  ),
                  CustomCard(
                    size: size,
                    icon: Icon(
                      Icons.lightbulb_outline,
                      size: 55,
                      color: Colors.grey.shade400,
                    ),
                    title: "LIGHTS",
                    statusOn: "ON",
                    statusOff: "OFF",
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.025),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomCard(
                    size: size,
                    icon: Icon(
                      Icons.opacity,
                      size: 55,
                      color: Colors.grey.shade400,
                    ),
                    title: "LEAKS",
                    statusOn: "DETECTED",
                    statusOff: "NOT DETECTED",
                  ),
                  CustomCard(
                    size: size,
                    icon: Icon(
                      Icons.thermostat_outlined,
                      size: 55,
                      color: Colors.grey.shade400,
                    ),
                    title: "THERMOSTAT",
                    statusOn: "ON",
                    statusOff: "OFF",
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.025),
              Container(
                height: 75,
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  color: Color(0xFFecf5fb),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(3, 3),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 0,
                      offset: Offset(-3, -3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ADD",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            "NEW CONTROL",
                            style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Icon(
                        Icons.add,
                        size: 40,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
