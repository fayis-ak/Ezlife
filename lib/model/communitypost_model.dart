class CommunityModel {
  String postname;
  String postimage;
  String postDiscription;
  String? id;

  CommunityModel({
    required this.postname,
    required this.postimage,
    required this.postDiscription,
    this.id,
  });

  Map<String, dynamic> tojsone(idd) => {
        'postname': postname,
        'postimage': postimage,
        'postdiscription': postDiscription,
        'id': idd,
      };

  factory CommunityModel.fromjasone(Map<String, dynamic> jsone) {
    return CommunityModel(
      postname: jsone['postname'],
      postimage: jsone['postimage'],
      postDiscription: jsone['postdiscription'],
      id: jsone['id'],
    );
  }
}
