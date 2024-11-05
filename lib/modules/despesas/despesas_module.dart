import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_web/modules/despesas/data/datasources/transacoes_centro_de_custo/API/get_transacoes_centro_de_custo_datasource_imp.dart';
import 'package:teste_web/modules/despesas/data/datasources/transacoes_centro_de_custo/transacoes_centro_de_custo_datasource.dart';
import 'package:teste_web/modules/despesas/data/repositories_imp/transacaoes_centro_de_custo_repository_imp.dart';
import 'package:teste_web/modules/despesas/domain/repositories/transacoes_centro_de_custo_repository.dart';
import 'package:teste_web/modules/despesas/domain/usecases/get_transacoes_centro_de_custo_usecase.dart';
import 'package:teste_web/modules/despesas/presentation/controllers/transacoes_centro_de_custo_controller.dart';
import 'package:teste_web/modules/despesas/presentation/pages/transacao_centro_de_custo_page.dart';

class DespesasModule extends Module {
  @override
  void binds(Injector i) {
    // DATASOURCE
    i.addLazySingleton<GetTransacoesCentroDeCustoDatasource>(
      GetTransacoesCentroDeCustoDatasourceImp.new,
    );

    // REPOSITORY
    i.addLazySingleton<GetTransacoesCentroDeCustoRepository>(
      () => GetTransacaoesCentroDeCustoRepositoryImp(i()),
    );

    // USECASE
    i.addLazySingleton<GetTransacoesCentroDeCustoUsecase>(
      () => GetTransacoesCentroDeCustoUsecaseImp(i()),
    );

    // CONTROLLERS

    i.addLazySingleton<TransacoesCentroDeCustoController>(
      () => TransacoesCentroDeCustoController(
        i(),
      ),
    );
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/centro-custo',
      child: (context) => const TransacaoCentroDeCustoPage(),
    );
    super.routes(r);
  }
}
