import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peminjam_perpustakaan_c/app/data/constant/endpoint.dart';
import 'package:peminjam_perpustakaan_c/app/data/provider/api_provider.dart';
import 'package:dio/dio.dart' as dio;
import 'package:peminjam_perpustakaan_c/app/data/provider/storage_provider.dart';
import 'package:peminjam_perpustakaan_c/app/routes/app_pages.dart';

class AddPeminjamanController extends GetxController {
  //TODO: Implement AddPeminjamanController
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController tanggalPinjamController = TextEditingController();
  final TextEditingController tanggalKembaliController = TextEditingController();
  // final TextEditingController penerbitController = TextEditingController();
  // final TextEditingController tahun_terbitController = TextEditingController();
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

  addPeminjaman() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        final response = await ApiProvider.instance().post(Endpoint.pinjam,
            data: dio.FormData.fromMap({
              "user_id": int.parse(StorageProvider.read(StorageKey.idUser)),
              "book_id":  int.parse(Get.parameters['id'].toString()),
              "tanggal_pinjam": tanggalPinjamController.text.toString(),
              "tanggal_kembali": tanggalKembaliController.text.toString(),
            }));
        if (response.statusCode == 201) {
          // Get.back();
          Get.snackbar("Berhasil", "",
              backgroundColor: Colors.green);
          Get.offAllNamed(Routes.HOME);
        } else {
          Get.snackbar("Sorry", "Tambah Pinjam Gagal", backgroundColor: Colors.orange);
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
