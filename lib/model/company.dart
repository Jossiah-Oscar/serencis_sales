class Company {
  String? companyName;
  int? number;
  String? personMet;
  int? longitude;
  int? latitude;
  int? time;

  Company(
      {this.companyName,
      this.number,
      this.personMet,
      this.longitude,
      this.latitude,
      this.time});

  Company.fromJson(Map<String, dynamic> json) {
    companyName = json['Company Name'];
    number = json['Number'];
    personMet = json['Person Met'];
    longitude = json['Longitude'];
    latitude = json['Latitude'];
    time = json['Time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Company Name'] = this.companyName;
    data['Number'] = this.number;
    data['Person Met'] = this.personMet;
    data['Longitude'] = this.longitude;
    data['Latitude'] = this.latitude;
    data['Time'] = this.time;
    return data;
  }
}
