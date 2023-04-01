import 'package:demo/controller/auth_controller.dart';
import 'package:demo/screens/verify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PhoneNumberPage extends StatefulWidget {
  PhoneNumberPage({Key? key}) : super(key: key);

  @override
  State<PhoneNumberPage> createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  bool verifyPressed = false;

  TextEditingController countryController = TextEditingController(text: "+91");
  TextEditingController phoneController = TextEditingController();
  final AuthController auth = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Number'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 25, right: 25),
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 120,
                ),
                SvgPicture.network(
                  'https://www.wingmanweb.com/wp-content/uploads/2022/05/Logo-Main-01-1.svg',
                  // 'assets/pv.png',
                  width: 200,
                  height: 200,
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Phone Verification",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "We need to register your phone before getting started!",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 40,
                        child: TextField(
                          controller: countryController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Text(
                        "|",
                        style: TextStyle(fontSize: 33, color: Colors.grey),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: TextField(
                        // maxLength: 10,
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Phone",
                        ),
                      ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.teal,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () async {
                        print("Phone");
                        print(phoneController.text);
                        if (phoneController.text.length != 10) {
                          print("Invalid Phone Number");
                          return;
                        }

                        setState(() {
                          verifyPressed = true;
                        });
                        String? reqID =
                            await auth.sendOTP(phoneController.text);
                        setState(() {
                          verifyPressed = false;
                        });
                        if (reqID == null) {
                          print("OTP could not be sent");
                          print("Try again later");
                          return;
                        }
                        print("OTP sent successfully check phone");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PinputExample(reqID: reqID)));
                      },
                      child: verifyPressed
                          ? Center(
                              child: CircularProgressIndicator(
                              color: Colors.white,
                            ))
                          : Text("Verify")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
