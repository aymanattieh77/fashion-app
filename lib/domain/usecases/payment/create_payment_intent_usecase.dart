import 'package:dartz/dartz.dart';
import 'package:fashion_app/core/errors/failure.dart';
import 'package:fashion_app/domain/entities/payment/payment_entity.dart';
import 'package:fashion_app/domain/repository/repositories.dart';
import 'package:fashion_app/domain/usecases/base_usecase.dart';

class CreatePaymentIntentUsecase
    extends BaseUsecase<PaymentEntity, PaymentInputs> {
  final PaymentRepository _repository;
  CreatePaymentIntentUsecase(this._repository);
  @override
  Future<Either<Failure, PaymentEntity>> call(PaymentInputs parameters) async {
    return await _repository.createPaymentIntent(
      amount: parameters.amount,
      currency: parameters.currency,
      paymentMethod: parameters.paymentMethod,
    );
  }
}

class PaymentInputs {
  final String amount;
  final String currency;
  final String paymentMethod;
  PaymentInputs({
    required this.amount,
    required this.currency,
    required this.paymentMethod,
  });
}
