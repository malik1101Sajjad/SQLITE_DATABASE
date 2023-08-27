class Student {
  int? rollNo;
  String? name;
  String? gmail;

  static const String tableName = 'Student';
  static const String colrollNo = 'rollNo';
  static const String colname = 'name';
  static const String colgmail = 'gmail';
  static const String createTable =
      'CREATE TABLE  $tableName ($colrollNo INTEGER PRIMARY KEY AUTOINCREMENT, $colname TEXT,$colgmail TEXT)';

  Student({
    required this.rollNo,
    required this.name,
    required this.gmail,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rollNo': rollNo,
      'name': name,
      'gmail': gmail,
    };
  }

  Student.fromMap(Map<String, dynamic> map) {
    rollNo = map['rollNo'];
    name = map['name'];
    gmail = map['gmail'];
  }
}
