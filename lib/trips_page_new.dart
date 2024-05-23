import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Trip_with_AI extends StatefulWidget {
  const Trip_with_AI({super.key});

  @override
  State<Trip_with_AI> createState() => _Trip_with_AIState();
}

class _Trip_with_AIState extends State<Trip_with_AI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'generate trip',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: 
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Color.fromARGB(255, 255, 87, 87)),
                    alignment:Alignment.center ,
              ),
            
              child: const Text(
                'generate trip',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                // ...
              },
            ),
          )
    );
  }
}
