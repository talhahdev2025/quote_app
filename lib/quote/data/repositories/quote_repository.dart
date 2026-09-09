import 'package:new_practice_project/quote/data/datasources/quote_remote_data_source.dart';
import 'package:new_practice_project/quote/data/models/quote_model.dart';

class QuoteRepository {
  final QuoteRemoteDataSource _remoteDataSource;

  QuoteRepository({required this._remoteDataSource});

  Future<QuoteModel> fetchQuote() async {
    return await _remoteDataSource.fetchDailyQuote();
  }
}
