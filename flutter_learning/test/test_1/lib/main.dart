import 'package:flutter/material.dart';
import 'quote.dart';
import 'quote_card.dart';

void main() => runApp(MaterialApp(
  home: QuoteList(),
  ));

class QuoteList extends StatefulWidget {

  @override
  State<QuoteList> createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {

// Associate author with the quote
List<Quote> quotes = [
  Quote(author:'Oscar Wilde', text:'Be yourself; everyone else is already taken'),
  Quote(author:'Oscar Wilde', text:'Be yourself; everyone else is already taken'),
  Quote(author:'Oscar Wilde', text:'Be yourself; everyone else is already taken')
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Awesome Quotes'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        ),
        body: Column(
          children: quotes.map((quote) => QuoteCard(
            quote: quote,
            delete: () {
              setState(() {
                quotes.remove(quote);
              });
            }
            )).toList(),
        )
    );
  }
}

