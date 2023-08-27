import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlit_database/navigation_page.dart';
import 'package:sqlit_database/provider_fatch_data.dart';
import 'package:sqlit_database/update_and_delete_data.dart';

class FatchData extends StatefulWidget {
  const FatchData({super.key});

  @override
  State<FatchData> createState() => _FatchDataState();
}

class _FatchDataState extends State<FatchData> {
  Color bagColor = const Color.fromARGB(255, 7, 74, 129);
  final time = TimeOfDay.now().toString();
  late Timer _timer;
  void viewDataProvider() {
    Provider.of<DataListProvider>(context, listen: false).fatchDataSqlit();
  }

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      viewDataProvider();
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //app bar
        appBar: AppBar(
            backgroundColor: bagColor,
            iconTheme: const IconThemeData(color: Colors.orange),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 5,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22)),
                  child: ClipRect(
                    child: Image.asset(
                      'assets/sstroag.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  'STUDENT DATA',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )),
        //fatch data using provider
        body: Consumer<DataListProvider>(builder: (context, value, child) {
          final emptyList = value.emptList;
          return emptyList.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: emptyList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FadeInUp(
                      delay: const Duration(milliseconds: 300),
                      duration: const Duration(seconds: 1),
                      child: ContainerFatchData(
                        child: FadeInUp(
                          delay: const Duration(milliseconds: 200),
                          duration: const Duration(seconds: 1),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(8.0),
                            onTap: () {
                              ///navigate update and delete page
                              Navigator.of(context).push(NavigationPage(
                                  child: UpdateAndDelete(
                                      student: emptyList[index])));
                            },

                            // leading
                            leading: CircleAvatar(
                              backgroundColor: bagColor,
                              child: Text(
                                emptyList[index].rollNo.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            // title row
                            title: Row(
                              children: [
                                const Text(
                                  'Name : ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  emptyList[index].name.toString(),
                                  style: const TextStyle(
                                    color: Colors.orange,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),

                            // sub title
                            subtitle: Row(
                              children: [
                                const Text(
                                  'Gmail   : ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  emptyList[index].gmail.toString(),
                                  style: const TextStyle(
                                    color: Colors.orange,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
        }));
  }
}

class ContainerFatchData extends Container {
  ContainerFatchData({super.key, required this.child})
      : super(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 3,
                      offset: const Offset(-5, -5)),
                  BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 3,
                      offset: const Offset(5, 5))
                ]),
            child: child);
  final Widget child;
}
