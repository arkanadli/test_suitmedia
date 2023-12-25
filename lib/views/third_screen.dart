// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:test_suitmedia/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:test_suitmedia/views/second_screen.dart';

import '../widgets/display_error.dart';
import '../widgets/display_loading_indicator.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key, required this.conn}) : super(key: key);

  final TextEditingController conn;

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;
  List<UserModel> users = [];

  Future<List<UserModel>?> getUsers() async {
    try {
      final response = await http.get(
        Uri.parse('https://reqres.in/api/users?page=$currentPage&per_page=10'),
      );

      if (response.statusCode != 200) {
        throw 'Bad Response ${response.statusCode}';
      }
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);
      // akses langsung ke key 'data' untuk mengambil data users
      final List<dynamic> userList = jsonDecoded['data'];

      // jika list kosong maka akan langsung mengembalikan users
      if (userList.isEmpty) {
        return users;
      }

      // penambahan list users dari data userList
      users.addAll(userList.map((user) {
        return UserModel.fromJson(user);
      }).toList());

      return users;
    } catch (e) {
      throw e.toString();
    }
  }

  void _loadMoreUsers() {
    currentPage++;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // listener posisi scroll user
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreUsers();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Third Screen",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        scrolledUnderElevation: 0,
      ),
      body: LiquidPullToRefresh(
        onRefresh: () async {
          users = [];
          currentPage = 1;
          await getUsers();
        },
        child: Column(
          children: [
            const Divider(),
            Container(
              padding: const EdgeInsets.all(10.0),
              height: MediaQuery.of(context).size.height - 100,
              child: FutureBuilder(
                future: getUsers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting &&
                      users.isEmpty) {
                    return const DisplayLoadingIndicator();
                  }
                  if (snapshot.hasError) {
                    return DisplayError(
                      error: snapshot.error.toString(),
                      function: getUsers,
                    );
                  }
                  if (users.isEmpty) {
                    return const DisplayError(error: 'No Data Available');
                  }

                  return ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    controller: _scrollController,
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return SizedBox(
                        height: 80,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                              user.avatar,
                            ),
                          ),
                          title: Text(
                            "${user.firstName} ${user.lastName}",
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(user.email),
                          onTap: () {
                            widget.conn.text =
                                "${user.firstName} ${user.lastName}";
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
