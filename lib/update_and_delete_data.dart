import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sqlit_database/db_helper.dart';
import 'package:sqlit_database/student_model.dart';

class UpdateAndDelete extends StatefulWidget {
  const UpdateAndDelete({required this.student, super.key});
  final Student student;

  @override
  State<UpdateAndDelete> createState() =>
      // ignore: no_logic_in_create_state
      _UpdateAndDeleteState(student: student);
}

class _UpdateAndDeleteState extends State<UpdateAndDelete> {
  _UpdateAndDeleteState({required this.student});
  final Student student;
  final dbhelper = DBhelper();
  TextEditingController rollnoTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController gmailTextEditingController = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    rollnoTextEditingController.text = student.rollNo!.toString();
    nameTextEditingController.text = student.name.toString();
    gmailTextEditingController.text = student.gmail.toString();
    super.initState();
  }

  @override
  void dispose() {
    rollnoTextEditingController.dispose();
    nameTextEditingController.dispose();
    gmailTextEditingController.dispose();
    super.dispose();
  }

  void updatedata() {
    dbhelper.updateStudent(
        student: Student(
            rollNo: int.parse(rollnoTextEditingController.text),
            name: nameTextEditingController.text,
            gmail: gmailTextEditingController.text));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor:  Color.fromARGB(255, 7, 74, 129),
        content: Text(
      'UPDATE DATA SUCCESSFULY',
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.orange, fontSize: 10, fontWeight: FontWeight.bold),
    )));

    setState(() {
      rollnoTextEditingController.clear();
      nameTextEditingController.clear();
      gmailTextEditingController.clear();
    });
  }

  void deleteData() {
    final int id = int.parse(rollnoTextEditingController.text);
    dbhelper.deleteStudent(id);
     setState(() {
      rollnoTextEditingController.clear();
      nameTextEditingController.clear();
      gmailTextEditingController.clear();
    });
  }

  void showDilogDeleteData() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return FadeInUp(
          delay: const Duration(microseconds: 100),
          duration: const Duration(seconds: 1),
          child: AlertDialog(
            backgroundColor: Colors.white,
            scrollable: true,
            title: const Text('You Want To Delete This Data?',
                style: TextStyle(
                    color: Color.fromARGB(255, 7, 74, 129),
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            content: Container(
              height: 80,
              padding: const EdgeInsets.all(2),
              margin: const EdgeInsets.all(5),
              child: ListView(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Student RollNo :',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        " ${student.rollNo!.toString()} ?",
                        style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Text(
                        'Student Name  :',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(" ${student.name.toString()} ?",
                          style: const TextStyle(
                              color: Colors.orange,
                              fontSize: 10,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const Text(
                          'Student Gmail  :',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Text(" ${student.gmail.toString()} ?",
                            style: const TextStyle(
                                color: Colors.orange,
                                fontSize: 10,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 7, 74, 129),
                      foregroundColor: Colors.yellow),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Color.fromARGB(255, 7, 74, 129),
                        content: Text(
                          'NOT DELETE DATA',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        )));
                    Navigator.of(context).pop(false);
                  },
                  child: const Text(
                    'NO',
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 7, 74, 129),
                      foregroundColor: Colors.yellow),
                  onPressed: () {
                    deleteData();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor:  Color.fromARGB(255, 7, 74, 129),
                        content: Text(
                      'DELETE DATA SUCCESSFULY',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    )));
                    Navigator.of(context).pop(true);
                  },
                  child: const Text(
                    'YES',
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 7, 74, 129),
        iconTheme: const IconThemeData(color: Colors.orange),
        title: const Text('UPDATE & DELETE DATA',
            style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Form(
          key: globalKey,
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              const SizedBox(
                height: 30,
              ),
              FadeInUp(
                delay: const Duration(milliseconds: 100),
                duration: const Duration(seconds: 1),
                child: ContainerWiget(
                    child: TextFormField(
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  controller: rollnoTextEditingController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.password),
                    hintText: 'Enter ROLLNO',
                    hintStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w100),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required faild ';
                    }
                    return null;
                  },
                )),
              ),
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                duration: const Duration(seconds: 1),
                child: ContainerWiget(
                    child: TextFormField(
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  controller: nameTextEditingController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.person),
                      hintText: 'Enter NAME ',
                      hintStyle: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w100)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required faild ';
                    }
                    return null;
                  },
                )),
              ),
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                duration: const Duration(seconds: 1),
                child: ContainerWiget(
                    child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 1,
                  controller: gmailTextEditingController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Enter GMAIL',
                      hintStyle: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w100)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required faild';
                    }
                    return null;
                  },
                )),
              ),
              //update button
              FadeInUp(
                delay: const Duration(milliseconds: 400),
                duration: const Duration(seconds: 1),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 7, 74, 129),
                        foregroundColor: Colors.yellow),
                    onPressed: () {
                      if (globalKey.currentState!.validate() == true) {
                        return updatedata();
                      }
                    },
                    child: const Text(
                      'UPDATE DATA',
                      style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ),
              ),
              //Delete button
              FadeInUp(
                delay: const Duration(milliseconds: 500),
                duration: const Duration(seconds: 1),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 7, 74, 129),
                        foregroundColor: Colors.yellow),
                    onPressed: () {
                      if (globalKey.currentState!.validate() == true) {
                        return showDilogDeleteData();
                      }
                    },
                    child: const Text(
                      'DELETE DATA',
                      style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ContainerWiget extends Container {
  ContainerWiget({required this.child, super.key})
      : super(
            padding: const EdgeInsets.all(5),
            margin:
                const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 3,
                      offset: const Offset(-5, -5)),
                  BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 3,
                      offset: const Offset(5, 5))
                ]));
  final Widget child;
}
