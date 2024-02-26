// ignore_for_file: file_names

import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';

import 'Sensor.dart';

enum MQTTAppConnectionState {
  connected,
  disconnected,
  connecting,
  connectedSubscribed,
  connectedUnSubscribed
}

class MQTTAppState {
  MQTTAppConnectionState _appConnectionState =
      MQTTAppConnectionState.disconnected;
  FirebaseAuth auth = FirebaseAuth.instance;
  String _receivedText = '';
  String _historyText = '';
  int hum = 0;
  int temp = 0;
  double volt = 0;
  double current = 0;
  double power = 0;
  int data = 0;
  String idDevice = 'No';
  List<bool> d = List.filled(15, false);

  void ConvertToBool(int data) {
    for (int i = 0; i < 15; i++) {
      d[i] = (data & (1 << i)) > 0;
    }
  }

  void setReceivedText(String text) {
    _receivedText = text;
    // _historyText = _historyText + '\n' + _receivedText;
    final json = jsonDecode(text);
    // final sensor = Sensor.fromJson(json);
    final sensor1 = Sensor1.fromJson(json);
    final sensor2 = Sensor2.fromJson(json);

    // print("Humi: ${sensor.temp?[0]}");
    // idDevice = sensor.idDevice ?? "No";
    data = sensor1.data ?? -1;
    hum = sensor2.humi ?? -1;
    temp = sensor2.temp ?? -1;
    // volt = sensor.volt?[0] ?? 0;
    // current = sensor.volt?[1] ?? 0;
    power = roundDouble((volt * current) / 1000, 5);
    ConvertToBool(data);
    print('Humi: $hum'); // Hiển thị giá trị humi lên debug console
  }

  void setAppConnectionState(MQTTAppConnectionState state) {
    _appConnectionState = state;
  }

  void clearText() {
    _historyText = "";
    _receivedText = "";
  }

  int get gettemp => temp;
  int get gethum => hum;
  double get getvolt => volt;
  double get getcurrent => current;
  double get getPower => power;
  String get getReceivedText => _receivedText;
  String get getHistoryText => _historyText;
  int get getdata => data;
  String get getidDevice => idDevice;

  bool getD(int index) {
    return d[index];
  }

  MQTTAppConnectionState get getAppConnectionState => _appConnectionState;
}

double roundDouble(num value, num places) {
  num mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}
