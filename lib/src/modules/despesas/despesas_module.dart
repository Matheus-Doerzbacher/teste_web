import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:teste_web/src/modules/despesas/controllers/transacoes_centro_de_custo_controller.dart';
import 'package:teste_web/src/modules/despesas/repositories/get_trancacoes_centro_de_custo_repository.dart';
import 'package:teste_web/src/modules/despesas/_views/transacao_centro_de_custo_page.dart';

class DespesasModule extends Module {
  @override
  void binds(Injector i) {
    // REPOSITORY
    i.addLazySingleton<GetTrancacoesCentroDeCustoRepository>(
      GetTrancacoesCentroDeCustoRepository.new,
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
      child: (context) => ChangeNotifierProvider(
        create: (context) => Modular.get<TransacoesCentroDeCustoController>(),
        child: const TransacaoCentroDeCustoPage(),
      ),
    );
    super.routes(r);
  }
}
