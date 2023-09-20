import 'package:flutter/material.dart';

class DeviceBox extends StatefulWidget {
  DeviceBox(
      {required this.title,
      required this.onLongPress,
      required this.onDelete,
      required this.type,
      required this.location});

  final String title;
  final VoidCallback onLongPress;
  final VoidCallback onDelete;
  final String type;
  final String location;

  @override
  _DeviceBoxState createState() => _DeviceBoxState();
}

class _DeviceBoxState extends State<DeviceBox> {
  bool isPressed = false;

  String getImagePath(String key) {
    switch (key) {
      case 'light':
        return 'assets/images/smart-light).png';
      case 'fan':
        return 'assets/images/fan.png';
      case 'TVremote':
        return 'assets/images/remote-control.png';
      // Add more cases as needed
      default:
        return 'assets/images/motherboard.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onLongPressUp: () {
        setState(() {
          isPressed = true;
        });
        widget.onLongPress();
      },
      child: Listener(
        onPointerUp: (PointerUpEvent event) {
          setState(() {
            isPressed = false;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, isPressed ? -10 : 0, 0),
          width: width / 2.5,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 8),
                blurRadius: 8,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!isPressed)
                Text(
                  '${widget.title}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              Image.asset(
                getImagePath(widget.type),
                width: 60,
                height: 48,
              ),
              if (!isPressed && widget.location != '0')
                Text(
                  '${widget.location}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (!isPressed && widget.location == '0')
                Text(
                  '',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              if (isPressed)
                Container(
                  width: 70,
                  height: 40,
                  child: GestureDetector(
                    onTap: widget.onDelete,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.delete,
                          color: Color.fromARGB(240, 233, 0, 0),
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
