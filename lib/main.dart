import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlit_database/fatch_data.dart';
import 'package:sqlit_database/insert_data.dart';
import 'package:sqlit_database/navigation_page.dart';
import 'package:sqlit_database/provider_fatch_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: ChangeNotifierProvider(
            create: (context) => DataListProvider(),
            child: const MyHomePage()));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: const FatchData(),
      // Navigate Add Data
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 7, 74, 129),
        onPressed: () {
          Navigator.of(context).push(NavigationPage(child: const InsertData()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.orange,
        ),
      ),
    );
  }
}
