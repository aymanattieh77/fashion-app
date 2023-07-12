import 'package:dartz/dartz.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:fashion_app/core/errors/failure.dart';
import 'package:fashion_app/core/errors/server_failure.dart';
import 'package:fashion_app/data/data_source/payment_remote_data_source.dart';
import 'package:fashion_app/data/mappers/payment_mappers.dart';
import 'package:fashion_app/domain/entities/payment/payment_entity.dart';
import 'package:fashion_app/domain/repository/repositories.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDateSource _dateSource;
  PaymentRepositoryImpl(this._dateSource);
  @override
  Future<Either<Failure, PaymentEntity>> createPaymentIntent(
      {required String amount,
      required String currency,
      required String? paymentMethod}) async {
    try {
      final data = await _dateSource.createPaymentIntent(
          amount: amount, currency: currency, paymentMethod: paymentMethod);
      return Right(data.toDomain());
    } on Exception catch (e) {
      if (e is StripeException) {
        return Left(
            ServerFailure("Error from Stripe: ${e.error.localizedMessage}"));
      } else {
        return Left(ServerFailure("Unforeseen error: ${e}"));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaymentEntity>> retrievePaymentIntent(
      String id) async {
    try {
      final data = await _dateSource.retrievePaymentIntent(id);
      return Right(data.toDomain());
    } on Exception catch (e) {
      if (e is StripeException) {
        return Left(
            ServerFailure("Error from Stripe: ${e.error.localizedMessage}"));
      } else {
        return Left(ServerFailure("Unforeseen error: $e"));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
