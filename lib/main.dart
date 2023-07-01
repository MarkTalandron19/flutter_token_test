import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:token_test/account.dart';

import 'env.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Account? userData;

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
  }

  Future<void> _fetchUserInfo() async {
    final url = Uri.parse('${Env.prefix}/info/');
    final tokenUrl =
        Uri.parse('${Env.prefix}/auth/'); //Link to initialize and get token
    final tokenResponse = await http.post(tokenUrl,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          //Change these two to get token, it will show immediately in mysql
          'username': 'test2',
          'password': 'test2',
        }));
    print(tokenResponse.body);
    final tokenBody = jsonDecode(tokenResponse.body);
    final token = tokenBody['token'];
    final headers = {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final body = jsonEncode((<String, String>{
      'token': token,
    }));

    final response = await http.post(url, headers: headers, body: body);
    print(response.body);

    if (response.statusCode == 200) {
      setState(() {
        userData = Account.fromJson(json.decode(response.body));
      });
    } else {
      print('Failed to load user information.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Information'),
      ),
      body: Center(
        child: userData != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Account ID: ${userData?.accountID}'),
                  Text('Username: ${userData?.username}'),
                  Text('First Name: ${userData?.firstName}'),
                  Text('Last Name: ${userData?.lastName}'),
                  Text('Account Role: ${userData?.accountRole}'),
                  // Display more user information as needed
                ],
              )
            : CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchUserInfo,
      ),
    );
  }
}
