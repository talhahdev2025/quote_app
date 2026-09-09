import 'package:new_practice_project/core/network/api_client.dart';
import 'package:new_practice_project/quote/data/models/quote_model.dart';

class QuoteRemoteDataSource {
  final ApiClient _apiClient;

  QuoteRemoteDataSource({required this._apiClient});

  Future<QuoteModel> fetchDailyQuote() async {
    final data = await _apiClient.getQuote();
    return QuoteModel.fromMap(data);
  }
}
