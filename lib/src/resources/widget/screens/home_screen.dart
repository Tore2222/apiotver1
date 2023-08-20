import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../ServiceMQTT/MQTTManager.dart';
import 'apps.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.navigateToFivethPage,
    required this.navigateToSecondPageCallback,
  });
  final VoidCallback navigateToFivethPage;
  // final VoidCallback navigateToSecondPage;
  final VoidCallback navigateToSecondPageCallback;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MQTTManager _manager = MQTTManager();
  void upload(int data) {
    String jsonData = "{\"data\":$data}";
    try {
      _manager.publish(jsonData, "B4E62DB826BD_D");
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  void initState() {
    super.initState();
    // widget.manager.connect(); // Sử dụng widget.manager để truy cập MQTTManager

    _manager.connect(); // Kết nối với MQTT server
  }

  _HomeScreenState() {
    /// Init Alan Button with project key from Alan AI Studio
    AlanVoice.addButton(
        "112d58930d9579f9430a22fe21297be42e956eca572e1d8b807a3e2338fdd0dc/stage");
    buttonAlign:
    AlanVoice.BUTTON_ALIGN_LEFT;

    /// Handle commands from Alan AI Studio
    AlanVoice.onCommand.add((command) {
      debugPrint("got new command ${command.toString()}");
      // Xử lý các lệnh từ Alan AI Studio tại đây
      switch (command.data['command']) {
        case "turn 1":
          upload(1);
          break;
        case "turn 2":
          upload(2);
          break;
        case "turn 3":
          upload(4);
          break;
        case "turn 4":
          upload(8);
          break;
        case "turn all":
          upload(15);
          break;
        case "turn off all":
          upload(0);
          break;
      }
      // Dựa vào command để điều khiển các thiết bị trong phòng khách

      // Các lệnh khác tương tự
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // image: DecorationImage(
        //   opacity: 0.3,
        //   image: AssetImage("assets/images/apple_home.png"),
        //   fit: BoxFit.cover,
        // ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomLeft,
          colors: [
            Colors.white70,
            Colors.blue.shade200,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Home',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Quyền TW',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.black,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    // Xử lý khi người dùng nhấp vào Container
                    widget.navigateToFivethPage();
                  },
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(90),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(5),
                    child: Image.asset(
                      "assets/images/person.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Stack(
              children: [
                Container(
                  height: 110,
                  width: 350,
                  child: Material(
                    elevation: 8, // Độ nổi của container
                    borderRadius: BorderRadius.circular(20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/images/living_room.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: GestureDetector(
                    onTap: widget.navigateToSecondPageCallback,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Text(
                        "Living Room",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                Container(
                  height: 110,
                  width: 350,
                  child: Material(
                    elevation: 8, // Độ nổi của container
                    borderRadius: BorderRadius.circular(20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/images/bedroom.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Text(
                      "Bedroom",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                Container(
                  height: 110,
                  width: 350,
                  child: Material(
                    elevation: 8, // Độ nổi của container
                    borderRadius: BorderRadius.circular(20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/images/kitchen.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Text(
                      "Kitchen",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                Container(
                  height: 110,
                  width: 350,
                  child: Material(
                    elevation: 8, // Độ nổi của container
                    borderRadius: BorderRadius.circular(20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/images/outside.jpeg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Text(
                      "Outside",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
