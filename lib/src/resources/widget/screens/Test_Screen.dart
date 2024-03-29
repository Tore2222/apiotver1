//import 'package:alan_voice/alan_voice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iotappver1/src/ServiceMQTT/MQTTManager.dart';
import 'package:iotappver1/src/ServiceMQTT/variable_app.dart';
import 'package:iotappver1/src/resources/dialog/msg_dilog.dart';
import 'package:iotappver1/src/resources/widget/box/box_device.dart';
import 'package:iotappver1/src/resources/widget/box/box_room.dart';
import 'package:iotappver1/src/resources/widget/box/boxhub.dart';
import 'package:iotappver1/src/resources/widget/thungrac/qr.dart';
import 'package:provider/provider.dart';

import '../box/addbutton.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child('users');
  final MQTTManager _manager = MQTTManager();
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController controller = TextEditingController();

  List<Map<String, dynamic>> Hub = [];
  List<Map<String, dynamic>> Device = [];
  List<Map<String, dynamic>> Room = [];
  Map<String, dynamic> jsonDataCam = {};

  String uid = '';
  int admin = 1;
  String ChoseHub = '';

  String NameChoseHub = '';
  int selectedHubIndex = -1;
  String name = '';
  bool isCodeMatched = false;
  void uploadDevice(String data) {
    String jsonData = "{\"idDevice\":$data}";
    try {
      _manager.publish(jsonData, "94B5552C6778_D_0000");
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  void ConnectMqtt() {
    // Future.delayed(
    //     const Duration(microseconds: 100), () => widget.manager.connect());
    Future.delayed(const Duration(seconds: 1),
        () => _manager.subScribeTo("94B5552C6778_A_0000")

        // widget.manager.subScribeTo("94B5552C6778_A_0001");
        // widget.manager.subScribeTo("94B5552C6778_A_0002");
        );
    print("Quyeefn11 : ${_manager.currentState.getidDevice}");
  }

  void updateRoomList() {
    _databaseReference.child('$uid/room${ChoseHub}').onValue.listen((event) {
      if (event.snapshot != null) {
        DataSnapshot snapshot = event.snapshot as DataSnapshot;
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

        List<Map<String, dynamic>> settings3 = [];

        data.forEach(
          (key, value) {
            if (value != null && value is Map<dynamic, dynamic>) {
              if (value.containsKey('name')) {
                settings3.add(
                  {
                    'name': value['name'].toString(),
                  },
                );
              }
              ;
            }
          },
        );
        setState(() {
          Room = settings3;
        });
      }
    });
  }

  void updateDeviceList() {
    _databaseReference.child('$uid/device').onValue.listen((event) {
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
                  value.containsKey('location')) {
                if (value["idHub"] == ChoseHub) {
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
            }
          },
        );
        setState(() {
          Device = settings2;
        });
      }
    });
  }

  @override
  void initState() {
    _manager.connect();
    ConnectMqtt();
    _manager.onMessageReceived = (message) {
      // Gọi setState để cập nhật trang
      //print("Quyền : $message");
      // print("Quyền : ${widget.manager.topic}");

      setState(() {
        String topic = _manager.topic;
        print("Quyeefn11 : $message");
        print("Quyền11 : ${_manager.currentState.getidDevice}");
      });
    }; // print("Quyền : -- ${widget.manager.currentState.getd1}");

    User? user = auth.currentUser;
    if (user != null && admin == 1) {
      uid = user.uid;
      print("User UID: $uid");
    } else {
      print("User is not logged in.");
    }
    Provider.of<AppData>(context, listen: false).setUid(uid);
    // _databaseReference.child('$uid').onValue.listen((event) {
    //   if (event.snapshot != null) {
    //     DataSnapshot snapshot = event.snapshot as DataSnapshot;
    //     Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
    //     setState(() {});
    //   }
    // });
    ChoseHub = Provider.of<AppData>(context, listen: false).ChoseHub;
    _databaseReference.child('$uid/hub').onValue.listen((event) {
      if (event.snapshot != null) {
        DataSnapshot snapshot = event.snapshot as DataSnapshot;
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

        List<Map<String, dynamic>> settings1 = [];

        data.forEach(
          (key, value) {
            if (value != null && value is Map<dynamic, dynamic>) {
              if (value.containsKey('mac') && value.containsKey('name')) {
                settings1.add(
                  {
                    'mac': value['mac'],
                    'name': value['name'],
                  },
                );
              }
              ;
            }
          },
        );
        setState(() {
          Hub = settings1;
        });
      } else {
        Hub = [];
      }
    });

    _databaseReference.child('$uid/device').onValue.listen((event) {
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
                  value.containsKey('location')) {
                if (value["idHub"] == ChoseHub) {
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
        setState(() {
          Device = settings2;
        });
      }
    });
    _databaseReference.child('$uid/room$ChoseHub').onValue.listen((event) {
      if (event.snapshot != null) {
        DataSnapshot snapshot = event.snapshot as DataSnapshot;
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

        List<Map<String, dynamic>> settings3 = [];

        data.forEach(
          (key, value) {
            if (value != null && value is Map<dynamic, dynamic>) {
              if (value.containsKey('name')) {
                settings3.add(
                  {
                    'name': value['name'].toString(),
                  },
                );
              }
              ;
            }
          },
        );
        setState(() {
          Room = settings3;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: width,
        height: MediaQuery.of(context).size.height,
        color: Colors.green,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/smart-house.png",
                    width: 40,
                    height: 40,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  StreamBuilder(
                    stream: _databaseReference.child('$uid/name').onValue,
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.data != null &&
                          snapshot.data!.snapshot.value != null) {
                        var name = snapshot.data!.snapshot.value;
                        return Text(
                          "Welcome Home,\n $name",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      } else {
                        return Text(
                          "Loading...",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          offset: const Offset(0, 0),
                          blurRadius: 4.0,
                          spreadRadius: 0)
                    ]),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //HUB
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('Hub',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400)),
                          const Spacer(),
                          InkWell(
                              onTap: () async {
                                // Gọi màn hình QRScreen và nhận giá trị result.code khi pop về
                                jsonDataCam = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const QRScreen(),
                                  ),
                                );
                                if (jsonDataCam['hub'] != null &&
                                    jsonDataCam['hub'].isNotEmpty) {
                                  ChoseHub = jsonDataCam['hub'];
                                  _databaseReference
                                      .child(
                                          '$uid/hub/id${jsonDataCam['hub']}/mac')
                                      .set(jsonDataCam['hub']);
                                  _databaseReference
                                      .child(
                                          '$uid/hub/id${jsonDataCam['hub']}/name')
                                      .set('Hub ${Hub.length}');
                                  _databaseReference
                                      .child(
                                          '$uid/room${ChoseHub}/idInSide/name')
                                      .set("InSide");
                                  _databaseReference
                                      .child(
                                          '$uid/room${ChoseHub}/idOutSide/name')
                                      .set("OutSide");

                                  //   }
                                  // }

                                  // Do something with the code
                                } else {
                                  MsgDialog.showMsgDialog1(
                                      context, "Can't find Hub");
                                }
                              },
                              child: const Icon(
                                Icons.add,
                                color: Colors.black,
                                size: 20,
                              ))
                        ],
                      ),
                      Hub.length != 0
                          ? SizedBox(
                              width: width,
                              height: width * 0.5 - 25,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                itemCount: Hub.length,
                                itemBuilder: (BuildContext context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(
                                        right: 15), // Đặt khoảng cách bên phải
                                    child: HubBox(
                                      title: Hub[index]['name'],
                                      doubleTab: () {
                                        selectedHubIndex = index;
                                        Provider.of<AppData>(context,
                                                listen: false)
                                            .setChoseHub(ChoseHub);
                                        setState(() {
                                          updateRoomList();
                                          ChoseHub = Hub[index]['mac'];
                                          _databaseReference
                                              .child('$uid/ChoseHub')
                                              .set(ChoseHub);
                                          NameChoseHub = Hub[index]['name'];
                                        });
                                        updateDeviceList();
                                        updateRoomList();
                                      },
                                      isSelected: selectedHubIndex == index,
                                      onLongPress: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            TextEditingController
                                                newTitleController =
                                                TextEditingController();
                                            return AlertDialog(
                                              title:
                                                  const Text('Change Name Hub'),
                                              content: TextField(
                                                controller: newTitleController,
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .labelLarge,
                                                  ),
                                                  child: const Text('Cancel'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .labelLarge,
                                                  ),
                                                  child: const Text('Save'),
                                                  onPressed: () {
                                                    String newTitle =
                                                        newTitleController.text;
                                                    if (newTitle.isNotEmpty) {
                                                      // Update the hub title in your database or state management logic
                                                      _databaseReference
                                                          .child(
                                                              '$uid/hub/id${Hub[index]['mac']}/name')
                                                          .set(newTitle);

                                                      Navigator.of(context)
                                                          .pop(); // Close the dialog
                                                    }
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      onDelete: () {
                                        if (Hub.length == 1) {
                                          _databaseReference
                                              .child(
                                                  '$uid/hub/id${Hub[index]['mac']}')
                                              .remove();
                                          Hub = [];
                                          setState(() {});
                                        } else {
                                          _databaseReference
                                              .child(
                                                  '$uid/hub/id${Hub[index]['mac']}')
                                              .remove();
                                        }
                                      },
                                    ),
                                  );
                                },
                              ))
                          : const SizedBox(
                              height: 40,
                            ),
                      //SizedBox(height: 10),
                      Row(
                        /// DEVICE
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('End Device',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400)),
                          const Spacer(),
                          InkWell(
                            onTap: () async {
                              // Gọi màn hình QRScreen và nhận giá trị result.code khi pop về
                              jsonDataCam = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const QRScreen(),
                                ),
                              );
                              if (ChoseHub != '') {
                                uploadDevice(jsonDataCam['device']);
                                await Future.delayed(Duration(seconds: 8));
                                print(
                                    "Quyền11: ${_manager.currentState.getidDevice}");

                                if (_manager.currentState.getidDevice != "") {
                                  if (jsonDataCam['device'] != null &&
                                      jsonDataCam['device'].isNotEmpty &&
                                      jsonDataCam['type'] != null &&
                                      jsonDataCam['type'].isNotEmpty) {
                                    Provider.of<AppData>(context, listen: false)
                                        .setlengthDevice(Device.length + 1);
                                    _databaseReference
                                        .child(
                                            '$uid/device/id${jsonDataCam['device']}/idHub')
                                        .set(ChoseHub);
                                    _databaseReference
                                        .child(
                                            '$uid/device/id${jsonDataCam['device']}/location')
                                        .set('');
                                    _databaseReference
                                        .child(
                                            '$uid/device/id${jsonDataCam['device']}/type')
                                        .set(jsonDataCam['type']);
                                    _databaseReference
                                        .child(
                                            '$uid/device/id${jsonDataCam['device']}/mac')
                                        .set(jsonDataCam['device']);
                                    _databaseReference
                                        .child(
                                            '$uid/device/id${jsonDataCam['device']}/name')
                                        .set('Device ${Device.length}');
                                    _databaseReference
                                        .child(
                                            '$uid/device/id${jsonDataCam['device']}/panID')
                                        .set(
                                            "${(Device.length + 3).toString().padLeft(4, '0')}");

                                    //   }
                                    // }

                                    // Do something with the code
                                  } else {
                                    MsgDialog.showMsgDialog1(
                                        context, "Can't find Device");
                                  }
                                } else
                                  (MsgDialog.showMsgDialog1(context,
                                      "Out of converage area , plese try again"));
                              } else {
                                MsgDialog.showMsgDialog1(
                                    context, "Plese chose Hub first");
                              }
                            },
                            child: const Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Device.length != 0
                          ? SizedBox(
                              width: width,
                              height: width * 0.5 - 25,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                itemCount: Device.length,
                                itemBuilder: (BuildContext context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(
                                        right: 15), // Đặt khoảng cách bên phải
                                    child: DeviceBox(
                                      title: Device[index]['name'],
                                      type: Device[index]['type'],
                                      location: Device[index]['location'],
                                      onLongPress: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            TextEditingController
                                                newTitleController =
                                                TextEditingController();
                                            TextEditingController
                                                newLocationController =
                                                TextEditingController(); // Thêm controller cho location
                                            newTitleController.text = Device[
                                                    index][
                                                'name']; // Giá trị ban đầu cho newTitleController
                                            newLocationController.text =
                                                Device[index]['location'];
                                            return AlertDialog(
                                              title: const Text(
                                                  'Change Name-Location Device'),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextField(
                                                    controller:
                                                        newTitleController,
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText:
                                                                'New Name'),
                                                  ),
                                                  TextField(
                                                    controller:
                                                        newLocationController,
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText:
                                                                'New Location'), // Thêm trường location
                                                  ),
                                                ],
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('Cancel'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: const Text('Save'),
                                                  onPressed: () {
                                                    String newTitle =
                                                        newTitleController.text;
                                                    String newLocation =
                                                        newLocationController
                                                            .text; // Lấy giá trị location từ controller
                                                    if (newTitle.isNotEmpty) {
                                                      // Update the hub title and location in your database or state management logic
                                                      _databaseReference
                                                          .child(
                                                              '$uid/device/id${Device[index]['mac']}/name')
                                                          .set(newTitle);
                                                      _databaseReference
                                                          .child(
                                                              '$uid/device/id${Device[index]['mac']}/location')
                                                          .set(
                                                              newLocation); // Lưu location

                                                      Navigator.of(context)
                                                          .pop(); // Close the dialog
                                                    }
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      onDelete: () {
                                        if (Device.length == 1) {
                                          _databaseReference
                                              .child(
                                                  '$uid/device/id${Device[index]['mac']}')
                                              .remove();
                                          Device = [];
                                          setState(() {});
                                        } else {
                                          _databaseReference
                                              .child(
                                                  '$uid/device/id${Device[index]['mac']}')
                                              .remove();
                                        }
                                      },
                                    ),
                                  );
                                },
                              ))
                          : const SizedBox(
                              height: 20,
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('Rooms',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400)),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  TextEditingController newTitleController =
                                      TextEditingController();

                                  return AlertDialog(
                                    title: const Text('Add Room'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          controller: newTitleController,
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      //IconButton(onPressed: onPressed, icon: icon)
                                      TextButton(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('Save'),
                                        onPressed: () {
                                          String newTitle =
                                              newTitleController.text;

                                          if (newTitle.isNotEmpty) {
                                            // Update the hub title and location in your database or state management logic
                                            _databaseReference
                                                .child(
                                                    '$uid/room$ChoseHub/id${newTitle}/name')
                                                .set(newTitle);
                                            if (ChoseHub != '') {
                                              _databaseReference
                                                  .child(
                                                      '$uid/room$ChoseHub/id${newTitle}/name')
                                                  .set(newTitle);
                                            } else {
                                              MsgDialog.showMsgDialog1(
                                                  context, "Chose hub first");
                                            }
                                            Navigator.of(context)
                                                .pop(); // Close the dialog
                                          }
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Wrap(spacing: 30, runSpacing: 30, children: [
                          for (int i = 0; i < Room.length; i++)
                            RoomBox(
                              title: Room[i]['name'],
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    TextEditingController newTitleController =
                                        TextEditingController();
                                    return AlertDialog(
                                      title: const Text('Change Name Room'),
                                      content: TextField(
                                        controller: newTitleController,
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ),
                                          child: const Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ),
                                          child: const Text('Save'),
                                          onPressed: () {
                                            String newTitle =
                                                newTitleController.text;
                                            if (newTitle.isNotEmpty) {
                                              // Update the hub title in your database or state management logic
                                              _databaseReference
                                                  .child(
                                                      '$uid/room$ChoseHub/id${Room[i]['name']}/name')
                                                  .set(newTitle);

                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              onDelete: () {
                                if (Room[i]['name'] != "InSide" &&
                                    Room[i]['name'] != "OutSide") {
                                  _databaseReference
                                      .child(
                                          '$uid/room$ChoseHub/id${Room[i]['name']}')
                                      .remove();

                                  // MsgDialog.showMsgDialog1(
                                  //     context, "$uid/id${Room[i]['name']}");
                                  setState(() {});
                                } else {
                                  MsgDialog.showMsgDialog1(
                                      context, "This can't be deleted");
                                }
                                ;
                              },
                            )
                        ]),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
