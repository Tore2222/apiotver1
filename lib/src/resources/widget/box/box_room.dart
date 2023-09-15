import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RoomBox extends StatefulWidget {
  RoomBox({
    required this.title,
    required this.onLongPress,
    required this.onDelete,
  });

  final String title;
  final VoidCallback onLongPress;
  final VoidCallback onDelete;

  @override
  _RoomBoxState createState() => _RoomBoxState();
}

class _RoomBoxState extends State<RoomBox> {
  bool isPressed = false;

  File? backgroundImage; // Thêm biến để lưu trữ ảnh nền

  // Future<void> _pickImage() async {
  //   final picker = ImagePicker();
  //   final pickedImage = await picker.pickImage(source: ImageSource.gallery);

  //   if (pickedImage != null) {
  //     setState(() {
  //       backgroundImage = File(pickedImage.path);
  //     });
  //   } else {
  //     setState(() {
  //       backgroundImage = null;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: (width - 80) / 2,
      height: width * 0.5 - 25 - 15,
      child: GestureDetector(
        onLongPressUp: () {
          setState(() {
            isPressed = true;
          });
          widget.onLongPress();
        },
        //onDoubleTap: () {
        // _pickImage();
        //},
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
              color: Colors.blue[50],
              image: backgroundImage != null
                  ? DecorationImage(
                      image: FileImage(backgroundImage!),
                      fit: BoxFit.cover,
                    )
                  : null,
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
                  'assets/images/Room.png',
                  width: 60,
                  height: 48,
                ),
                if (isPressed)
                  Container(
                    width: 70,
                    height: 40,
                    child: GestureDetector(
                      onTap: widget.onDelete,
                      child: Container(
                        decoration: BoxDecoration(
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
      ),
    );
  }
}
