import 'package:aplikasi_journal_2/network/network_enums.dart';

typedef NetworkCallBack<R> = R Function(dynamic);
typedef NetworkOnFailureCallBackWithMessage<R> = R Function(
  NetworkResponseErrorType, String?);