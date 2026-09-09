// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class QuoteModel {
    int id;
    String quote;
    String author;
  QuoteModel({
    required this.id,
    required this.quote,
    required this.author,
  });

  QuoteModel copyWith({
    int? id,
    String? quote,
    String? author,
  }) {
    return QuoteModel(
      id: id ?? this.id,
      quote: quote ?? this.quote,
      author: author ?? this.author,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'quote': quote,
      'author': author,
    };
  }

  factory QuoteModel.fromMap(Map<String, dynamic> map) {
    return QuoteModel(
      id: map['id'] as int,
      quote: map['quote'] as String,
      author: map['author'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuoteModel.fromJson(String source) => QuoteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'QuoteModel(id: $id, quote: $quote, author: $author)';

  @override
  bool operator ==(covariant QuoteModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.quote == quote &&
      other.author == author;
  }

  @override
  int get hashCode => id.hashCode ^ quote.hashCode ^ author.hashCode;
  }
