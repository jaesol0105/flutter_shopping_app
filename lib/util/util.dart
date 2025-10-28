import 'package:intl/intl.dart';

String fmtPrice(int number) {
  final formatter = NumberFormat('#,###');
  return formatter.format(number);
}
