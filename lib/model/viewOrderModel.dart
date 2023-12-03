class OrderModel {
  List<Data>? data;

  OrderModel({this.data});

  OrderModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? firstname;
  String? userId;
  String? lastname;
  String? email;
  String? courseId;
  String? author;
  String? price;
  String? image1;
  String? oId;
  String? date;

  Data(
      {this.firstname,
        this.userId,
        this.lastname,
        this.email,
        this.courseId,
        this.author,
        this.price,
        this.image1,
        this.oId,
        this.date});

  Data.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    userId = json['user_id'];
    lastname = json['lastname'];
    email = json['email'];
    courseId = json['course_id'];
    author = json['author'];
    price = json['price'];
    image1 = json['image1'];
    oId = json['o_id'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['user_id'] = this.userId;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['course_id'] = this.courseId;
    data['author'] = this.author;
    data['price'] = this.price;
    data['image1'] = this.image1;
    data['o_id'] = this.oId;
    data['date'] = this.date;
    return data;
  }
}
