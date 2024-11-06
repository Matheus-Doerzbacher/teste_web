import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRageWidget extends StatefulWidget {
  final DateTimeRange? dataVencimento;
  final DateTimeRange? dataRecebimento;
  final Function(DateTimeRange?) onVencimentoChanged;
  final Function(DateTimeRange?) onRecebimentoChanged;

  const DateRageWidget({
    super.key,
    this.dataVencimento,
    this.dataRecebimento,
    required this.onVencimentoChanged,
    required this.onRecebimentoChanged,
  });

  @override
  State<DateRageWidget> createState() => _DateRageWidgetState();
}

class _DateRageWidgetState extends State<DateRageWidget> {
  DateTimeRange? selectedVencimento;
  DateTimeRange? selectedRecebimento;

  @override
  void initState() {
    super.initState();
    selectedVencimento = widget.dataVencimento;
    selectedRecebimento = widget.dataRecebimento;
  }

  Future<void> _selectDateRange(BuildContext context, bool isVencimento) async {
    final DateTimeRange? picked = await showDateRangePicker(
      locale: const Locale('pt', 'BR'),
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      initialDateRange: isVencimento ? selectedVencimento : selectedRecebimento,
    );

    if (picked != null) {
      setState(() {
        if (isVencimento) {
          selectedVencimento = picked;
          widget.onVencimentoChanged(picked);
        } else {
          selectedRecebimento = picked;
          widget.onRecebimentoChanged(picked);
        }
      });
    }
  }

  String _formatDateLarge(DateTime date) {
    return '${date.day} de ${DateFormat('MMM', 'pt_BR').format(date)} de ${date.year}';
  }

  String _formatDateSmall(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          // Layout para telas menores que 800
          return _layoutMenor(context);
        } else {
          // Layout para telas maiores ou iguais a 800
          return _layoutMaior(context);
        }
      },
    );
  }

  Widget _layoutMenor(BuildContext context) {
    return Column(
      children: [
        // Vencimento Column
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Vencimento",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                const Text("Período: "),
                TextButton(
                  onPressed: () => _selectDateRange(context, true),
                  child: Text(
                    selectedVencimento != null
                        ? "${_formatDateSmall(selectedVencimento!.start)} à ${_formatDateSmall(selectedVencimento!.end)}"
                        : "Selecionar datas",
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      selectedVencimento = null;
                      widget.onVencimentoChanged(null);
                    });
                  },
                  icon: const Icon(Icons.clear_rounded),
                )
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Pagamento Column
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pagamento",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                const Text("Período: "),
                TextButton(
                  onPressed: () => _selectDateRange(context, false),
                  child: Text(
                    selectedRecebimento != null
                        ? "${_formatDateSmall(selectedRecebimento!.start)} à ${_formatDateSmall(selectedRecebimento!.end)}"
                        : "Selecionar datas",
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      selectedRecebimento = null;
                      widget.onRecebimentoChanged(null);
                    });
                  },
                  icon: const Icon(Icons.clear_rounded),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _layoutMaior(BuildContext context) {
    return Row(
      children: [
        // Vencimento Column
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Vencimento",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  const Text("Período: "),
                  TextButton(
                    onPressed: () => _selectDateRange(context, true),
                    child: Text(
                      selectedVencimento != null
                          ? "${_formatDateLarge(selectedVencimento!.start)} à ${_formatDateLarge(selectedVencimento!.end)}"
                          : "Selecionar datas",
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        selectedVencimento = null;
                        widget.onVencimentoChanged(null);
                      });
                    },
                    icon: const Icon(Icons.clear_rounded),
                  )
                ],
              ),
            ],
          ),
        ),

        // Pagamento Column
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pagamento",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  const Text("Período: "),
                  TextButton(
                    onPressed: () => _selectDateRange(context, false),
                    child: Text(
                      selectedRecebimento != null
                          ? "${_formatDateLarge(selectedRecebimento!.start)} à ${_formatDateLarge(selectedRecebimento!.end)}"
                          : "Selecionar datas",
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        selectedRecebimento = null;
                        widget.onRecebimentoChanged(null);
                      });
                    },
                    icon: const Icon(Icons.clear_rounded),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
