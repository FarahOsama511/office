import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:office_office/core/helpers/dio_helper.dart';
import 'package:office_office/core/networking/api_endpoints.dart';
import 'package:office_office/features/Home/data/repositiries/get_my_orders_repo.dart';
import 'package:office_office/features/Home/data/webservices/get_my_orders_webservice.dart';
import 'fetch_myorder_test.mocks.mocks.dart';

@GenerateMocks([DioHelper])
void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  late MockDioHelper mockDioHelper;
  late GetMyOrdersRepo myOrders;

  setUp(() {
    mockDioHelper = MockDioHelper();
    myOrders = GetMyOrdersRepo(GetMyOrdersWebservice(dioHelper: mockDioHelper));
  });

  group('fetch My Orders', () {
    test("returns myOrders if the dio call completes successfully", () async {
      final url = ApiEndpoints.myOrders;

      when(
        mockDioHelper.getData(url: url, query: anyNamed('query')),
      ).thenAnswer(
        (_) async => Response(
          data: {
            "data": [
              {
                "id": "95",
                "room": 5,
                "voice":
                    "https://api.officea.com/storage/voices/1763042861.mp3",
                "status": "onprogress",
                "item": {
                  "id": "102",
                  "name": "Berry Juice",
                  "description": "Fresh juice",
                },
                "itemId": "102",
                "spoons": 2,
                "createdAt": "2025-11-13T16:07:39.000",
              },
              {
                "id": "55",
                "room": 5,
                "voice":
                    "https://api.officea.com/storage/voices/1763042783.mp3",
                "status": "onprogress",
                "item": {
                  "id": "102",
                  "name": "Berry Juice",
                  "description": "Fresh juice",
                },
                "itemId": 101,
                "spoons": 2,
                "createdAt": "2025-11-13T16:06:21.000",
              },
              {
                "id": "22",
                "room": 6,
                "voice":
                    "https://api.officea.com/storage/voices/1763042213.mp3",
                "status": "onprogress",
                "item": {
                  "id": "102",
                  "name": "Berry Juice",
                  "description": "Fresh juice",
                },
                "itemId": "102",
                "spoons": 2,
                "createdAt": "2025-11-13T15:56:50.000",
              },
            ],
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: ""),
        ),
      );

      final result = await myOrders.getMyOrders();

      verify(
        mockDioHelper.getData(url: url, query: anyNamed('query')),
      ).called(1);

      expect(result.isRight(), true);

      result.fold((error) => fail("Expected success, got error: $error"), (
        orders,
      ) {
        expect(orders.length, 3);
      });
    });
  });
}
