
import 'package:flutter_test/flutter_test.dart';
import 'package:SM2_ExamenUnidad3/models/user.dart';
import 'package:SM2_ExamenUnidad3/services/session.dart';
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
      // Este test requiere flutter_secure_storage mockeado en entorno real
      // Aquí solo se muestra la estructura
      await Session.saveToken('test_token');
      final token = await Session.getToken();
      expect(token, 'test_token');
      await Session.clear();
      final cleared = await Session.getToken();
      expect(cleared, isNull);
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
