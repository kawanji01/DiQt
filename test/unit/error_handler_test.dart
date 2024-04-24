import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('utils/error_handler', () {
    test(
        'ErrorHandler.isErrorResponse correctly identifies non-error responses',
        () {
      // 200 status code should not be an error
      Response response = Response('OK', 200);
      expect(ErrorHandler.isErrorResponse(response), false);

      // 201 status code should not be an error
      response = Response('Created', 201);
      expect(ErrorHandler.isErrorResponse(response), false);
    });

    test('ErrorHandler.isErrorResponse correctly identifies error responses',
        () {
      // 300 status code should be an error
      Response response = Response('Multiple Choices', 300);
      expect(ErrorHandler.isErrorResponse(response), true);

      // 404 status code should be an error
      response = Response('Not Found', 404);
      expect(ErrorHandler.isErrorResponse(response), true);

      // 500 status code should be an error
      response = Response('Internal Server Error', 500);
      expect(ErrorHandler.isErrorResponse(response), true);
    });

    test('ErrorHandler.isErrorMap correctly identifies non-error responses',
        () {
      // 200 status code should not be an error
      Map responseMap = {'status': 200};
      expect(ErrorHandler.isErrorMap(responseMap), false);

      // 201 status code should not be an error
      responseMap = {'status': 201};
      expect(ErrorHandler.isErrorMap(responseMap), false);
    });

    test('ErrorHandler.isErrorMap correctly identifies error responses', () {
      // 300 status code should be an error
      Map responseMap = {'status': 300};
      expect(ErrorHandler.isErrorMap(responseMap), true);

      // 404 status code should be an error
      responseMap = {'status': 404};
      expect(ErrorHandler.isErrorMap(responseMap), true);

      // 500 status code should be an error
      responseMap = {'status': 500};
      expect(ErrorHandler.isErrorMap(responseMap), true);
    });

    test('ErrorHandler.errorMap return valid error responses', () {
      final response = Response('Internal Server Error', 500);
      final Map responseMap = ErrorHandler.errorMap(response);
      expect(ErrorHandler.isErrorMap(responseMap), true);
    });
  });
}
