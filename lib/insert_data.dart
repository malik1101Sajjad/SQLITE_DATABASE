import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sqlit_database/db_helper.dart';
import 'package:sqlit_database/student_model.dart';

class InsertData extends StatefulWidget {
  const InsertData({super.key});

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  final dbhelper = DBhelper();
  TextEditingController rollnoTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController gmailTextEditingController = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    rollnoTextEditingController = TextEditingController();
    nameTextEditingController = TextEditingController();
    gmailTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    rollnoTextEditingController.dispose();
    nameTextEditingController.dispose();
    gmailTextEditingController.dispose();
    super.dispose();
  }

  void insertdata() {
    dbhelper.insertStudent(
        student: Student(
            rollNo: int.parse(rollnoTextEditingController.text),
            name: nameTextEditingController.text,
            gmail: gmailTextEditingController.text));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color.fromARGB(255, 7, 74, 129),
        content: Text(
          'ADD DATA SUCCESSFULY',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 7, 74, 129),
        iconTheme: const IconThemeData(color: Colors.orange),
        title: const Text('ADD DATA',
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
                      hintText: 'Enter NAME',
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
                        return insertdata();
                      }
                    },
                    child: const Text(
                      'ADD DATA',
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
                ]
                ));
  final Widget child;
}
