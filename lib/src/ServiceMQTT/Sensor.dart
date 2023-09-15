// ignore_for_file: file_names

class Sensor {
  final List<double> temp;
  final List<double> volt;
  //int data;
  String idDevice;

  Sensor(
      {required this.temp,
      required this.volt,
      //  required this.data,
      required this.idDevice});

  factory Sensor.fromJson(Map<String, dynamic> parsedJson) {
    var tempFromJson = parsedJson['temp'];
    //print(streetsFromJson.runtimeType);
    // List<String> streetsList = new List<String>.from(streetsFromJson);
    List<double> templist = tempFromJson.cast<double>();
    //int data = parsedJson['data'];
    String idDevice = parsedJson['idDevice'];
    var voltFromJson = parsedJson['volt'];
    //print(streetsFromJson.runtimeType);
    // List<String> streetsList = new List<String>.from(streetsFromJson);
    List<double> voltlist = voltFromJson.cast<double>();

    return Sensor(
        temp: templist,
        volt: voltlist,
        //data: data,
        idDevice: idDevice);
  }
}

class Sensor1 {
  int data;

  Sensor1({
    required this.data,
  });

  factory Sensor1.fromJson(Map<String, dynamic> parsedJson) {
    int data = parsedJson['data'];

    return Sensor1(
      data: data,
    );
  }
}
