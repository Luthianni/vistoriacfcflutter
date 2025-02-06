import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class UtilsServices {
  final FlutterSecureStorage _storage;

  // Construtor que permite injeção de dependências (para testes ou substituições)
  UtilsServices({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  // Métodos de armazenamento seguro
  Future<void> saveLocalData({required String key, required String data}) async {
    await _storage.write(key: key, value: data);
  }

  Future<String?> getLocalData({required String key}) async {
    return await _storage.read(key: key);
  }

  Future<void> removeLocalData({required String key}) async {
    await _storage.delete(key: key);
  }

  // Método de formatação de data/hora
  String formatDateTime(DateTime dateTime) {
    initializeDateFormatting();
    final dateFormat = DateFormat.yMd('pt_BR').add_Hm();
    return dateFormat.format(dateTime);
  }

  // Exibição de Snackbar global
  void showGlobalToast({
    required BuildContext context,
    required String message,
    bool isError = false,
  }) {
    showContextualToast(
      context: context,
      message: message,
      isError: isError,
    );
  }

  // Exibição de Snackbar com contexto específico
  void showContextualToast({
    required BuildContext context,
    required String message,
    String title = 'Notificação',
    bool isError = false,
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: isError ? ContentType.failure : ContentType.success,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  // Método genérico para exibição de erros
  void showErrorToast({required BuildContext context, required String message}) {
    showGlobalToast(context: context, message: message, isError: true);
  }

  // Método genérico para exibição de sucessos
  void showSuccessToast({required BuildContext context, required String message}) {
    showGlobalToast(context: context, message: message, isError: false);
  }
}