import 'package:intl/intl.dart';

import 'constants.dart';

class NumberFormatter {
  final formatter = NumberFormat(POPULATION_MASK);

  String call(int value) => formatter.format(value);
}
