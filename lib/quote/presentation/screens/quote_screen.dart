import 'package:flutter/material.dart';
import 'package:new_practice_project/quote/presentation/widgets/date_widget.dart';
import 'package:new_practice_project/quote/presentation/widgets/quote_widget.dart';

class QuoteScreen extends StatelessWidget {
  const QuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar
      appBar: AppBar(centerTitle: true, title: Text('Quote of the Day')),
      body: Center(
        child: Column(
          children: [
            //date widget
            const SizedBox(height: 12),
            DateWidget(),
            const SizedBox(height: 12),
            QuoteWidget(),
          ],
        ),
      ),
    );
  }
}
