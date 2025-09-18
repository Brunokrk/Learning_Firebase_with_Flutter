# 📱 Listin - Lista Colaborativa

Um aplicativo Flutter de listas de compras com integração completa ao Firebase, desenvolvido para consolidar conhecimentos sobre autenticação, Firestore e Storage.

## 🎯 Objetivo do Projeto

Este projeto foi desenvolvido com foco principal em **aprender e implementar a integração completa com Firebase**, explorando os principais serviços:
- **Firebase Authentication** - Autenticação de usuários
- **Cloud Firestore** - Banco de dados NoSQL em tempo real
- **Firebase Storage** - Armazenamento de arquivos e imagens

## 🚀 Funcionalidades

### 🔐 Sistema de Autenticação
- **Cadastro de usuários** com email e senha
- **Login** com validação de credenciais
- **Recuperação de senha** via email
- **Logout** seguro
- **Exclusão de conta** com confirmação de senha

### 📋 Gestão de Listas
- **Criação de listas** personalizadas
- **Visualização** de todas as listas do usuário
- **Exclusão** de listas
- **Organização** por usuário (cada usuário vê apenas suas listas)

### 🛒 Gestão de Produtos
- **Adição de produtos** às listas
- **Edição** de produtos (nome, preço, quantidade)
- **Marcação** de produtos como comprados/não comprados
- **Ordenação** por diferentes critérios (nome, preço, quantidade)
- **Exclusão** de produtos
- **Atualizações em tempo real** com notificações

### 📸 Gerenciamento de Imagens
- **Upload de imagens** para perfil do usuário
- **Visualização** de todas as imagens do usuário
- **Download** de URLs das imagens
- **Exclusão** de imagens
- **Informações de metadados** (tamanho, nome)

## 🏗️ Arquitetura do Projeto

```
lib/
├── _core/
│   └── my_colors.dart                 # Cores personalizadas
├── authentication/
│   ├── component/                     # Componentes de UI
│   ├── screens/
│   │   └── auth_screen.dart          # Tela de login/cadastro
│   └── services/
│       └── auth_service.dart         # Serviços de autenticação
├── firestore/
│   ├── helpers/
│   │   └── firestore_analytics.dart  # Analytics do Firestore
│   ├── models/
│   │   └── listin.dart              # Modelo de Lista
│   ├── presentation/
│   │   └── home_screen.dart         # Tela principal
│   └── services/
│       └── listin_service.dart      # Serviços de listas
├── firestore_produtos/
│   ├── helpers/
│   │   └── enum_order.dart          # Enum para ordenação
│   ├── model/
│   │   └── produto.dart             # Modelo de Produto
│   ├── presentation/
│   │   ├── produto_screen.dart      # Tela de produtos
│   │   └── widgets/                 # Widgets específicos
│   └── services/
│       └── produto_service.dart     # Serviços de produtos
├── storage/
│   ├── models/
│   │   └── image_custom_info.dart   # Modelo de informações de imagem
│   ├── services/
│   │   └── storage_service.dart     # Serviços de storage
│   └── storage_screen.dart          # Tela de gerenciamento de imagens
├── firebase_options.dart            # Configurações do Firebase
└── main.dart                        # Ponto de entrada da aplicação
```

## 🔧 Configuração do Firebase

### 1. Configuração do Projeto Firebase

O projeto está configurado com o Firebase usando o arquivo `firebase_options.dart`:

```dart
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    // Configurações para Android, iOS, Web, etc.
  }
}
```

### 2. Serviços Habilitados

#### Firebase Authentication
- **Método de autenticação**: Email/Senha
- **Funcionalidades**: Login, Cadastro, Recuperação de senha, Logout

#### Cloud Firestore
- **Estrutura de dados**:
  ```
  /{userId}/
    ├── {listinId}/
    │   ├── name: string
    │   └── produtos/
    │       └── {produtoId}/
    │           ├── name: string
    │           ├── price: double
    │           ├── amount: double
    │           └── isComprado: boolean
  ```

## 🛠️ Tecnologias Utilizadas

