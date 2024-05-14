import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:listing_tasks_app/firestore_produtos/helpers/enum_order.dart';

import '../model/produto.dart';

class ProdutoService {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  adicionarProduto({required String listinId, required Produto produto}) {
    firestore
        .collection(uid)
        .doc(listinId)
        .collection("produtos")
        .doc(produto.id)
        .set(produto.toMap());
  }

  Future<List<Produto>> lerProdutos(
      {required String listinId,
      required OrdemProduto ordem,
      required bool isDecrescent}) async {
    List<Produto> temp = [];

    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection(uid)
        .doc(listinId)
        .collection("produtos")
        //.where("isComprado", isEqualTo: isComprado)
        .orderBy(ordem.name, descending: isDecrescent)
        .get();

    for (var doc in snapshot.docs) {
      Produto produto = Produto.fromMap(doc.data());
      temp.add(produto);
    }

    return temp;
  }

  Future<void> alternarProduto(
      {required String listinId, required Produto produto}) async {
    await firestore
        .collection(uid)
        .doc(listinId)
        .collection("produtos")
        .doc(produto.id)
        .update({"isComprado": produto.isComprado});
  }

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>
      conectarStreamProdutos(
          {required Function refresh,required String listinId,
          required OrdemProduto ordem,
          required bool isDecrescent, required BuildContext context}) {
    return firestore
        .collection(uid)
        .doc(listinId)
        .collection("produtos")
        .orderBy(ordem.name, descending: isDecrescent)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.metadata.isFromCache) {
        // Se os dados vêm do cache, opcionalmente não mostrar SnackBars
        // ou tratar de forma diferenciada.
      } else {
        for (var change in snapshot.docChanges) {
          // Usando switch para lidar com diferentes tipos de mudanças
          switch (change.type) {
            case DocumentChangeType.added:
              // Verificamos se a mudança é devido a uma adição real
              if (change.oldIndex == -1) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Produto adicionado: ${change.doc.data()?['name']}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  backgroundColor: Colors.greenAccent,
                ));
              }
              break;
            case DocumentChangeType.modified:
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  "Produto alterado: ${change.doc.data()?['name']}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                backgroundColor: Colors.orangeAccent,
              ));
              break;
            case DocumentChangeType.removed:
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  "Produto removido: ${change.doc.data()?['name']}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                backgroundColor: Colors.redAccent,
              ));
              break;
          }
        }
      }
      refresh(snapshot: snapshot);
    });
  }

  Future<void> removerProduro({required String listinId, required Produto produto})async{
    return await firestore.collection(uid).doc(listinId).collection('produtos').doc(produto.id).delete();
}
}
