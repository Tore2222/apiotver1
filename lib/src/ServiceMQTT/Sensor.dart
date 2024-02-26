// ignore_for_file: file_names

  class Sensor {
    final List<double>? temp;
    final List<double>? volt;
    //int data;
    String? idDevice;

    Sensor(
        {this.temp,
        this.volt,
        //  required this.data,
        this.idDevice});

    factory Sensor.fromJson(Map<String, dynamic> parsedJson) {
      var tempFromJson = parsedJson['temp'];
      List<double>? templist;
      if (tempFromJson != null) {
        templist = tempFromJson.cast<double>();
      }

      String? idDevice = parsedJson['idDevice'];

      var voltFromJson = parsedJson['volt'];
      List<double>? voltlist;
      if (voltFromJson != null) {
        voltlist = voltFromJson.cast<double>();
      }

      return Sensor(
        temp: templist,
        volt: voltlist,
        idDevice: idDevice,
      );
    }
  }

class Sensor2 {
   int? temp;
   int? humi;
  //int data;

  Sensor2(
      {this.temp,
      this.humi,
      //  required this.data,
      });

  factory Sensor2.fromJson(Map<String, dynamic> parsedJson) {
    int? temp = parsedJson['temp'];

    int? humi = parsedJson['humi'];

    return Sensor2(
      temp: temp,
      humi: humi,
    );
  }
}

class Sensor1 {
  int? data;

  Sensor1({
    this.data,
  });

  factory Sensor1.fromJson(Map<String, dynamic> parsedJson) {
    int? data = parsedJson['data'];

    return Sensor1(
      data: data,
    );
  }
}
