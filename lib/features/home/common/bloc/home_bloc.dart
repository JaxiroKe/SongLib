import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../../common/repository/database_repository.dart';
import '../../../../../core/di/injectable.dart';
import '../../../../common/data/models/models.dart';
import '../../../../common/repository/pref_repository.dart';
import '../../../../common/repository/sync_repository.dart';
import '../../../../common/utils/app_util.dart';

part 'home_event.dart';
part 'home_state.dart';

part 'home_bloc.freezed.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const _HomeState()) {
    on<SyncData>(_onSyncData);
    on<FetchData>(_onFetchData);
    on<FilterData>(_onFilterData);
    on<ResetData>(_onResetData);
  }

  final _syncRepo = SyncRepository();
  final _prefRepo = getIt<PrefRepository>();
  final _dbRepo = getIt<DatabaseRepository>();

  Future<void> _onSyncData(
    SyncData event,
    Emitter<HomeState> emit,
  ) async {
    try {
      bool updatesMade = await _syncRepo.syncData();
      emit(HomeDataSyncedState(updatesMade));
    } catch (e, stackTrace) {
      logger("Error log: $e\n$stackTrace");
      emit(HomeDataSyncedState(false));
    }
  }

  Future<void> _onFetchData(
    FetchData event,
    Emitter<HomeState> emit,
  ) async {
    if (!event.refreshing) emit(HomeFetchingState());
    try {
      var books = await _dbRepo.fetchBooks();
      var songs = await _dbRepo.fetchSongs();
      emit(HomeDataFetchedState(books, songs));
    } catch (e) {
      logger('Unable to: $e');
      Sentry.captureException(e);
      emit(HomeFailureState('Unable to fetch songs'));
    }
  }

  Future<void> _onFilterData(
    FilterData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeFilteringState());
    try {
      var songs = await _dbRepo.fetchSongs(bid: event.book.bookId!);
      var likes = await _dbRepo.fetchLikes();
      emit(HomeFilteredState(event.book, songs, likes));
    } catch (e) {
      logger('Unable to: $e');
      Sentry.captureException(e);
      emit(HomeFailureState('Unable to fetch songs'));
    }
  }

  Future<void> _onResetData(
    ResetData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeFetchingState());
    try {
      await _dbRepo.removeAllBooks();
      await _dbRepo.removeAllSongs();
      _prefRepo.clearData();
      emit(HomeResettedState());
    } catch (e) {
      logger('Unable to: $e');
      Sentry.captureException(e);
      emit(HomeResettedState());
    }
  }
}
