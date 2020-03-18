import 'package:ads_url_test/core/failures/exceptions.dart';
import 'package:ads_url_test/core/failures/failure.dart';
import 'package:ads_url_test/model/list_item_model.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:ads_url_test/repository/source/source.dart';

class Repository {
  final CacheDataSource cacheSource;
  final RemoteDataSource remoteSource;

  Repository({
    @required this.cacheSource,
    @required this.remoteSource,
  }) : assert(
          cacheSource != null && remoteSource != null,
        );

  Future<Either<Failure, List<ListItemModel>>> getHotList() async {
    List<ListItemModel> result;

    try {
      // check for hot list in cache
      result = await cacheSource.getHotList();
      print(result);
      if (result == null || result.length == 0) {
        await cacheSource.deleteHotList();
        result = await remoteSource.getHotList();
        result.forEach((item) async {
          await cacheSource.saveHotListItem(
            authorName: item.authorName,
            subreddit: item.subReddit,
            title: item.title,
          );
        });
      }
      // if found return from cache else call remote data source

      return Right(result);
    } on ServerException {
      return Left(
        Failure(message: "Server Failure"),
      );
    } on CacheException {
      return Left(
        Failure(message: "Cache Failure"),
      );
    }
  }

  Future<Either<Failure, List<ListItemModel>>> getNewList() async {
    List<ListItemModel> result;

    try {
      // check for hot list in cache
      result = await cacheSource.getNewList();

      if (result == null || result.length == 0) {
        await cacheSource.deleteNewList();
        result = await remoteSource.getNewList();
        result.forEach((item) async {
          await cacheSource.saveNewListItem(
            authorName: item.authorName,
            subreddit: item.subReddit,
            title: item.title,
          );
        });
      }
      // if found return from cache else call remote data source

      return Right(result);
    } on ServerException {
      return Left(
        Failure(message: "Server Failure"),
      );
    } on CacheException {
      return Left(
        Failure(message: "Cache Failure"),
      );
    }
  }

  Future<Either<Failure, List<ListItemModel>>> searchHotList(
      String title) async {
    try {
      final result = await cacheSource.searchHotList(title);

      return Right(result);
    } on CacheException {
      return Left(
        Failure(message: "Cache Failure"),
      );
    }
  }

  Future<Either<Failure, List<ListItemModel>>> searchNewList(
      String title) async {
    try {
      final result = await cacheSource.searchNewList(title);

      return Right(result);
    } on CacheException {
      return Left(
        Failure(message: "Cache Failure"),
      );
    }
  }
}
