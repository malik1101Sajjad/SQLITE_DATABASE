import 'package:flutter/material.dart';
import 'package:sqlit_database/db_helper.dart';
import 'package:sqlit_database/student_model.dart';

class DataListProvider extends ChangeNotifier {
  final dBhelper = DBhelper();
  List<Student> emptList = [];

  void fatchDataSqlit() async {
    emptList = await dBhelper.fatchStudent();
    notifyListeners();
  }
}

