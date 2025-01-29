import 'package:flutter_test/flutter_test.dart';
import 'package:incubyte_task/string_calculator.dart';


void main() {
  final calculator = StringCalculator();

  test('should return 0 for empty string', () {
    expect(calculator.add(''), 0);
  });

  test('should return the number itself for single number', () {
    expect(calculator.add('1'), 1);
  });

  test('should sum two numbers', () {
    expect(calculator.add('1,2'), 3);
  });

  test('should handle newlines between numbers', () {
    expect(calculator.add('1\n2,3'), 6);
  });

  test('should handle custom delimiters', () {
    expect(calculator.add('//;\n1;2;3'), 6);
  });

  test('should throw exception for negative numbers', () {
    expect(() => calculator.add('1,-2,3'), throwsA(isA<NegativeNumberException>()));
  });
}
