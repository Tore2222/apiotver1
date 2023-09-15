import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iotappver1/src/ServiceMQTT/variable_app.dart';
import 'package:provider/provider.dart';
import '../../../ServiceMQTT/MQTTManager.dart';
import '../box/custom_card.dart';

class RoomPage extends StatefulWidget {
  final String roomName;
  final String uid;
  final String chosehub;

  MQTTManager manager;
  RoomPage(
      {required this.manager,
      required this.roomName,
      required this.uid,
      required this.chosehub});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child('users');

  List<Map<String, dynamic>> Device = [];
  List<bool> dStates = [];
  late bool state_d1;
  late bool state_d2;
  late bool state_d3;
  late bool state_d4;
  late bool state_d5;
  late bool state_d6;
  late bool state_d7;
  late bool state_d8;
  late bool state_d9;
  late bool state_d10;
  late bool state_d11;
  late bool state_d12;
  late bool state_d13;
  late bool state_d14;
  late bool state_d15;

  void toggle_d1() {
    //setState(() {
    state_d1 = !state_d1;
    //});
    print(get_data_device());
    upload(get_data_device());

    // _manager.publish(parse_json_data(get_data_device()),"test");
  }

  void toggle_d2() {
    // setState(() {
    state_d2 = !state_d2;
    // });
    print(get_data_device());
    upload(get_data_device());
    // _manager.publish(parse_json_data(get_data_device()),"test");
  }

  void toggle_d3() {
    //setState(() {
    state_d3 = !state_d3;
    //});
    print(get_data_device());
    upload(get_data_device());
    //  _manager.publish(parse_json_data(get_data_device()),"test");
  }

  void toggle_d4() {
    //setState(() {
    state_d4 = !state_d4;
    //});
    print(get_data_device());
    upload(get_data_device());
    // _manager.publish(parse_json_data(get_data_device()),"test");
  }

  void toggle_d5() {
    //setState(() {
    state_d5 = !state_d5;
    //});
    print(get_data_device());
    upload(get_data_device());

    // _manager.publish(parse_json_data(get_data_device()),"test");
  }

  void toggle_d6() {
    // setState(() {
    state_d6 = !state_d6;
    // });
    print(get_data_device());
    upload(get_data_device());
    // _manager.publish(parse_json_data(get_data_device()),"test");
  }

  void toggle_d7() {
    //setState(() {
    state_d7 = !state_d7;
    //});
    print(get_data_device());
    upload(get_data_device());
    //  _manager.publish(parse_json_data(get_data_device()),"test");
  }

  void toggle_d8() {
    //setState(() {
    state_d8 = !state_d8;
    //});
    print(get_data_device());
    upload(get_data_device());
    // _manager.publish(parse_json_data(get_data_device()),"test");
  }

  void toggle_d9() {
    //setState(() {
    state_d9 = !state_d9;
    //});
    print(get_data_device());
    upload(get_data_device());
    // _manager.publish(parse_json_data(get_data_device()),"test");
  }

  void toggle_d10() {
    //setState(() {
    state_d10 = !state_d10;
    //});
    print(get_data_device());
    upload(get_data_device());
    // _manager.publish(parse_json_data(get_data_device()),"test");
  }

  void toggle_d11() {
    //setState(() {
    state_d11 = !state_d11;
    //});
    print(get_data_device());
    upload(get_data_device());
    // _manager.publish(parse_json_data(get_data_device()),"test");
  }

  void toggle_d12() {
    //setState(() {
    state_d12 = !state_d12;
    //});
    print(get_data_device());
    upload(get_data_device());
    // _manager.publish(parse_json_data(get_data_device()),"test");
  }

  void toggle_d13() {
    //setState(() {
    state_d13 = !state_d13;
    //});
    print(get_data_device());
    upload(get_data_device());
    // _manager.publish(parse_json_data(get_data_device()),"test");
  }

  void toggle_d14() {
    //setState(() {
    state_d14 = !state_d14;
    //});
    print(get_data_device());
    upload(get_data_device());
    // _manager.publish(parse_json_data(get_data_device()),"test");
  }

