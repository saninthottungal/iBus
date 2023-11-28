class DataModel {
  int? id;
  String? name;
  String? regNum;
  String? start;
  String? end;

  DataModel({
    required this.id,
    required this.name,
    required this.regNum,
    required this.start,
    required this.end,
  });

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json["Id"];
    name = json["Name"];
    regNum = json["RegNum"];
    start = json["Start"];
    end = json["End"];
  }
}
