import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_pratice/app/service/auth_service.dart';
import 'package:todo_pratice/app/view/home/todoList.dart';

import '../auth/login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FirebaseAuth auth;

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(
            backgroundColor: Colors.white,
            color: Colors.black,
          );
        } else {
          if (snapshot.data == null) {
            return LoginPage();
          } else {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text("Modu Todo"),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.logout_rounded),
                    onPressed: () {
                      logOut(context, auth);
                    },
                  )
                ],
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/add');
                },
                child: const Icon(Icons.add),
              ),
              body: TodoList(),
            );
          }
        }
      },
    );
  }
}
