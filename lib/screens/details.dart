import 'package:demo/controller/auth_controller.dart';
import 'package:demo/screens/home.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage({required this.jwt, super.key});
  final TextEditingController _emailC = TextEditingController();
  final TextEditingController _nameC = TextEditingController();
  final AuthController auth = AuthController();
  final String jwt;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) return "Name cannot be empty";
                    return null;
                  },
                  controller: _nameC,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    // border: InputBorder.none,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    hintText: "Name",
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) return "Email cannot be empty";
                    return null;
                  },
                  controller: _emailC,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    // border: InputBorder.none,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    hintText: "Email",
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    // focusNode.unfocus();
                    if (formKey.currentState!.validate()) {
                      print("validated");
                      print(_nameC.text);
                      print(_emailC.text);
                      print(jwt);
                      //  TODO: Add the name and email to backend with jwt and send home page
                      var res =
                          await auth.addData(jwt, _nameC.text, _emailC.text);
                      if (res != null) {
                        if (res['status']) {
                          print("DATA added succesfully");
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        } else {
                          print(res['response']);
                          print("DATA could not added. try again later");
                        }
                        return;
                      }
                      print("WONG INPUT");
                      print(res['response']);
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
