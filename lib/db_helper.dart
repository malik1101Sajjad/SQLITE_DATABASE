// ignore: file_names
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:sqlit_database/student_model.dart';

class DBhelper extends Sqflite {
  static Database? _db;
  static const String dbName = 'student.db';
  static const int dbversion = 4;
  Future<Database> get database async {
    var path = join(await getDatabasesPath(), dbName);
    return _db ??= await openDatabase(
      path,
      version: dbversion,
      onCreate: (Database db, int version) async {
        await db.execute(Student.createTable);
      },
    );
  }

  //insert Data
  Future<bool> insertStudent({required Student student}) async {
    Database db = await database;
    int noOfEffectedRows = await db.insert(Student.tableName, student.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return noOfEffectedRows == 1;
  }

  //fatch Data
  Future<List<Student>> fatchStudent() async {
    Database db = await database;
    List<Map<String, dynamic>> studentmap = await db.query(Student.tableName);
    return studentmap.map((e) => Student.fromMap(e)).toList();
  }

  //update Data
  Future<bool> updateStudent({required Student student}) async {
    Database db = await database;
    int noOfEffectedRows = await db.update(Student.tableName, student.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
        where: "${Student.colrollNo} = ?",
        whereArgs: [student.rollNo]);
    return noOfEffectedRows == 1;
  }

  // Delete Data
  Future<bool> deleteStudent(int rollNo) async {
    Database db = await database;
    int noOfEffectedRows = await db.delete(Student.tableName,
        where: "${Student.colrollNo} = ?", whereArgs: [rollNo]);
    return noOfEffectedRows == 1;
  }
}
