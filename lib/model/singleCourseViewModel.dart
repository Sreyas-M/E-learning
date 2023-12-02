class UserModel {
  Data? data;

  UserModel({this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? userId;
  String? image;
  String? firstname;
  String? lastname;
  String? email;
  String? password;
  String? phone;
  String? address;

  Data(
      {this.userId,
        this.image,
        this.firstname,
        this.lastname,
        this.email,
        this.password,
        this.phone,
        this.address});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    image = json['image'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['image'] = this.image;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['address'] = this.address;
    return data;
  }
}
