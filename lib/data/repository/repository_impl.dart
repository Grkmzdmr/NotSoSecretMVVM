import 'package:not_so_secret/data/data_source/local_data_source.dart';
import 'package:not_so_secret/data/data_source/remote_data_source.dart';
import 'package:not_so_secret/data/network/error_handler.dart';
import 'package:not_so_secret/data/network/network_info.dart';
import 'package:not_so_secret/data/responses/responses.dart';
import 'package:not_so_secret/domain/model/model.dart';
import 'package:not_so_secret/data/request/request.dart';
import 'package:not_so_secret/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:not_so_secret/domain/repository/repository.dart';
import 'package:not_so_secret/data/mapper/mapper.dart';
import 'package:not_so_secret/presentation/common/freezed_data_classes.dart';

class RepositoryImpl extends Repository {
  RemoteDataSource _remoteDataSource;
  LocalDataSource _localDataSource;
  NetworkInfo _networkInfo;

  RepositoryImpl(
      this._remoteDataSource, this._localDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.IsConnected) {
      try {
        //its safe to call the Api
        final response = await _remoteDataSource.login(loginRequest);
        if (response.success == ApiInternalStatus.SUCCESS) {
          //return data
          return Right(response.toDomain());
        } else {
          //return business logic error
          //return left
          return Left(
              Failure(409, response.exceptions?[0] ?? ResponseMessage.UNKNOWN));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.IsConnected) {
      try {
        //its safe to call the Api
        final response = await _remoteDataSource.register(registerRequest);
        if (response.success == ApiInternalStatus.SUCCESS) {
          //return data
          return Right(response.toDomain());
        } else {
          //return business logic error
          //return left
          return Left(
              Failure(409, response.exceptions?[0] ?? ResponseMessage.UNKNOWN));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeObject>> getHome(String language, int page) async {
    try {
      //get from cache
      final response = await _localDataSource.getHome();
      return Right(response.toDomain());
    } catch (cacheError) {
      //we have cache error
      

      if (await _networkInfo.IsConnected) {
        try {
          //its safe to call the Api
          final response = await _remoteDataSource.getHome(language, page);
          if (response.success == ApiInternalStatus.SUCCESS) {
            //return data
            //save response to local data source

            _localDataSource.saveHomeToCache(response);
            return Right(response.toDomain());
          } else {
            //return business logic error
            //return left
            return Left(Failure(
                409, response.exceptions?[0] ?? ResponseMessage.UNKNOWN));
          }
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        //return connection error
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Post>> sendSecret(PostRequest postRequest) async {
    if (await _networkInfo.IsConnected) {
      try {
        final response = await _remoteDataSource.sendSecret(postRequest);
        if (response.success == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(
              409, response.exceptions?[0] ?? ResponseMessage.SEND_TIMEOUT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeObject>> getProfile(int page) async {
    if (await _networkInfo.IsConnected) {
      try {
        //its safe to call the Api
        final response = await _remoteDataSource.getProfile(page);
        if (response.success == ApiInternalStatus.SUCCESS) {
          //return data
          //save response to local data source

          return Right(response.toDomain());
        } else {
          //return business logic error
          //return left
          return Left(
              Failure(409, response.exceptions?[0] ?? ResponseMessage.UNKNOWN));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, ProfileObject>> deleteSecret(int id) async {
    if (await _networkInfo.IsConnected) {
      try {
        final response = await _remoteDataSource.deleteSecret(id);
        if (response.success == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(
              409, response.exceptions?[0] ?? ResponseMessage.SEND_TIMEOUT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, CommentObject>> getComments(
      int secretId, String language, int page) async {
    if (await _networkInfo.IsConnected) {
      try {
        //its safe to call the Api
        final response = await _remoteDataSource
            .getComments(CommentRequest(secretId, language, page));
        if (response.success == ApiInternalStatus.SUCCESS) {
          //return data
          //save response to local data source

          return Right(response.toDomain());
        } else {
          //return business logic error
          //return left
          return Left(
              Failure(409, response.exceptions?[0] ?? ResponseMessage.UNKNOWN));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Comment>> sendComment(
      AddCommentRequest addCommentRequest) async {
    if (await _networkInfo.IsConnected) {
      try {
        final response = await _remoteDataSource.addComment(addCommentRequest);
        if (response.success == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(
              409, response.exceptions?[0] ?? ResponseMessage.SEND_TIMEOUT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Comment>> deleteComment(
      int secretId, int commentId) async {
    if (await _networkInfo.IsConnected) {
      try {
        final response =
            await _remoteDataSource.deleteComment(secretId, commentId);
        if (response.success == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(
              409, response.exceptions?[0] ?? ResponseMessage.SEND_TIMEOUT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
