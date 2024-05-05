import 'package:bpbm2/data/models/auth_model/auth_model.dart';
import 'package:bpbm2/data/models/auth_model/user_model.dart';
import 'package:bpbm2/data/source/auth_data_source.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authRepository = AuthRepository(dataSouce: AuthRemoteDataSource());

abstract class IAuthRepository {
  Future<void> sendSms({required String cellNumber});
  Future<AuthModel> verifySms({
    required String cellNumber,
    required String otpCode,
  });
  Future<void> signOut();
}

class AuthRepository implements IAuthRepository {
  static final ValueNotifier<AuthModel?> authChangeNotifier =
      ValueNotifier(null);
  final IAuthDataSource dataSouce;

  const AuthRepository({required this.dataSouce});

  @override
  Future<void> sendSms({required String cellNumber}) async {
    return dataSouce.sendSms(cellNumber: cellNumber);
  }

  @override
  Future<AuthModel> verifySms(
      {required String cellNumber, required String otpCode}) async {
    final auth = await dataSouce.verifySms(
      cellNumber: cellNumber,
      otpCode: otpCode,
    );
    saveInfo(authModel: auth);
    return auth;
  }

  Future<void> saveInfo({required AuthModel authModel}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', authModel.token);
    prefs.setString('cellNumber', authModel.user.cellNumber);
    prefs.setInt('userId', authModel.user.id);
  }

  Future<void> loadInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? '';
    final String cellNumber = prefs.getString('cellNumber') ?? '';
    final int userId = prefs.getInt('userId') ?? 0;

    UserModel user = UserModel(
      id: userId,
      cellNumber: cellNumber,
    );

    if (token.isNotEmpty) {
      authChangeNotifier.value = AuthModel(
        token: token,
        user: user,
      );
    }
  }

  @override
  Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('userId');
    prefs.remove('cellNumber');
    // prefs.clear();
    authChangeNotifier.value = null;
  }
}
