import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peminjam_perpustakaan_c/app/data/constant/endpoint.dart';
import 'package:peminjam_perpustakaan_c/app/data/provider/api_provider.dart';
import 'package:dio/dio.dart' as dio;

class RegisterController extends GetxController {
  //TODO: Implement RegisterController
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController telpController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final count = 0.obs;
  final loading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  register() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        final response = await ApiProvider.instance().post(Endpoint.register,
            data: dio.FormData.fromMap({
              "nama": namaController.text.toString(),
              "username": usernameController.text.toString(),
              "telp": int.parse(telpController.text.toString()),
              "alamat": alamatController.text.toString(),
              "password": passwordController.text.toString(),
            }));
        if (response.statusCode == 201) {
          Get.back();
          // Get.snackbar("Berhasil", "",
          //     backgroundColor: Colors.green);
          // Get.offAllNamed(Routes.BOOK);
        } else {
          Get.snackbar("Sorry", "Register Gagal", backgroundColor: Colors.orange);
        }
      }
      loading(false);
    } on dio.DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          Get.snackbar("Sorry", "${e.response?.data['message']}",
              backgroundColor: Colors.orange);
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      loading(false);
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }
}
