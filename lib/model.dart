import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PredictionScreen extends StatefulWidget {
  PredictionScreen(
      {super.key,
      required this.age,
      required this.height,
      required this.weight});
  int age;
  int height;
  int weight;
  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  Map<String, dynamic> _prediction = {};

  Future<void> _getPrediction() async {
    final response = await http.post(
      Uri.parse('http://192.168.147.132:8000/predict/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'age': widget.age,
        'height': widget.height,
        'weight': widget.weight,
        'place_ids': [1, 2, 3, 4], // Example place IDs
      }),
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      setState(() {
        _prediction = responseJson['predicted_ratings'];
        print(_prediction["1"]);
      });
    } else {
      throw Exception('Failed to load prediction');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Prediction')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _heightController,
              decoration: InputDecoration(labelText: 'Height'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _weightController,
              decoration: InputDecoration(labelText: 'Weight'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getPrediction,
              child: Text('Get Prediction'),
            ),
            SizedBox(height: 20),
            Text('Prediction: $_prediction'),
          ],
        ),
      ),
    );
  }
}
