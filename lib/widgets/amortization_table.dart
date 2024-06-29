import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

class AmortizationTableWidget extends StatefulWidget {
  const AmortizationTableWidget({super.key, required this.amortizationData});

  final List<Map<String, String>> amortizationData;

  @override
  State<AmortizationTableWidget> createState() =>
      _AmortizationTableWidgetState();
}

class _AmortizationTableWidgetState extends State<AmortizationTableWidget> {
  late List<PlutoColumn> columns;
  late List<PlutoRow> rows;
  late PlutoGridStateManager stateManager;
  double rowHeight = 45.0; // Altura de cada fila
  double headerHeight = 56.0; // Altura del encabezado

  @override
  void initState() {
    super.initState();

    columns = <PlutoColumn>[
      PlutoColumn(
        title: 'Month',
        field: 'Month',
        type: PlutoColumnType.text(),
        enableContextMenu: false,
        enableColumnDrag: false,
        enableDropToResize: false,
        enableEditingMode: false,
        enableSorting: false,
      ),
      PlutoColumn(
        title: 'Payment',
        field: 'Payment',
        type: PlutoColumnType.text(),
        enableContextMenu: false,
        enableColumnDrag: false,
        enableDropToResize: false,
        enableEditingMode: false,
        enableSorting: false,
      ),
      PlutoColumn(
        title: 'Interest',
        field: 'Interest',
        type: PlutoColumnType.text(),
        enableContextMenu: false,
        enableColumnDrag: false,
        enableDropToResize: false,
        enableEditingMode: false,
        enableSorting: false,
      ),
      PlutoColumn(
        title: 'Principal',
        field: 'Principal',
        type: PlutoColumnType.text(),
        enableContextMenu: false,
        enableColumnDrag: false,
        enableDropToResize: false,
        enableEditingMode: false,
        enableSorting: false,
      ),
      PlutoColumn(
        title: 'Balance',
        field: 'Balance',
        type: PlutoColumnType.text(),
        enableContextMenu: false,
        enableColumnDrag: false,
        enableDropToResize: false,
        enableEditingMode: false,
        enableSorting: false,
      ),
    ];

    rows = widget.amortizationData.map(
      (element) {
        return PlutoRow(
          cells: {
            'Month': PlutoCell(
              value: element['Month'],
            ),
            'Payment': PlutoCell(
              value: element['Payment'],
            ),
            'Interest': PlutoCell(
              value: element['Interest'],
            ),
            'Principal': PlutoCell(
              value: element['Principal'],
            ),
            'Balance': PlutoCell(
              value: element['Balance'],
            ),
          },
        );
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: PlutoGrid(
        columns: columns,
        rows: rows,
        configuration: PlutoGridConfiguration(
            style: PlutoGridStyleConfig(
          gridBackgroundColor: Theme.of(context).colorScheme.onPrimary,
          rowColor: Theme.of(context).colorScheme.onSecondary,
          cellTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 18,
              ),
          columnTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 18,
              ),
          activatedColor: Theme.of(context).colorScheme.onSecondary,
        )),
      ),
    );
  }
}
