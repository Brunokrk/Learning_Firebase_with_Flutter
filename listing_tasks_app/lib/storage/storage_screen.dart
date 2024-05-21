import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:listing_tasks_app/authentication/component/show_snackbar.dart';
import 'package:listing_tasks_app/storage/services/storage_service.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({super.key});

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  String? urlPhoto;
  List<String> listFiles = [];
  final StorageService _storageService = StorageService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Foto de Perfil"),
        actions: [
          IconButton(
            onPressed: () {
              uploadImage();
            },
            icon: Icon(
              Icons.upload,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              reload();
            },
            icon: Icon(Icons.refresh, color: Colors.white),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(32),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            (urlPhoto != null)
                ? Image.network(urlPhoto!)
                : const CircleAvatar(
                    radius: 64,
                    child: Icon(Icons.person),
                  ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Divider(
                color: Colors.black,
              ),
            ),
            const Text(
              "Histórico de Imagens",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Column(children: List.generate(listFiles.length, (index){
              String url = listFiles[index];
              return Image.network(url);
            }),)
          ],
        ),
      ),
    );
  }

  uploadImage() {
    ImagePicker imagePicker = ImagePicker();
    imagePicker.pickImage(source: ImageSource.gallery, maxHeight: 2000, maxWidth: 2000, imageQuality: 50).then((XFile? image){
      if(image!=null){
        _storageService.upload(file: File(image.path), fileName: "user_photo").then((String urlDownload) {
          setState(() {
            urlPhoto = urlDownload;
          });
        });
        
      }else{
        showSnackBar(context: context, mensagem: "Nenhuma imagem selecionada");
      }

    });
  }

  reload() {
    _storageService.getDownloadUrlByFileName(fileName: "user_photo").then((urlDownload){
      setState(() {
        urlPhoto = urlDownload;
      });
    });
  }
}
