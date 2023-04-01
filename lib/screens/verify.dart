import 'package:demo/screens/details.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../controller/auth_controller.dart';
import 'home.dart';

class VerifyPhoneScreen extends StatelessWidget {
  const VerifyPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return const Placeholder();
  }
}

class PinputExample extends StatefulWidget {
  const PinputExample({Key? key, required this.reqID}) : super(key: key);
  final String reqID;

  @override
  State<PinputExample> createState() => _PinputExampleState();
}

class _PinputExampleState extends State<PinputExample> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  AuthController auth = AuthController();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(197, 203, 207, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    // return TextField(
    //   contextMenuBuilder: (_, EditableTextState editableTextState) {
    //     print('HEHE');
    //     return AdaptiveTextSelectionToolbar(
    //       anchors: editableTextState.contextMenuAnchors,
    //       children: editableTextState.contextMenuButtonItems.map((ContextMenuButtonItem buttonItem) {
    //         return CupertinoButton(
    //           borderRadius: null,
    //           color: const Color(0xffaaaa00),
    //           disabledColor: const Color(0xffaaaaff),
    //           onPressed: buttonItem.onPressed,
    //           padding: const EdgeInsets.all(10.0),
    //           pressedOpacity: 0.7,
    //           child: SizedBox(
    //             width: 200.0,
    //             child: Text(
    //               CupertinoTextSelectionToolbarButton.getButtonLabel(context, buttonItem),
    //             ),
    //           ),
    //         );
    //       }).toList(),
    //     );
    //   },
    // );

    /// Optionally you can use form to validate the Pinput
    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Directionality(
                // Specify direction if desired
                textDirection: TextDirection.ltr,
                child: Pinput(
                  length: 6,
                  controller: pinController,
                  focusNode: focusNode,
                  androidSmsAutofillMethod:
                      AndroidSmsAutofillMethod.smsUserConsentApi,
                  listenForMultipleSmsOnAndroid: true,
                  defaultPinTheme: defaultPinTheme,
                  validator: (value) {
                    print("value: $value");

                    return value!.length == 6 ? null : 'Enter 6 digit code';
                  },
                  // onClipboardFound: (value) {
                  //   debugPrint('onClipboardFound: $value');
                  //   pinController.setText(value);
                  // },
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  onCompleted: (pin) {
                    debugPrint('onCompleted: $pin');
                  },
                  onChanged: (value) {
                    debugPrint('onChanged: $value');
                  },
                  cursor: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 9),
                        width: 22,
                        height: 1,
                        color: focusedBorderColor,
                      ),
                    ],
                  ),
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: focusedBorderColor),
                    ),
                  ),
                  submittedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      color: fillColor,
                      borderRadius: BorderRadius.circular(19),
                      border: Border.all(color: focusedBorderColor),
                    ),
                  ),
                  errorPinTheme: defaultPinTheme.copyBorderWith(
                    border: Border.all(color: Colors.redAccent),
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  focusNode.unfocus();
                  if (formKey.currentState!.validate()) {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => HomePage(),
                    //     ));
                    print("validated");
                    print(pinController.text);
                    print(widget.reqID);
                    var res =
                        await auth.verifyOTP(widget.reqID, pinController.text);
                    if (res != null) {
                      if (res['status']) {
                        if (res['profile_exists']) {
                          print("profile exists");
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        } else {
                          print("profile does not exists");
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailsPage(jwt: res['jwt']),
                              ));
                          // TODO: send to create profile - name and email
                        }
                      } else {
                        print(res['response']);
                      }
                    } else {
                      print("error");
                    }
                  }
                },
                child: const Text('Verify'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
