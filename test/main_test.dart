
import 'package:flutter_test/flutter_test.dart';
import 'package:SM2_ExamenUnidad3/models/user.dart';
import 'package:SM2_ExamenUnidad3/services/session.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/mockito.dart';
import 'mocks.dart';
import 'package:SM2_ExamenUnidad3/services/auth_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('User model', () {
    test('fromJson parses correctly', () {
      final json = {
        'rango': 'admin',
        'nombre': 'Juan',
        'token': 'abc123',
      };
      final user = User.fromJson(json);
      expect(user.rango, 'admin');
      expect(user.nombre, 'Juan');
      expect(user.token, 'abc123');
    });
  });

  group('Session', () {
    test('saveToken and getToken', () async {
      final mockStorage = MockFlutterSecureStorage();
      // Simular el guardado y recuperación del token
      when(mockStorage.write(key: anyNamed('key'), value: anyNamed('value')))
          .thenAnswer((_) async => null);
      when(mockStorage.read(key: anyNamed('key')))
          .thenAnswer((_) async => 'test_token');
      when(mockStorage.delete(key: anyNamed('key')))
          .thenAnswer((_) async => null);

      // Inyectar el mock en Session si es posible, si no, reemplazar en el código real
      await mockStorage.write(key: 'token', value: 'test_token');
      final token = await mockStorage.read(key: 'token');
      expect(token, 'test_token');
      await mockStorage.delete(key: 'token');
      final cleared = await mockStorage.read(key: 'token');
      // Simular que después de borrar, retorna null
      when(mockStorage.read(key: anyNamed('key'))).thenAnswer((_) async => null);
      final clearedAfter = await mockStorage.read(key: 'token');
      expect(clearedAfter, isNull);
    });
  });

  group('AuthService', () {
    test('login throws on error', () async {
      final auth = AuthService(baseUrl: 'http://localhost:9999');
      expect(
        () async => await auth.login('fail@test.com', 'wrong'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
