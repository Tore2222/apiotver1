import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IoTDeviceControlWidget extends StatefulWidget {
  final String imagePath;
  final String text;
  final VoidCallback onPressed;
  final String room;
  final VoidCallback onDelete;

  const IoTDeviceControlWidget({
    required this.text,
    required this.imagePath,
    required this.onPressed,
    required this.room,
    required this.onDelete,
  });

  @override
  _IoTDeviceControlWidgetState createState() => _IoTDeviceControlWidgetState();
}

class _IoTDeviceControlWidgetState extends State<IoTDeviceControlWidget> {
  bool isPressed = false;

  void togglePressed() {
    setState(() {
      isPressed = !isPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 225, 227, 237),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isPressed
              ? Color.fromARGB(255, 86, 227, 107)
              : Colors.transparent,
          width: 2,
        ),
      ),
      //color: isPressed ? Colors.red : const Color.fromARGB(255, 50, 116, 149),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(widget.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 25),
              Expanded(
                child: Text(
                  widget.text,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  widget.room,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: const Color.fromARGB(137, 69, 65, 65),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              // IconButton(
              //   icon: Icon(Icons.delete),
              //   onPressed: widget.onDelete,
              // ),
              IconButton(
                icon: Icon(
                  Icons.power_settings_new,
                  color: isPressed ? Colors.red : Colors.white,
                ),
                onPressed: () {
                  togglePressed();
                  widget.onPressed();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
