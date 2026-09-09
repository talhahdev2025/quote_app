import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_practice_project/core/network/api_client.dart';
import 'package:new_practice_project/quote/data/datasources/quote_remote_data_source.dart';
import 'package:new_practice_project/quote/data/models/quote_model.dart';
import 'package:new_practice_project/quote/data/repositories/quote_repository.dart';

final apiProvider = Provider<ApiClient>((ref) => ApiClient());
final quoteRemoteDataSource = Provider<QuoteRemoteDataSource>(
  (ref) => QuoteRemoteDataSource(apiClient: ref.watch(apiProvider)),
);
final quoteRepositoryProvider = Provider<QuoteRepository>(
  (ref) => QuoteRepository(remoteDataSource: ref.watch(quoteRemoteDataSource)),
);

final quoteProvider = FutureProvider<QuoteModel>(
  (ref) => ref.read(quoteRepositoryProvider).fetchQuote(),
);
