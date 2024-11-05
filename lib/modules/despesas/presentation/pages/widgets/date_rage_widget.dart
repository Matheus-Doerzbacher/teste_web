import 'package:flutter/material.dart';

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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Vencimento Column
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Vencimento"),
            Row(
              children: [
                const Text("Período: "),
                TextButton(
                  onPressed: () => _selectDateRange(context, true),
                  child: Text(
                    selectedVencimento != null
                        ? "${_formatDate(selectedVencimento!.start)} - ${_formatDate(selectedVencimento!.end.toLocal())}"
                        : "Selecionar datas",
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),

        // Pagamento Column
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Pagamento"),
            Row(
              children: [
                const Text("Período: "),
                TextButton(
                  onPressed: () => _selectDateRange(context, false),
                  child: Text(
                    selectedRecebimento != null
                        ? "${_formatDate(selectedRecebimento!.start)} - ${_formatDate(selectedRecebimento!.end)}"
                        : "Selecionar datas",
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