  void toggle_d15() {
    //setState(() {
    state_d15 = !state_d15;
    //});
    print(get_data_device());
    upload(get_data_device());
    // _manager.publish(parse_json_data(get_data_device()),"test");
  }

  // ignore: non_constant_identifier_names
  int get_data_device() {
    int data = 0;
    if (state_d1) {
      data += 1;
    } else {
      data += 0;
    }
    if (state_d2) {
      data += 2;
    } else {
      data += 0;
    }
    if (state_d3) {
      data += 4;
    } else {
      data += 0;
    }
    if (state_d4) {
      data += 8;
    } else {
      data += 0;
    }
    if (state_d5) {
      data += 16;
    } else {
      data += 0;
    }
    if (state_d6) {
      data += 32;
    } else {
      data += 0;
    }
    if (state_d7) {
      data += 64;
    } else {
      data += 0;
    }
    if (state_d8) {
      data += 128;
    } else {
      data += 0;
    }
    if (state_d9) {
      data += 256;
    } else {
      data += 0;
    }
    if (state_d10) {
      data += 512;
    } else {
      data += 0;
    }
    if (state_d11) {
      data += 1024;
    } else {
      data += 0;
    }
    if (state_d12) {
      data += 2048;
    } else {
      data += 0;
    }
    if (state_d13) {
      data += 4096;
    } else {
      data += 0;
    }
    if (state_d14) {
      data += 8192;
    } else {
      data += 0;
    }
    if (state_d15) {
      data += 16384;
    } else {
      data += 0;
    }
    return data;
  }

