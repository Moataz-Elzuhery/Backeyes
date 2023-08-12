import 'package:flutter/material.dart';



String localhost = "http://192.168.137.1";





Widget defaultButton({
  double  width=double.infinity,
  Color  background=Colors.black,
// required TextStyle textStyle,
  Color textColor=Colors.white,
  //void function() OR void call back

  required void Function() function,
   required String text,

})=>Container(
  width: width,
  decoration: BoxDecoration(
      color: background,

      borderRadius: BorderRadius.circular(20),

  ),

  child: MaterialButton(
    onPressed: function,
    child: Text(
      text,style: const TextStyle(
        color: Colors.white,
      fontSize: 18
    ),
    ),
  ),
);