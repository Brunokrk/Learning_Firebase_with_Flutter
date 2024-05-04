import 'package:cloud_firestore/cloud_firestore.dart';


class FirestoreAnalytics {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  upAcessosTotais(){
    _increment('acessos_totais');
  }

  upListasAdicionadas(){
    _increment('listas_adicionadas');
  }

  upAtualizacoesTotais(){
    _increment('atualizacoes_manuais');
  }

  _increment(String field)async{
    DocumentSnapshot<Map<String, dynamic>>snapshot = await firestore.collection("analytics").doc("geral").get();

    Map<String, dynamic> document = {};

    if(snapshot.data() != null){
      document = snapshot.data()!;
    }

    if(document[field] != null){
      document[field] ++;
    }else{
      //inicializa
      document[field] = 1;
    }

    //Atualizamos o firestore
    firestore.collection("analytics").doc("geral").set(document);
  }

}