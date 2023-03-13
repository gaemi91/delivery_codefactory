import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerStorage = Provider<FlutterSecureStorage>((ref) => const FlutterSecureStorage());