  void upload(int data) {
    String jsonData = "{\"data\":$data}";
    try {
      widget.manager.publish(jsonData, "${widget.chosehub}_D");
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  void ConnectMqtt() {
    Future.delayed(
        const Duration(microseconds: 100), () => widget.manager.connect());
    Future.delayed(
        const Duration(seconds: 4),
        //() => _manager.subScribeTo("B4E62DB826BD_U"));
        () => widget.manager.subScribeTo("94B5552C6778_A"));
    print("Quyền : ${widget.manager.currentState.getd1}");
  }

  @override
  void initState() {
    widget.manager.connect();

    // Subscribe to the MQTT topic
    ConnectMqtt();

    // Listen for incoming MQTT messages

    // Sử dụng widget.manager để truy cập MQTTManager
    _databaseReference.child('${widget.uid}/ChoseHub').onValue.listen((event) {
      if (event.snapshot != null) {
        DataSnapshot snapshot = event.snapshot as DataSnapshot;
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

        setState(() {});
      }
    });
    _databaseReference.child('${widget.uid}/device1').onValue.listen((event) {
      if (event.snapshot != null) {
        DataSnapshot snapshot = event.snapshot as DataSnapshot;
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
        List<Map<String, dynamic>> settings3 = [];
        data.forEach(
          (key, value) {
            if (value != null && value is Map<dynamic, dynamic>) {
              if (value["location"] == widget.roomName) {
                settings3.add(
                  {
                    'type': value['type'].toString(),
                    'mac': value['mac'].toString(),
                    'name': value['name'].toString(),
                    'location': value['location'].toString()
                  },
                );
              }
              ;
            }
          },
        );
        Device = [];
        Provider.of<AppData>(context, listen: false)
            .setlengthDevice1(settings3.length);
        print("QUYEN: ${settings3[3]['name']}");
        Device.addAll(settings3);
      }
    });
    widget.manager.onMessageReceived = (message) {
      // Gọi setState để cập nhật trang
      print('Quyền1 : $message');
      setState(() {
        
        state_d1 = widget.manager.currentState.getd1;
        state_d2 = widget.manager.currentState.getd2;
        state_d3 = widget.manager.currentState.getd3;
        state_d4 = widget.manager.currentState.getd4;
        state_d5 = widget.manager.currentState.getd5;
        state_d6 = widget.manager.currentState.getd6;
        state_d7 = widget.manager.currentState.getd7;
        state_d8 = widget.manager.currentState.getd8;
        state_d9 = widget.manager.currentState.getd9;
        state_d10 = widget.manager.currentState.getd10;
        state_d11 = widget.manager.currentState.getd11;
        state_d12 = widget.manager.currentState.getd12;
        state_d13 = widget.manager.currentState.getd13;
        state_d14 = widget.manager.currentState.getd14;
        state_d15 = widget.manager.currentState.getd15;
      });
    };
    state_d1 = widget.manager.currentState.getd1;
    state_d2 = widget.manager.currentState.getd2;
    state_d3 = widget.manager.currentState.getd3;
    state_d4 = widget.manager.currentState.getd4;
    state_d5 = widget.manager.currentState.getd5;
    state_d6 = widget.manager.currentState.getd6;
    state_d7 = widget.manager.currentState.getd7;
    state_d8 = widget.manager.currentState.getd8;
    state_d9 = widget.manager.currentState.getd9;
    state_d10 = widget.manager.currentState.getd10;
    state_d11 = widget.manager.currentState.getd11;
    state_d12 = widget.manager.currentState.getd12;
    state_d13 = widget.manager.currentState.getd13;
    state_d14 = widget.manager.currentState.getd14;
    state_d15 = widget.manager.currentState.getd15;

    _databaseReference.child('${widget.uid}/device').onValue.listen((event) {
      if (event.snapshot != null) {
        DataSnapshot snapshot = event.snapshot as DataSnapshot;
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
        List<Map<String, dynamic>> settings2 = [];
        data.forEach(
          (key, value) {
            if (value != null && value is Map<dynamic, dynamic>) {
              if (value.containsKey('mac') &&
                  value.containsKey('name') &&
                  value.containsKey('location') &&
                  value.containsKey('type') &&
                  value.containsKey('idHub')) {
                if (value["idHub"] == widget.chosehub &&
                    value["location"] == widget.roomName) {
                  settings2.add(
                    {
                      'type': value['type'].toString(),
                      'mac': value['mac'].toString(),
                      'name': value['name'].toString(),
                      'location': value['location'].toString()
                    },
                  );
                }
              }
              ;
            }
          },
        );

        Device.addAll(settings2);
        Provider.of<AppData>(context, listen: false)
            .setlengthDevice1(settings2.length);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<void Function()> toggleFunctions = [
      () => toggle_d1(),
      () => toggle_d2(),
      () => toggle_d3(),
      () => toggle_d4(),
      () => toggle_d5(),
      () => toggle_d6(),
      () => toggle_d7(),
      () => toggle_d8(),
      () => toggle_d9(),
      () => toggle_d10(),
      () => toggle_d11(),
      () => toggle_d12(),
      () => toggle_d13(),
      () => toggle_d14(),
      () => toggle_d15(),
      ()=>{},
      ()=>{},  
      ()=>{},  
      ()=>{},  
      ()=>{},  


    ];
    List stateFunctions = [
      state_d1,
      state_d2,
      state_d3,
      state_d4,
      state_d5,
      state_d6,
      state_d7,
      state_d8,
      state_d9,
      state_d10,
      state_d11,
      state_d12,
      state_d13,
      state_d14,
      state_d15,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
     
    ];

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(size.width * 0.05),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Wrap(spacing: 20, runSpacing: 30, children: [
                  for (int i = 0; i < Device.length; i++)
                    CustomCard(
                      size: size,
                      icon: Icon(
                        Icons.home_outlined,
                        size: 55,
                        color: Colors.grey.shade400,
                      ),
                      title: Device[i]['name'],
                      statusOn: Device[i]['name'] == "Cổng" ||
                              Device[i]['name'] == "Cửa Cuốn"
                          ? "OPEN"
                          : "ON",
                      statusOff: Device[i]['name'] == "Cổng" ||
                              Device[i]['name'] == "Cửa Cuốn"
                          ? "LOCKED"
                          : "OFF",
                      isChecked: widget.roomName == "InSide"
                          ? stateFunctions[i + 4]
                          : stateFunctions[i],
                      toggle: widget.roomName == "InSide"
                          ? toggleFunctions[i + 4]
                          : toggleFunctions[i],
                    ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
