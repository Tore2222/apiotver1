import 'package:flutter/cupertino.dart';

class AppData with ChangeNotifier {
  String uid = '';
  List<List<bool>> allStates = [[]]; // Khởi tạo mảng trạng thái
  void updateAllStates(List<List<bool>> a) {
    allStates = a;
    notifyListeners(); // Thông báo cho các người nghe về sự thay đổi
  }

  void setUid(String newUid) {
    uid = newUid;
    notifyListeners(); // Thông báo rằng giá trị đã thay đổi
  }

  String ChoseHub = '';
  void setChoseHub(String newChoseHub) {
    ChoseHub = newChoseHub;
    notifyListeners(); // Thông báo rằng giá trị đã thay đổi
  }

  int lengthDevice1 = 0;
  void setlengthDevice1(int newlengthDevice1) {
    lengthDevice1 = newlengthDevice1;
    notifyListeners(); // Thông báo rằng giá trị đã thay đổi
  }

  int lengthDevice = 0;
  void setlengthDevice(int newlengthDevice) {
    lengthDevice = newlengthDevice;
    notifyListeners(); // Thông báo rằng giá trị đã thay đổi
  }

  int totalDevice = 0;
  void settotalDevice(int newtotalDevice) {
    totalDevice = newtotalDevice;
    notifyListeners(); // Thông báo rằng giá trị đã thay đổi
  }
}
