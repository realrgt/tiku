import 'package:a_tiku/app/core/util/number_formatter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mocktail/mocktail.dart';

class MockNumberFormat extends Mock implements NumberFormat {}

void main() {
  late NumberFormatter formatter;

  setUp(() {
    formatter = NumberFormatter();
  });

  int tValue = 99999;

  test('should format number grouping it by three digits', () {
    // arrange
    final result = formatter(tValue);
    // assert
    expect(result, '99,999');
  });
}