- **Flutter** 3.2.6+
- **Dart** 3.2.6+
- **Firebase Core** 2.32.0
- **Firebase Auth** 4.20.0
- **Cloud Firestore** 4.17.5
- **Firebase Storage** 11.7.7
- **Image Picker** 1.2.0
- **UUID** 4.5.1

## 📦 Instalação e Configuração

### Pré-requisitos
- Flutter SDK 3.2.6 ou superior
- Android Studio / VS Code
- Conta Firebase
- Dispositivo Android/iOS ou emulador

### Passos de Instalação

1. **Clone o repositório**
   ```bash
   git clone <url-do-repositorio>
   cd listing_tasks_app
   ```

2. **Instale as dependências**
   ```bash
   flutter pub get
   ```

3. **Configure o Firebase**
   - Crie um projeto no [Firebase Console](https://console.firebase.google.com/)
   - Adicione um app Android/iOS
   - Baixe o arquivo `google-services.json` (Android) ou `GoogleService-Info.plist` (iOS)
   - Coloque na pasta apropriada (`android/app/` ou `ios/Runner/`)

4. **Configure as regras de segurança**
   - No Firestore: Configure as regras para permitir apenas acesso aos próprios dados
   - No Storage: Configure as regras para permitir upload apenas do usuário autenticado

5. **Execute o aplicativo**
   ```bash
   flutter run
   ```

## 🎨 Interface do Usuário

### Telas Principais

1. **Tela de Autenticação** (`auth_screen.dart`)
   - Login e cadastro em uma única tela
   - Validação de formulários
   - Recuperação de senha
   - Interface responsiva e intuitiva

2. **Tela Principal** (`home_screen.dart`)
   - Lista de todas as listas do usuário
   - Criação de novas listas
   - Navegação para outras funcionalidades

3. **Tela de Produtos** (`produto_screen.dart`)
   - Lista de produtos com ordenação
   - Adição e edição de produtos
   - Marcação de produtos como comprados
   - Atualizações em tempo real

4. **Tela de Storage** (`storage_screen.dart`)
   - Upload de imagens
   - Visualização de imagens
   - Gerenciamento de arquivos

## 🔄 Funcionalidades em Tempo Real

O aplicativo utiliza **Streams do Firestore** para atualizações em tempo real:

```dart
// Exemplo de stream para produtos
firestore
  .collection(uid)
  .doc(listinId)
  .collection("produtos")
  .snapshots()
  .listen((snapshot) {
    // Atualizar UI em tempo real
    // Mostrar notificações de mudanças
  });
```

### Notificações Automáticas
- ✅ **Produto adicionado** - Notificação verde
- 🔄 **Produto alterado** - Notificação laranja  
- ❌ **Produto removido** - Notificação vermelha

## 📊 Estrutura de Dados

### Modelo Listin
```dart
class Listin {
  String id;      // ID único da lista
  String name;    // Nome da lista
}
```

### Modelo Produto
```dart
class Produto {
  String id;         // ID único do produto
  String name;       // Nome do produto
  double? price;     // Preço (opcional)
  double? amount;    // Quantidade (opcional)
  bool isComprado;   // Status de compra
}
```

### Modelo ImageCustomInfo
```dart
class ImageCustomInfo {
  String urlDownload;  // URL de download
  String name;         // Nome do arquivo
  String size;         // Tamanho em KB
  Reference ref;       // Referência do Storage
}
```

## 🔒 Segurança

### Autenticação
- Todas as operações requerem usuário autenticado
- Validação de credenciais no Firebase
- Tratamento de erros de autenticação

### Autorização
- Usuários só acessam seus próprios dados
- Regras de segurança no Firestore e Storage
- Isolamento de dados por UID do usuário


## 📝 Licença

Este projeto foi desenvolvido para fins educacionais e de aprendizado da integração com Firebase.

## 🤝 Contribuição

Este é um projeto de aprendizado, mas sugestões e melhorias são sempre bem-vindas!

---

**Desenvolvido com ❤️ usando Flutter e Firebase**