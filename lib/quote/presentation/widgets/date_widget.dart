import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedDate=DateFormat('EEEE, d MMM yyyy').format(now);
    return Text(
      formattedDate,
      style: TextStyle(fontSize: 23, fontWeight: .bold),
    );
  }
}
