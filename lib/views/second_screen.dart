// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:test_suitmedia/views/third_screen.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key, required this.conn}) : super(key: key);

  final TextEditingController conn;

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final TextEditingController userSelectedController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userSelectedController.text = 'No user has been selected!';
    userSelectedController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Second Screen",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          const Divider(),
          Container(
            height: MediaQuery.of(context).size.height - 100,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      widget.conn.text,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Flexible(
                  child: Center(
                    child: Text(
                      userSelectedController.text,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ThirdScreen(
                          conn: userSelectedController,
                        ),
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xFF2B637B),
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        )),
                    child: const Text(
                      'Choose a User',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
