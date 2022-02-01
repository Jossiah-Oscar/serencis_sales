class User {
  String? name;
  String? email;
  String? role;
  bool? present;
  String? uID;

  User({this.name, this.email, this.role, this.present, this.uID});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    role = json['role'];
    present = json['present'];
    uID = json['UID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['role'] = this.role;
    data['present'] = this.present;
    data['UID'] = this.uID;
    return data;
  }
}
