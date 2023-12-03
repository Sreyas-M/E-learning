class ReplyModel {
  List<Data>? data;

  ReplyModel({this.data});

  ReplyModel.fromJson(Map<String, dynamic> json) {
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
  String? qId;
  String? queries;
  String? finalDate;
  String? reply;

  Data({this.qId, this.queries, this.finalDate, this.reply});

  Data.fromJson(Map<String, dynamic> json) {
    qId = json['q_id'];
    queries = json['queries'];
    finalDate = json['final_date'];
    reply = json['reply'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['q_id'] = this.qId;
    data['queries'] = this.queries;
    data['final_date'] = this.finalDate;
    data['reply'] = this.reply;
    return data;
  }
}
