import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_peminjaman_controller.dart';

class AddPeminjamanView extends GetView<AddPeminjamanController> {
  const AddPeminjamanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${Get.parameters['judul'].toString()}'),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Text('Buku yang dipinjam : ${Get.parameters['judul'].toString()}'),
                // TextFormField(
                //   controller: controller.tanggalPinjamController,
                //   decoration: InputDecoration(hintText: "Masukkan Tanggal Pinjam"),
                //   validator: (value) {
                //     if (value!.length < 2) {
                //       return "Tanggal Pinjam tidak boleh kosong";
                //     }
                //     return null;
                //   },
                // ),
                // TextFormField(
                //   controller: controller.tanggalKembaliController,
                //   decoration: InputDecoration(hintText: "Masukkan Tanggal Kembali"),
                //   validator: (value) {
                //     if (value!.length < 2) {
                //       return "Tanggal Kembali tidak boleh kosong";
                //     }
                //     return null;
                //   },
                // ),
                TextFormField(
                  controller: controller.tanggalPinjamController,
                  decoration: InputDecoration(
                      label: Text("date"),
                      hintText: "Masukkan Tanggal Pinjam"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Tanggal Pinjam tidak boleh kosong";
                    }
                    return null;
                  },
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );

                    if (selectedDate != null) {
                      // Format the selected date as needed
                      String formattedDate = "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";

                      // Update the TextFormField's value
                      controller.tanggalPinjamController.text = formattedDate;
                    }
                  },
                ),TextFormField(
                  controller: controller.tanggalKembaliController,
                  decoration: InputDecoration(
                      label: Text("date"),
                      hintText: "Masukkan Tanggal Pinjam"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Tanggal Pinjam tidak boleh kosong";
                    }
                    return null;
                  },
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );

                    if (selectedDate != null) {
                      // Format the selected date as needed
                      String formattedDate = "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";

                      // Update the TextFormField's value
                      controller.tanggalKembaliController.text = formattedDate;
                    }
                  },
                ),

                Obx(() => controller.loading.value
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                    onPressed: () {
                      controller.addPeminjaman();
                    },
                    child: Text("Pinjam")))
              ],
            )),
      ),
    );
  }
}
