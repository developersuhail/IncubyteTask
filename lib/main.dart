import 'package:flutter/material.dart';
import 'string_calculator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'String Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StringCalculatorPage(),
    );
  }
}

class StringCalculatorPage extends StatefulWidget {
  @override
  _StringCalculatorPageState createState() => _StringCalculatorPageState();
}

class _StringCalculatorPageState extends State<StringCalculatorPage> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';
  String _errorMessage = '';

  // Instance of the StringCalculator logic
  final StringCalculator _calculator = StringCalculator();

  void _calculate() {
    setState(() {
      _errorMessage = '';
      try {
        String input = _controller.text;
        int result = _calculator.add(input);
        _result = 'Result: $result';
      } catch (e) {
        if (e is NegativeNumberException) {
          _errorMessage = e.message;
        } else {
          _errorMessage = 'Error: Invalid Input';
        }
        _result = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('String Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter numbers (comma or newline separated)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculate,
              child: Text('Calculate'),
            ),
            SizedBox(height: 20),
            if (_result.isNotEmpty) Text(_result, style: TextStyle(fontSize: 18)),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
