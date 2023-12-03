class SingleCourseView {
  Data? data;

  SingleCourseView({this.data});

  SingleCourseView.fromJson(Map<String, dynamic> json) {
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
  String? courseId;
  String? name;
  String? image1;
  String? vidname;
  String? author;
  String? topicfir;
  String? topicsec;
  String? topicthird;
  String? topicfour;
  String? price;
  String? description;

  Data(
      {this.courseId,
        this.name,
        this.image1,
        this.vidname,
        this.author,
        this.topicfir,
        this.topicsec,
        this.topicthird,
        this.topicfour,
        this.price,
        this.description});

  Data.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    name = json['name'];
    image1 = json['image1'];
    vidname = json['vidname'];
    author = json['author'];
    topicfir = json['topicfir'];
    topicsec = json['topicsec'];
    topicthird = json['topicthird'];
    topicfour = json['topicfour'];
    price = json['price'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_id'] = this.courseId;
    data['name'] = this.name;
    data['image1'] = this.image1;
    data['vidname'] = this.vidname;
    data['author'] = this.author;
    data['topicfir'] = this.topicfir;
    data['topicsec'] = this.topicsec;
    data['topicthird'] = this.topicthird;
    data['topicfour'] = this.topicfour;
    data['price'] = this.price;
    data['description'] = this.description;
    return data;
  }
}
