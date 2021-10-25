import 'package:kriya_test_vikral/global/network/network_info.dart';

import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helper/setup_mockito_generate_mocks.mocks.dart';

void main() {
  late NetworkInfoImpl networkInfo;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(mockInternetConnectionChecker);
  });

  group('Network Info', () {
    test(
      'should return isConnected when having internet connection',
      () async {
        // arrange
        final tHasConnectionFuture = Future.value(true);

        when(mockInternetConnectionChecker.hasConnection)
            .thenAnswer((_) => tHasConnectionFuture);
        // act
        networkInfo.isConnected;
        // assert
        verify(mockInternetConnectionChecker.hasConnection);
      },
    );
  });
}
