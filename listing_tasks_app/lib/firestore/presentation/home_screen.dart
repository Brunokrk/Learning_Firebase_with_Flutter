import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:listing_tasks_app/authentication/component/show_senha_confirmacao_dialog.dart';
import 'package:listing_tasks_app/firestore/helpers/firestore_analytics.dart';
import 'package:listing_tasks_app/firestore_produtos/presentation/produto_screen.dart';
import 'package:listing_tasks_app/storage/storage_screen.dart';
import 'package:uuid/uuid.dart';
import '../../authentication/services/auth_service.dart';
import '../models/listin.dart';
import '../services/listin_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.user});

  final User user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ListinService listinService = ListinService();
  List<Listin> listListins = [];

  @override
  void initState() {
    refresh();
    //analytics.upAcessosTotais();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: (widget.user.photoURL!= null)? NetworkImage(widget.user.photoURL!):null,
                ),
                accountName: Text((widget.user.displayName != null)
                    ? widget.user.displayName!
                    : ""),
                accountEmail: Text(widget.user.email!)),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Mudar foto de perfil'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const StorageScreen(),));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.highlight_remove_outlined,
                color: Colors.red,
              ),
              title: const Text('Remover conta'),
              onTap: () {
                showSenhaConfirmacaoDialog(context: context, email: "");
                //AuthService().removerConta();
              },
            ),
            ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Sair"),
                onTap: () {
                  AuthService().deslogar();
                })
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Listin - Feira Colaborativa"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showFormModal();
        },
        child: const Icon(Icons.add),
      ),
      body: (listListins.isEmpty)
          ? const Center(
              child: Text(
                "Nenhuma lista ainda.\nVamos criar a primeira?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            )
          : RefreshIndicator(
              onRefresh: () {
                //analytics.upAtualizacoesTotais();
                return refresh();
              },
              child: ListView(
                children: List.generate(
                  listListins.length,
                  (index) {
                    Listin model = listListins[index];
                    return Dismissible(
                      key: ValueKey<Listin>(model),
                      direction: DismissDirection.endToStart,
                      background: Container(
                          padding: const EdgeInsets.only(right: 16),
                          alignment: Alignment.centerRight,
                          color: Colors.red,
                          child: const Icon(Icons.delete, color: Colors.red)),
                      onDismissed: (direction) {
                        remove(model);
                      },
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProdutoScreen(listin: model),
                              ));
                        },
                        onLongPress: () {
                          showFormModal(model: model);
                        },
                        leading: const Icon(Icons.list_alt_rounded),
                        title: Text(model.name),
                        //subtitle: Text(model.id),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }

  showFormModal({Listin? model}) {
    // Labels à serem mostradas no Modal
    String title = "Adicionar Listin";
    String confirmationButton = "Salvar";
    String skipButton = "Cancelar";

    // Controlador do campo que receberá o nome do Listin
    TextEditingController nameController = TextEditingController();

    if (model != null) {
      //está editando
      title = "Editando ${model.name}";
      nameController.text = model.name;
    }

    // Função do Flutter que mostra o modal na tela
    showModalBottomSheet(
      context: context,
      // Define que as bordas verticais serão arredondadas
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(32.0),

          // Formulário com Título, Campo e Botões
          child: ListView(
            children: [
              Text(title, style: Theme.of(context).textTheme.headline5),
              TextFormField(
                controller: nameController,
                decoration:
                    const InputDecoration(label: Text("Nome do Listin")),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(skipButton),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Listin listin = Listin(
                            id: const Uuid().v1(),
                            name:
                                nameController.text); // sempre terá um novo ID

                        if (model != null) {
                          listin.id = model.id;
                        }

                        //salvando no firestore
                        listinService.adicionarListin(listin: listin);
                        refresh();

                        Navigator.pop(context);
                      },
                      child: Text(confirmationButton)),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  refresh() async {
    List<Listin> listaListins = await listinService.lerListins();

    setState(() {
      listListins = listaListins;
    });
  }

  void remove(Listin model) async {
    await listinService.removerListin(listinId: model.id);
    refresh();
  }
}
