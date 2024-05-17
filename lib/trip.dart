import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gojo/generated/l10n.dart';

class generateTrip extends StatelessWidget {
  const generateTrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
body:Column(children: [
Row(children: [
Text(S.of(context).trip),
Spacer(),
IconButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)),color: Colors.white,onPressed: (){}, icon: Icon(Icons.add),iconSize: 35,)

],)



],)



    );
  }
}
