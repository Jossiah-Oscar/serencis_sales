class Visit {
  String? companyName;
  String? number;
  String? hostName;
  String? reason;
  String? longitude;
  String? latitude;
  String? checkInTime;
  String? checkOutTime;
  String? uID;

  Visit(
      {this.companyName,
      this.number,
      this.hostName,
      this.reason,
      this.longitude,
      this.latitude,
      this.checkInTime,
      this.checkOutTime,
      this.uID, latiTude});

  Visit.fromJson(Map<String, dynamic> json) {
    companyName = json['Company Name'];
    number = json['Number'];
    hostName = json['Host Name'];
    reason = json['Reason'];
    longitude = json['Longitude'];
    latitude = json['Latitude'];
    checkInTime = json['CheckInTime'];
    checkOutTime = json['CheckOutTime'];
    uID = json['UID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Company Name'] = this.companyName;
    data['Number'] = this.number;
    data['Host Name'] = this.hostName;
    data['Reason'] = this.reason;
    data['Longitude'] = this.longitude;
    data['Latitude'] = this.latitude;
    data['CheckInTime'] = this.checkInTime;
    data['CheckOutTime'] = this.checkOutTime;
    data['UID'] = this.uID;
    return data;
  }
}
