import 'package:a_tiku/app/core/network/network_status_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';

class MockInternetConnectionChecker extends Mock
    implements InternetConnectionChecker {}

void main() {
  late NetworkStatusImpl networkStatus;
  late MockInternetConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockInternetConnectionChecker();
    networkStatus = NetworkStatusImpl(mockDataConnectionChecker);
  });

  group('isConnected', () {
    test(
      'should forward the call to InternetConnectionChecker.hasConnection',
      () async {
        // arrange
        final tHasConnectionFuture = Future.value(true);
        when(() => mockDataConnectionChecker.hasConnection)
            .thenAnswer((_) => tHasConnectionFuture);
        // act
        final result = networkStatus.isConnected;
        // assert
        verify(() => networkStatus.isConnected).called(1);
        expect(result, equals(tHasConnectionFuture));
      },
    );
  });
}
