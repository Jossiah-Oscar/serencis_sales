// ignore_for_file: prefer_collection_literals, unnecessary_this

class Visit {
  String? companyName;
  String? number;
  String? hostName;
  String? reason;
  String? streetName;
  String? checkInTime;
  String? checkOutTime;
  String? uID;
  String? documentID;
  String? openingStock;
  String? closingStock;
  List<String>? picture;

  Visit(
      {this.companyName,
      this.number,
      this.hostName,
      this.reason,
      this.streetName,
      this.checkInTime,
      this.checkOutTime,
      this.uID,
      this.documentID,
      this.openingStock,
      this.closingStock,
      this.picture});

  Visit.fromJson(Map<String, dynamic> json) {
    companyName = json['Company Name'];
    number = json['Number'];
    hostName = json['Host Name'];
    reason = json['Reason'];
    streetName = json['Street Name'];
    checkInTime = json['CheckInTime'];
    checkOutTime = json['CheckOutTime'];
    uID = json['UID'];
    documentID = json['Document ID'];
    openingStock = json['Opening Stock'];
    closingStock = json['Closing Stock'];
    picture = json['Picture'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['Company Name'] = this.companyName;
    data['Number'] = this.number;
    data['Host Name'] = this.hostName;
    data['Reason'] = this.reason;
    data['Street Name'] = this.streetName;
    data['CheckInTime'] = this.checkInTime;
    data['CheckOutTime'] = this.checkOutTime;
    data['UID'] = this.uID;
    data['Document ID'] = this.documentID;
    data['Opening Stock'] = this.openingStock;
    data['Closing Stock'] = this.closingStock;
    data['Picture'] = this.picture;
    return data;
  }
}
