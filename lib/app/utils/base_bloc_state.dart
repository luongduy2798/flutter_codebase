import 'package:equatable/equatable.dart';
import 'api/response_error.dart';

abstract class BaseBlocState extends Equatable {
  final ResponseError? error;

  const BaseBlocState({this.error});
}
