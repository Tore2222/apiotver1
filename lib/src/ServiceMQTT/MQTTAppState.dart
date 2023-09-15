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
  double hum = 0;
  double temp = 0;
  double volt = 0;
  double current = 0;
  double power = 0;
  int data = 0;
  String idDevice = '';
  bool d1 = false;
  bool d2 = false;
  bool d3 = false;
  bool d4 = false;
  bool d5 = false;
  bool d6 = false;
  bool d7 = false;
  bool d8 = false;
  bool d9 = false;

  bool d10 = false;
  bool d11 = false;
  bool d12 = false;
  bool d13 = false;
  bool d14 = false;
  bool d15 = false;

  ConvertToBool(int data) {
    if ((data & 1) > 0) {
      d1 = true;
    } else {
      d1 = false;
    }
    if ((data & 2) > 0) {
      d2 = true;
    } else {
      d2 = false;
    }
    if ((data & 4) > 0) {
      d3 = true;
    } else {
      d3 = false;
    }
    if ((data & 8) > 0) {
      d4 = true;
    } else {
      d4 = false;
    }
    if ((data & 16) > 0) {
      d5 = true;
    } else {
      d5 = false;
    }
    if ((data & 32) > 0) {
      d6 = true;
    } else {
      d6 = false;
    }
    if ((data & 64) > 0) {
      d7 = true;
    } else {
      d7 = false;
    }
    if ((data & 128) > 0) {
      d8 = true;
    } else {
      d8 = false;
    }
    if ((data & 256) > 0) {
      d9 = true;
    } else {
      d9 = false;
    }
    if ((data & 512) > 0) {
      d10 = true;
    } else {
      d10 = false;
    }
    if ((data & 1024) > 0) {
      d11 = true;
    } else {
      d11 = false;
    }
    if ((data & 2048) > 0) {
      d12 = true;
    } else {
      d12 = false;
    }
    if ((data & 4096) > 0) {
      d13 = true;
    } else {
      d13 = false;
    }
    if ((data & 8192) > 0) {
      d14 = true;
    } else {
      d14 = false;
    }
    if ((data & 16384) > 0) {
      d15 = true;
    } else {
      d15 = false;
    }
  }

  void setReceivedText(String text) {
    _receivedText = text;
    // _historyText = _historyText + '\n' + _receivedText;
    final json = jsonDecode(text);
    final sensor = Sensor.fromJson(json);
    final sensor1 = Sensor1.fromJson(json);

    idDevice = sensor.idDevice;
    data = sensor1.data;
    hum = sensor.temp[1];
    temp = sensor.temp[0];
    volt = sensor.volt[0];
    current = sensor.volt[1];
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

  double get gettemp => temp;
  double get gethum => hum;
  double get getvolt => volt;
  double get getcurrent => current;
  double get getPower => power;
  String get getReceivedText => _receivedText;
  String get getHistoryText => _historyText;
  int get getdata => data;
  String get getidDevice => idDevice;
  bool get getd1 => d1;
  bool get getd2 => d2;
  bool get getd3 => d3;
  bool get getd4 => d4;
  bool get getd5 => d5;
  bool get getd6 => d6;
  bool get getd7 => d7;
  bool get getd8 => d8;
  bool get getd9 => d9;
  bool get getd10 => d10;
  bool get getd11 => d11;
  bool get getd12 => d12;
  bool get getd13 => d13;
  bool get getd14 => d14;
  bool get getd15 => d15;

  MQTTAppConnectionState get getAppConnectionState => _appConnectionState;
}

double roundDouble(num value, num places) {
  num mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}
