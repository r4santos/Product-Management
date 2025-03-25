import 'dart:io';

void main() {
  List<Produto> produtos = [];
  CarrinhoDeCompras carrinho = CarrinhoDeCompras();
  int id = 0;

  bool sair = false;

  while (!sair) {
    print('-' * 40);
    print('1 - Cadastrar produto');
    print('2 - Ver produtos');
    print('3 - Alterar preço');
    print('4 - Vender produto');
    print('5 - Repor estoque');
    print('6 - Gerenciar Carrinho');
    print('7 - Sair');
    stdout.write('=> ');
    String escolha = stdin.readLineSync() ?? '';

    switch (escolha) {
      case '1':
        print('-' * 40);
        stdout.write('Nome do produto: ');
        String nome = stdin.readLineSync() ?? '';

        double preco = 0;
        bool precoValido = false;
        while (!precoValido) {
          stdout.write('Preço do produto: ');
          String sPreco = stdin.readLineSync() ?? '';
          try {
            preco = double.parse(sPreco);
            if (preco > 0) {
              precoValido = true;
            } else {
              print('O preço deve ser maior que zero');
            }
          } catch (e) {
            print('Valor inválido. Digite um número válido.');
          }
        }

        int estoque = 0;
        bool estoqueValido = false;
        while (!estoqueValido) {
          stdout.write('Quantidade em estoque: ');
          String sEstoque = stdin.readLineSync() ?? '';
          try {
            estoque = int.parse(sEstoque);
            if (estoque >= 0) {
              estoqueValido = true;
            } else {
              print('O estoque não pode ser negativo');
            }
          } catch (e) {
            print('Valor inválido. Digite um número inteiro válido.');
          }
        }

        stdout.write('Descrição do produto: ');
        String descricao = stdin.readLineSync() ?? '';

        Produto p = Produto(
          nome,
          preco,
          estoque,
          descricao.isEmpty ? null : descricao,
        );

        produtos.add(p);
        print('\nProduto cadastrado com sucesso! ID: ${id++}');
        break;

      case '2':
        print('-' * 40);
        if (produtos.isEmpty) {
          print('Nenhum produto cadastrado.');
        } else {
          print('Lista de Produtos:');
          for (int i = 0; i < produtos.length; i++) {
            print('ID: ${i + 1}');
            print(produtos[i]);
            print('-' * 40);
          }
        }
        enter();
        break;

      case '3':
        print('-' * 40);
        if (produtos.isEmpty) {
          print('Nenhum produto cadastrado para alterar.');
          break;
        }

        print('Produtos disponíveis:');
        for (int i = 0; i < produtos.length; i++) {
          print('${i + 1} - ${produtos[i].nome}');
        }

        stdout.write('Digite o ID do produto para alterar o preço: ');
        int idAlterar = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

        if (idAlterar < 1 || idAlterar > produtos.length) {
          print('ID inválido.');
          break;
        }

        double novoPreco = 0;
        bool novoPrecoValido = false;
        while (!novoPrecoValido) {
          stdout.write('Novo preço para ${produtos[idAlterar - 1].nome}: ');
          String sNovoPreco = stdin.readLineSync() ?? '';
          try {
            novoPreco = double.parse(sNovoPreco);
            if (novoPreco > 0) {
              novoPrecoValido = true;
            } else {
              print('O preço deve ser maior que zero');
            }
          } catch (e) {
            print('Valor inválido. Digite um número válido.');
          }
        }

        produtos[idAlterar - 1].setPreco = novoPreco;
        print('Preço atualizado com sucesso!');
        enter();
        break;

      case '4':
        print('-' * 40);
        if (produtos.isEmpty) {
          print('Nenhum produto cadastrado para vender.');
          break;
        }

        print('Produtos disponíveis:');
        for (int i = 0; i < produtos.length; i++) {
          print(
            '${i + 1} - ${produtos[i].nome} (Estoque: ${produtos[i].getQuantidadeEmEstoque})',
          );
        }

        stdout.write('Digite o ID do produto para vender: ');
        int idVender = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

        if (idVender < 1 || idVender > produtos.length) {
          print('ID inválido.');
          break;
        }

        int quantidadeVender = 0;
        bool quantidadeValida = false;
        while (!quantidadeValida) {
          stdout.write('Quantidade a vender: ');
          String sQuantidade = stdin.readLineSync() ?? '';
          try {
            quantidadeVender = int.parse(sQuantidade);
            if (quantidadeVender > 0) {
              quantidadeValida = true;
            } else {
              print('A quantidade deve ser maior que zero');
            }
          } catch (e) {
            print('Valor inválido. Digite um número inteiro válido.');
          }
        }

        bool vendaSucesso = produtos[idVender - 1].vender(quantidadeVender);
        if (vendaSucesso) {
          print(
            'Novo estoque: ${produtos[idVender - 1].getQuantidadeEmEstoque}',
          );
        }
        enter();
        break;

      case '5':
        print('-' * 40);
        if (produtos.isEmpty) {
          print('\nNenhum produto cadastrado para repor estoque.');
          break;
        }

        print('\nProdutos disponíveis:');
        for (int i = 0; i < produtos.length; i++) {
          print(
            '${i + 1} - ${produtos[i].nome} (Estoque: ${produtos[i].getQuantidadeEmEstoque})',
          );
        }

        stdout.write('\nDigite o ID do produto para repor estoque: ');
        int idRepor = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

        if (idRepor < 1 || idRepor > produtos.length) {
          print('ID inválido.');
          break;
        }

        int quantidadeRepor = 0;
        bool quantidadeReporValida = false;
        while (!quantidadeReporValida) {
          stdout.write('Quantidade a repor: ');
          String sQuantidade = stdin.readLineSync() ?? '';
          try {
            quantidadeRepor = int.parse(sQuantidade);
            if (quantidadeRepor > 0) {
              quantidadeReporValida = true;
            } else {
              print('A quantidade deve ser maior que zero');
            }
          } catch (e) {
            print('Valor inválido. Digite um número inteiro válido.');
          }
        }

        produtos[idRepor - 1].reporEstoque(quantidadeRepor);
        print('Estoque reposto com sucesso!');
        print('Novo estoque: ${produtos[idRepor - 1].getQuantidadeEmEstoque}');
        enter();
        break;

      case '6':
        gerenciarCarrinho(carrinho, produtos);
        break;

      case '7':
        sair = true;
        break;

      default:
        print('Valor inválido');
        break;
    }
  }
}

