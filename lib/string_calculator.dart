class NegativeNumberException implements Exception {
  final String message;
  NegativeNumberException(this.message);
}

class InvalidInputException implements Exception {
  final String message;
  InvalidInputException(this.message);
}

class StringCalculator {

  int add(String numbers) {
    if (numbers.isEmpty) {
      return 0; // Case for empty string
    }

    // Check for invalid character
    if (RegExp(r'\\').hasMatch(numbers)) {
      throw InvalidInputException('Invalid characters detected. Input should not contain escape sequences like \\');
    }

    // Check if there is a custom delimiter declaration
    if (numbers.startsWith("//")) {
      var delimiterEndIndex = numbers.indexOf("\n");
      var delimiter = numbers.substring(2, delimiterEndIndex);
      var numberPart = numbers.substring(delimiterEndIndex + 1);

      // Split numbers by the custom delimiter
      var numList = numberPart.split(delimiter).map(int.parse).toList();

      // Check for negative numbers
      var negatives = numList.where((num) => num < 0).toList();
      if (negatives.isNotEmpty) {
        throw NegativeNumberException("Negative numbers not allowed: ${negatives.join(', ')}");
      }

      return numList.fold(0, (prev, element) => prev + element);
    } else {
      // Default split byCommas or newlines
      try {
        var numList = numbers.split(RegExp(r'[;,|\n]')).map(int.parse).toList();

        // Check for negative numbers
        var negatives = numList.where((num) => num < 0).toList();
        if (negatives.isNotEmpty) {
          throw NegativeNumberException("Negative numbers not allowed: ${negatives.join(', ')}");
        }

        return numList.fold(0, (prev, element) => prev + element);
      } catch (e) {
        throw InvalidInputException('Invalid input: $numbers. Please check the format of the numbers.');
      }
    }
  }
}
