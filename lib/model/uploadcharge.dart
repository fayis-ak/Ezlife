class UploadCharge {
  int monthlerent;
  int maintance;
  int utility;
  String flore;
  String room;
  String? id;

  UploadCharge({
    required this.monthlerent,
    required this.maintance,
    required this.utility,
    required this.flore,
    required this.room,
    this.id,
  });

  Map<String, dynamic> tojsone(idd) => {
        'MonthlyRent': monthlerent,
        'Maintance': maintance,
        'Utility': utility,
        'Flore': flore,
        'Room': room,
        'id': idd,
      };
  factory UploadCharge.fromjsone(Map<String, dynamic> jsone) {
    return UploadCharge(
      monthlerent: int.parse(jsone['MonthlyRent']),
      maintance: int.parse(jsone['Maintance']),
      utility: int.parse(jsone['Utility']),
      flore: jsone['Flore'],
      room: jsone['Room'],
      id: jsone['id'],
    );
  }
}