void gerenciarCarrinho(CarrinhoDeCompras carrinho, List<Produto> produtos) {
  bool voltar = false;

  while (!voltar) {
    print('\n=== GERENCIAR CARRINHO ===');
    print('1 - Adicionar produto');
    print('2 - Ver carrinho');
    print('3 - Finalizar compra');
    print('4 - Voltar ao menu principal');
    stdout.write('=> ');
    String opcao = stdin.readLineSync() ?? '';

    switch (opcao) {
      case '1':
        if (produtos.isEmpty) {
          print('Nenhum produto cadastrado.');
          enter();
          break;
        }

        print('\nProdutos disponíveis:');
        for (int i = 0; i < produtos.length; i++) {
          print(
            '${i + 1} - ${produtos[i].nome} (R\$ ${produtos[i].getPreco.toStringAsFixed(2)}) - Estoque: ${produtos[i].getQuantidadeEmEstoque}',
          );
        }

        stdout.write('\nDigite o número do produto: ');
        int escolha = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

        if (escolha < 1 || escolha > produtos.length) {
          print('Opção inválida!');
          enter();
          break;
        }

        Produto produtoEscolhido = produtos[escolha - 1];

        stdout.write('Quantidade: ');
        int quantidade = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

        if (quantidade <= 0) {
          print('Quantidade inválida!');
          enter();
          break;
        }

        if (quantidade > produtoEscolhido.getQuantidadeEmEstoque) {
          print('Estoque insuficiente!');
          enter();
          break;
        }

        carrinho.adicionar(produtoEscolhido, quantidade);
        print('\n${produtoEscolhido.nome} adicionado ao carrinho!');
        enter();
        break;

      case '2':
        print('\n=== SEU CARRINHO ===');
        if (carrinho.produtos.isEmpty) {
          print('Carrinho vazio');
        } else {
          double total = 0;
          for (int i = 0; i < carrinho.produtos.length; i++) {
            Produto p = carrinho.produtos[i];
            int qtd = carrinho.quantidades[i];
            double subtotal = p.getPreco * qtd;
            print(
              '${p.nome} - $qtd x R\$ ${p.getPreco.toStringAsFixed(2)} = R\$ ${subtotal.toStringAsFixed(2)}',
            );
            total += subtotal;
          }
          print('\nTOTAL: R\$ ${total.toStringAsFixed(2)}');
        }
        enter();
        break;

      case '3':
        if (carrinho.produtos.isEmpty) {
          print('Carrinho vazio!');
          enter();
          break;
        }

        carrinho.finalizar();
        print('Compra finalizada com sucesso!');
        enter();
        break;

      case '4':
        voltar = true;
        break;

      default:
        print('Opção inválida!');
        enter();
    }
  }
}

void enter() {
  stdout.write("Pressione ENTER para continuar");
  stdin.readLineSync();
}

class Produto {
  final String nome;
  double _preco;
  int _quantidadeEmEstoque;
  String? descricao;

  Produto(this.nome, this._preco, this._quantidadeEmEstoque, [this.descricao]);

  double get getPreco => _preco;

  set setPreco(double valor) {
    if (valor <= 0) {
      print('Valor inválido. Informe um valor maior que zero');
    } else {
      _preco = valor;
    }
  }

  int get getQuantidadeEmEstoque => _quantidadeEmEstoque;

  bool vender(int quantidade) {
    if (quantidade < 0) {
      print('Quantidade inválida. Informe um valor maior que zero.');
      return false;
    }
    if (quantidade <= _quantidadeEmEstoque) {
      _quantidadeEmEstoque -= quantidade;
      print('Venda realizada: $quantidade unidade(s) de $nome.');
      return true;
    } else {
      print(
        'Estoque insuficiente. Quantidade disponível: $_quantidadeEmEstoque.',
      );
      return false;
    }
  }

  void reporEstoque(int quantidade) {
    if (quantidade <= 0) {
      print('Quantidade inválida. Informe um valor maior que zero.');
    } else {
      _quantidadeEmEstoque += quantidade;
      print(
        'Quantidade em estoque reposta. \nQuantidade disponível: $_quantidadeEmEstoque unidade(s) de $nome',
      );
    }
  }

  String toString() {
    return '''
    Nome: $nome
    Preço: R\$ ${_preco.toStringAsFixed(2)}
    Estoque: $_quantidadeEmEstoque
    Descrição: ${descricao ?? "Nenhuma"}
    ''';
  }
}

class CarrinhoDeCompras {
  final List<Produto> produtos = [];
  final List<int> quantidades = [];

  void adicionar(Produto p, int qtd) {
    produtos.add(p);
    quantidades.add(qtd);
  }

  double calcularTotal() {
    double total = 0;
    for (int i = 0; i < produtos.length; i++) {
      total += produtos[i].getPreco * quantidades[i];
    }
    return total;
  }

  void finalizar() {
    for (int i = 0; i < produtos.length; i++) {
      produtos[i].vender(quantidades[i]);
    }
    produtos.clear();
    quantidades.clear();
  }
}