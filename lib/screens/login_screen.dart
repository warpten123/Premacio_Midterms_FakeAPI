import 'package:fake_store/models/login_model.dart';
import 'package:fake_store/screens/test.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../services/api_service.dart';
import 'home.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  ApiService get apiservice => GetIt.instance<ApiService>();
  LoginRequestModel requestModel = LoginRequestModel();

  final TextEditingController nameCtrl = TextEditingController(
    text: 'mor_2314',
  );
  final TextEditingController passwordCtrl = TextEditingController(
    text: '83r5^_',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Shop'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: passwordCtrl,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 60,
              child: ElevatedButton(
                onPressed: () async {
                  requestModel.username = nameCtrl.text;
                  requestModel.password = passwordCtrl.text;
                  final getToken = await apiservice.login(requestModel);

                  if (getToken.token.isNotEmpty) {
                    print("fuck");
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Successfully logged in'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Future.delayed(
                      const Duration(seconds: 2),
                      () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const test(),
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Incorrect username or password'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
