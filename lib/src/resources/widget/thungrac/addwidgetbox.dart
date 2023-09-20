import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
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
  List<Map<String, dynamic>> settings3 = [];
  List<Map<String, dynamic>> settings2 = [];
  List<Map<String, dynamic>> settings1 = [];
  late List<List<bool>> allStates;

  // if (Provider.of<AppData>(context, listen: false).allStates != [[]]) {
  //   allStates = Provider.of<AppData>(context, listen: false).allStates;
  // }
  // late List<List<bool>> allStates = List.generate(
  //     Provider.of<AppData>(context, listen: false).lengthDevice + 2,
  //     (index) => List.filled(11, false));
  // late List<List<bool>> allStates;
  void toggle_d(int j, int i) {
    allStates[j][i] = !allStates[j][i];
    print(get_data_device(j));
    upload(get_data_device(j), j);
  }

  // ignore: non_constant_identifier_names
  int get_data_device(int j) {
    int data = 0;
    for (int i = 0; i < allStates[j].length; i++) {
      if (allStates[j][i]) {
        data += (1 << i);
      }
    }
    return data;
  }

  void upload(int data, int j) {
    String jsonData = "{\"data\":$data}";
    try {
      print("Quyefne1 :${widget.chosehub}_D_${j.toString().padLeft(4, '0')}");
      widget.manager.publish(
          jsonData, "${widget.chosehub}_D_${j.toString().padLeft(4, '0')}");
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  void ConnectMqtt() {
    // Future.delayed(
    //     const Duration(microseconds: 100), () => widget.manager.connect());
    Future.delayed(const Duration(seconds: 1),
        //() => _manager.subScribeTo("B4E62DB826BD_U"));
        () {
      // widget.manager.subScribeTo("94B5552C6778_A_0001");
      // widget.manager.subScribeTo("94B5552C6778_A_0002");
      for (int i = 0;
          i <= (Provider.of<AppData>(context, listen: false).lengthDevice + 5);
          i++) {
        widget.manager.subScribeTo("${widget.chosehub}_A_000$i");
      }
    });

    // Future.delayed(
    //     const Duration(seconds: 4),
    //     () {
    //        widget.manager.subScribeTo("94B5552C6778_A"); // Thay thế "topic1" bằng tên thực tế của topic
    //       // widget.manager.subScribeTo("94B5552C6778_A_B"); // Thay thế "topic3" bằng tên thực tế của topic
    //       //  widget.manager.subScribeTo("94B5552C6778_A_C");
    //     },
    //   );
    print("Quyền : ${Provider.of<AppData>(context, listen: false).allStates}");
  }

  List<List<int>> boolListToIntList(List<List<bool>> boolList) {
    return boolList.map((list) => list.map((b) => b ? 1 : 0).toList()).toList();
  }

  List<List<bool>> intListToBoolList(List<List<int>> intList) {
    return intList
        .map((list) => list.map((i) => i == 0 ? false : true).toList())
        .toList();
  }

  List<List<bool>> convertDataToBoolList(List<List<int>> intList) {
    return intList.map((innerList) {
      return innerList.map((value) {
        return value == 1;
      }).toList();
    }).toList();
  }

  @override
  void initState() {
    widget.manager.connect();
    // allStates = List.generate(
    //     Provider.of<AppData>(context, listen: false).lengthDevice + 2,
    //     (index) => List.filled(11, false),
    //   );
    // Subscribe to the MQTT topic
    ConnectMqtt();
  allStates = List.generate(
            3 + Provider.of<AppData>(context, listen: false).lengthDevice + 3,
            (index) => List.filled(11, false));
    super.initState();
    widget.manager.onMessageReceived = (message) {
      // Gọi setState để cập nhật trang
      //print("Quyền : $message");
      // print("Quyền : ${widget.manager.topic}");

      setState(() {
        String topic = widget.manager.topic;
        print("Quyền : ${topic[topic.length - 1]}");

        for (int i = 0; i < 11; i++) {
          allStates[int.parse(topic[topic.length - 1])][i] =
              widget.manager.currentState.getD(i);
        }
        _databaseReference
            .child('${widget.uid}/data/data${widget.chosehub}/data')
            .set(boolListToIntList(allStates));

        // print("Quyền : -- ${widget.manager.currentState.getd1}");
      });
    };

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
        settings3 = [];
        data.forEach(
          (key, value) {
            if (value != null && value is Map<dynamic, dynamic>) {
              if (value["location"] == widget.roomName) {
                settings3.add(
                  {
                    'type': value['type'].toString(),
                    'mac': value['mac'].toString(),
                    'name': value['name'].toString(),
                    'location': value['location'].toString(),
                    'panID': value['panID'].toString()
                  },
                );
              }
              ;
            }
          },
        );
        Device = [];
        settings3.sort((a, b) => a['mac'].compareTo(b['mac']));
        Provider.of<AppData>(context, listen: false)
            .setlengthDevice1(settings3.length);

        Device.addAll(settings3);
        print(
            "Quyeenf1 :${(Device[0]['panID'])[(Device[0]['panID']).length - 1]}");
      }
    });

    _databaseReference.child('${widget.uid}/device').onValue.listen((event) {
      if (event.snapshot != null) {
        DataSnapshot snapshot = event.snapshot as DataSnapshot;
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
        settings2 = [];
        data.forEach(
          (key, value) {
            if (value != null && value is Map<dynamic, dynamic>) {
              if (value.containsKey('mac') &&
                  value.containsKey('name') &&
                  value.containsKey('location') &&
                  value.containsKey('type') &&
                  value.containsKey('idHub') &&
                  value.containsKey('panID')) {
                if (value["idHub"] == widget.chosehub &&
                    value["location"] == widget.roomName) {
                  settings2.add(
                    {
                      'type': value['type'].toString(),
                      'mac': value['mac'].toString(),
                      'name': value['name'].toString(),
                      'location': value['location'].toString(),
                      'panID': value['panID'].toString()
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
            .setlengthDevice(settings2.length);
        // if (Provider.of<AppData>(context, listen: false).allStates == [[]]) {
        //   _databaseReference
        //       .child('${widget.uid}/data/data${widget.chosehub}/data')
        //       .set(boolListToIntList(allStates));
        //   Provider.of<AppData>(context, listen: false).updateAllStates(
        //       List.generate(
        //           3 + Provider.of<AppData>(context, listen: false).lengthDevice,
        //           (index) => List.filled(11, false)));
        // }
        // allStates = List.generate(
        //     3 + Provider.of<AppData>(context, listen: false).lengthDevice,
        //     (index) => List.filled(11, false));
        for (int i = 0; i < Device.length; i++) {
          print(
              "QUYỀN : ${Provider.of<AppData>(context, listen: false).lengthDevice}");
        }
        // Provider.of<AppData>(context, listen: false)
        //     .setlengthDevice1(settings2.length);
      }
    });
    _databaseReference.child('${widget.uid}/data').onValue.listen((event) {
      if (event.snapshot != null) {
        DataSnapshot snapshot = event.snapshot as DataSnapshot;
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
        settings1 = [];
        data.forEach(
          (key, value) {
            if (value != null && value is Map<dynamic, dynamic>) {
              if (value["idHub"] == widget.chosehub &&
                  value["room"] == widget.roomName) {
                settings1.add(
                  {'data': value['data'], 'idHub': value['idHub'].toString()},
                );
              }
              ;
            }
          },
        );
        List<List<bool>> check = [[]];
        for (int i = 0; i < settings1[0]['data'].length; i++) {
          for (int j = 0; j < 11; j++) {
            check[i][j] = (settings1[0]['data'])[i][j] == 0 ? false : true;
          }
        }
        print("Tam: ${check[2][3]}");
        
          allStates = check;
         // Provider.of<AppData>(context, listen: false).updateAllStates(check);
        

        // for (int i = 0; i < settings1[0]['data'].length; i++) {
        //   for (int j = 0; j < 11; j++) {
        //     Provider.of<AppData>(context, listen: false).updateAllStates(
        //         i, j, (settings1[0]['data'])[i][j] == 0 ? false : true);
        //     print("quyền : ${settings1[0]['data'][2][3]}");
        //     print("quyền: ${Provider.of<AppData>(context, listen: true).allStates}");
        //   }
        // }

        print("quyền : ${settings1[0]['data'][2][3]}");
        //Provider.of<AppData>(context, listen: false).updateAllStates(swap);
        //setState(() {
        //Provider.of<AppData>(context, listen: false).updateAllStates(swap);

        //allStates = intListToBoolList(settings1[0]['data']);
        // });
      }
    });
    
  }

  // void downloadData() {
  //   // Lấy intData từ Firebase
  //   List<List<bool>> data = intListToBoolList(intData);
  //   // Sử dụng dữ liệu
  //   // ...
  // }
  //   void uploadData(List<List<bool>> data) {
  //   List<List<int>> intData = boolListToIntList(data);
  //   // Gửi intData lên Firebase
  //   // ...
  // }
  void dispose() {
    super.dispose();
    // Gọi hàm chuyển đổi và gửi dữ liệu lên Firebase tại đây
    // _databaseReference
    //     .child('${widget.uid}/data/data${widget.chosehub}/data')
    //     .set(boolListToIntList(allStates));
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
                        isChecked: i > (settings3.length - 1)
                            ? allStates[int.parse((Device[i]
                                ['panID'])[(Device[i]['panID']).length - 1])][0]
                            : allStates[int.parse((Device[i]['panID'])[(Device[i]['panID']).length - 1])]
                                [i],
                        toggle: i > (settings3.length - 1)
                            ? () =>
                                toggle_d(int.parse((Device[i]['panID'])[(Device[i]['panID']).length - 1]), 0)
                            : () => toggle_d(int.parse((Device[i]['panID'])[(Device[i]['panID']).length - 1]), i)),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
