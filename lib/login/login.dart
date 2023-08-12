import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../For_get/forget_page.dart';
import '../Register/Auth_cubit/cubit.dart';
import '../Register/signup.dart';
import '../screens/grid/grid.dart';
import '../shared/components/component.dart';
import '../shared/network/local_network.dart';
import 'login_cubit/cubit.dart';
import 'login_cubit/states.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Grid()),
            );
            CacheNetwork.InsertToCache(key: 'token', value: state.token);
          } else if (state is FailedToLoginState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Container(
                  child: Text(state.message),
                  height: 50,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Log into ',
                          style: TextStyle(fontSize: 30, color: Colors.black),
                        ),
                        const Text(
                          'your account',
                          style: TextStyle(fontSize: 30, color: Colors.black),
                        ),
                        const SizedBox(height: 35),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: emailController,
                          validator: (value) {
                            if (emailController.text.isEmpty) {
                              return 'Your name must be required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            focusColor: Colors.black87,
                            hoverColor: Colors.black87,
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            hintText: 'Username/Email',
                            hintStyle: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: passController,
                          validator: (value) {
                            if (passController.text.isEmpty) {
                              return 'Password must not be short';
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Forget()),
                                );
                              },
                              child: const Text(
                                'Forget?',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            border: const UnderlineInputBorder(),
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Checkbox(
                              value: BlocProvider.of<LoginCubit>(context).val,
                              onChanged: (input) {
                                BlocProvider.of<LoginCubit>(context).changebox(input!);
                              },
                              activeColor: Colors.black87,
                            ),
                            const Text("Remember me"),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: Container(
                            width: double.infinity,
                            child: defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).login(
                                    email: emailController.text,
                                    password: passController.text,
                                  );
                                }
                              },
                              text: state is LoginLoadingState ? "Loading ...." : "Log in",
                              textColor: Colors.white,
                              background: const Color(0xff00101D),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Grid()),
                            );
                          },
                          child: Center(
                            child: Container(
                              width: 365,
                              height: 46,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xff00000000).withOpacity(.2),
                                    blurRadius: 5,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(30),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset("assets/a.png"),
                                  const Text(
                                    "Log in with Facebook",
                                    style: TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 33),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignUp()),
                                );
                              },
                              child: const Text(
                                "Don’t have an account? Sign up",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
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
