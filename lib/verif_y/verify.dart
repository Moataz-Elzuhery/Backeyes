import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:BackEyes/For_get/forget_cubit/states.dart';
import '../login/login.dart';
import '../For_get/forget_cubit/cubit.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final TextEditingController verifyCode = TextEditingController();
  var fromKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  var formKeyForBottomSheet = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForgetCubit>(
      create: (context) => ForgetCubit()..startTimer(),
      child: BlocConsumer<ForgetCubit, ForgetStates>(
        listener: (context, state) {
          if (state is ChangePasswordSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_new),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Form(
                    key: fromKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          "Verification Code",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Verification Code has been sent to ",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          widget.email,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          child: Pinput(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your verify code';
                              }
                              return null;
                            },
                            controller: verifyCode,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            mouseCursor: MouseCursor.defer,
                            showCursor: true,
                            length: 6,
                            scrollPadding: EdgeInsets.all(40),
                            followingPinTheme: PinTheme(
                              width: 60,
                              height: 59,
                              decoration: BoxDecoration(
                                color: Color(0xffD9D9D9),
                                border: Border.all(color: Color(0xffD9D9D9)),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            focusedPinTheme: PinTheme(
                              height: 66,
                              width: 59,
                              textStyle: TextStyle(fontSize: 25),
                              decoration: BoxDecoration(
                                border:
                                Border.all(width: .7, color: Colors.grey),
                                borderRadius: BorderRadius.circular(15),
                                shape: BoxShape.rectangle,
                              ),
                            ),
                            defaultPinTheme: PinTheme(
                              height: 66,
                              width: 59,
                              textStyle: const TextStyle(fontSize: 25),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                shape: BoxShape.rectangle,
                                color: Color(0xffD9D9D9),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextButton(
                          onPressed: () {
                            if (!ForgetCubit.get(context).isTimerRunning) {
                              ForgetCubit.get(context).forget(email: widget.email);
                              ForgetCubit.get(context).startTimer();
                            }
                          },
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              ForgetCubit.get(context).isTimerRunning
                                  ? 'Resend after ${ForgetCubit.get(context).seconds} S'
                                  : 'Resend',
                              style: TextStyle(
                                color: Colors.grey,
                                textBaseline: TextBaseline.alphabetic,
                                decorationColor: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            if (fromKey.currentState!.validate()) {
                              ForgetCubit.get(context).sendCode(
                                email: widget.email,
                                code: verifyCode.text,
                              );
                            }
                            showModalBottomSheet(
                              context: context,
                              builder: (context1) {
                                return Container(
                                  width: double.infinity,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 30.0),
                                    child: Form(
                                      key: formKeyForBottomSheet,
                                      child: Column(
                                        children: [
                                          const Text(
                                            'Change Password',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                            ),
                                          ),
                                          TextFormField(
                                            controller: passwordController,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter your password';
                                              }
                                              return null;
                                            },
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              ForgetCubit.get(context).changePassword(password: passwordController.text);
                                            },
                                            child: Text('Change Password'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Verify   ',
                              style: TextStyle(
                                color: Colors.black,
                                textBaseline: TextBaseline.alphabetic,
                                decorationColor: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
