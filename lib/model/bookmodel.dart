class BookModel {
  String RoomeNo;
  String From;
  String to;
  String Date;
  String Type;
  int? id;

  BookModel({
    required this.RoomeNo,
    required this.From,
    required this.to,
    required this.Type,
    required this.Date,
  });

  Map<String, dynamic> toJsone(id) => {
        'Roomno': RoomeNo,
        'From': From,
        'To': to,
        'Date': Date,
        'Type': Type,
      };

  factory BookModel.fromJason(Map<String, dynamic> json) {
    return BookModel(
        RoomeNo: json['Roomno'],
        From: json['From'],
        to: json['To'],
        Date: json['Date'],
        Type: json['Type']);
  }
}
