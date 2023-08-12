import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components/component.dart';
import '../verif_y/verify.dart';
import 'forget_cubit/cubit.dart';
import 'forget_cubit/states.dart';

class Forget extends StatelessWidget {
  Forget({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetCubit(),
      child: BlocConsumer<ForgetCubit, ForgetStates>(
        listener: (context, state) {
          if (state is FailedToForgetState) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text(
                  state.message,
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ),
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
            body: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Forget ',
                        style: TextStyle(fontSize: 30, color: Colors.black),
                      ),
                      const Text(
                        'Password? ',
                        style: TextStyle(fontSize: 30, color: Colors.black),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: emailController,
                        validator: (value) {
                          if (emailController.text.isEmpty) {
                            return 'Enter your name or email';
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
                      SizedBox(
                        height: 70,
                      ),
                      Center(
                        child: Container(
                          width: double.infinity,
                          child: defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<ForgetCubit>(context).forget(
                                  email: emailController.text,
                                );

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VerifyPage(
                                      email: emailController.text,
                                    ),
                                  ),
                                );
                              }
                            },
                            text: "Next Step",
                            textColor: Colors.white,
                            background: const Color(0xff00101D),
                          ),
                        ),
                      ),
                    ],
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
