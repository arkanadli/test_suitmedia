// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:test_suitmedia/helpers/check_palindrome.dart';
import 'package:test_suitmedia/views/second_screen.dart';

import '../widgets/text_field_input.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController palindromeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.fill)),
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/images/ic_photo.png'),
              ),
              const SizedBox(
                height: 60.0,
              ),
              TextFieldInput(
                conn: nameController,
                hintText: 'Name',
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFieldInput(
                conn: palindromeController,
                hintText: 'Palindrome',
              ),
              const SizedBox(
                height: 30.0,
              ),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    if (palindromeController.text.isEmpty) {
                      const snackBar = SnackBar(
                        backgroundColor: Colors.black,
                        content: Text('Harap masukkan kata terlebih dahulu!'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      // Future.delayed untuk mengatur waktu tampilan snack bar
                      Future.delayed(const Duration(seconds: 2), () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      });
                    } else {
                      bool isPalindrome =
                          checkPalindrome(palindromeController.text);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'Result Palindrom Check :',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            content: Text(isPalindrome
                                ? 'Is Palindrome'
                                : 'Not Palindrome'),
                          );
                        },
                      );
                    }
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
                  child: const Text('CHECK'),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isEmpty) {
                      const snackBar = SnackBar(
                        backgroundColor: Colors.black,
                        content: Text('Harap masukkan nama terlebih dahulu!'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      // Future.delayed untuk mengatur waktu tampilan snack bar
                      Future.delayed(const Duration(seconds: 2), () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      });
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SecondScreen(
                          conn: nameController,
                        ),
                      ));
                    }
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
                  child: const Text('NEXT'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
