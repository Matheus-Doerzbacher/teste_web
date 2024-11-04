// Classes
class CentroDeCusto {
  final String nomeCentroCustos;
  final double valorCentroCusto;
  final int idCentroCusto;

  CentroDeCusto({
    required this.nomeCentroCustos,
    required this.valorCentroCusto,
    required this.idCentroCusto,
  });
}

class TransacoesCentroDeCusto {
  String idFake;
  int idTransacao;
  String operacao;
  String fornecedor;
  String itemDescricao;
  String numeroParcela;
  String dataVencimento;
  String? dataRecebimento;
  String dataCompetencia;
  double valor;
  double? valorEncargos;
  double? valorDescontos;
  double? valorPago;
  String situacao;
  String planoConta;
  int idPerfil;
  String? dataPrevisaoPagamento;
  double valorOriginal;
  String? cpf;
  String? cnpj;
  double? valorConvenio;
  String? conta;
  String? tipoPagamento;
  String dataEmissao;
  List<CentroDeCusto> centroDeCusto;
  String? unidadeFisica;
  int? idOrg;
  String? nomeOrg;

  TransacoesCentroDeCusto({
    required this.idFake,
    required this.idTransacao,
    required this.operacao,
    required this.fornecedor,
    required this.itemDescricao,
    required this.numeroParcela,
    required this.dataVencimento,
    required this.dataRecebimento,
    required this.dataCompetencia,
    required this.valor,
    required this.valorEncargos,
    required this.valorDescontos,
    required this.valorPago,
    required this.situacao,
    required this.planoConta,
    required this.idPerfil,
    required this.dataPrevisaoPagamento,
    required this.valorOriginal,
    required this.cpf,
    required this.cnpj,
    required this.valorConvenio,
    required this.conta,
    required this.tipoPagamento,
    required this.dataEmissao,
    required this.unidadeFisica,
    required this.centroDeCusto,
    required this.idOrg,
    required this.nomeOrg,
  });
}

// Função para converter JSON em objetos TransacoesCentroDeCusto
List<TransacoesCentroDeCusto> parseData(List<dynamic> jsonData) {
  final Map<int, List<dynamic>> groupedData = {};

  // Agrupar dados pelo `idTransacao`
  for (var entry in jsonData) {
    int idTransacao = entry['idTransacao'];

    if (!groupedData.containsKey(idTransacao)) {
      groupedData[idTransacao] = [];
    }

    groupedData[idTransacao]!.add(entry);
  }

  // Converter grupos em objetos TransacoesCentroDeCusto
  List<TransacoesCentroDeCusto> transacoes = [];

  for (var entries in groupedData.values) {
    var firstEntry = entries[0];
    List<CentroDeCusto> centrosDeCusto = entries.map((entry) {
      return CentroDeCusto(
        nomeCentroCustos: entry['nomeCentroCusto'],
        valorCentroCusto: double.parse(entry['valorCentroCusto']),
        idCentroCusto: entry['idCentroCusto'],
      );
    }).toList();

    transacoes.add(TransacoesCentroDeCusto(
      idFake: firstEntry['idFake'],
      idTransacao: firstEntry['idTransacao'],
      operacao: firstEntry['operacao'],
      fornecedor: firstEntry['fornecedor'],
      itemDescricao: firstEntry['itemDescricao'],
      numeroParcela: firstEntry['numeroParcela'],
      dataVencimento: firstEntry['dataVencimento'],
      dataRecebimento: firstEntry['dataRecebimento'],
      dataCompetencia: firstEntry['dataCompetencia'],
      valor: double.parse(firstEntry['valor']),
      valorEncargos: double.tryParse(firstEntry['valorEncargos'] ?? '0.0'),
      valorDescontos: double.tryParse(firstEntry['valorDescontos'] ?? '0.0'),
      valorPago: double.tryParse(firstEntry['valorPago'] ?? '0.0'),
      situacao: firstEntry['situacao'],
      planoConta: firstEntry['planoConta'],
      idPerfil: firstEntry['idPerfil'],
      dataPrevisaoPagamento: firstEntry['dataPrevisaoPagamento'],
      valorOriginal: double.parse(firstEntry['valorOriginal']),
      cpf: firstEntry['cpf'],
      cnpj: firstEntry['cnpj'],
      valorConvenio: double.tryParse(firstEntry['valorConvenio'] ?? '0.0'),
      conta: firstEntry['conta'],
      tipoPagamento: firstEntry['tipoPagamento'],
      dataEmissao: firstEntry['dataEmissao'],
      unidadeFisica: firstEntry['unidadeFisica'],
      centroDeCusto: centrosDeCusto,
      idOrg: firstEntry['idOrg'],
      nomeOrg: firstEntry['nomeOrg'],
    ));
  }

  return transacoes;
}
