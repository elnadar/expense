import 'package:expense/models/expenses_bucket.dart';
import 'package:expense/shared/custom_card.dart';
import 'package:expense/views/chart/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BarChart extends StatelessWidget {
  const BarChart({super.key, required this.height});
  final double height;

  @override
  Widget build(BuildContext context) {
    const double padding = 20;

    final state = context.watch<ExpensesBucket>();
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    final List valuesList = state.expensesTotals.values.toList();
    return SizedBox(
      height: height,
      child: OutlinedCard(
        child: Padding(
          padding: const EdgeInsets.only(
              top: padding, right: padding, left: padding),
          child: LayoutBuilder(builder: (context, constraints) {
            double listViewHeight = constraints.maxHeight;
            return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ChartBar(
                    weight: valuesList[index],
                    total: state.total,
                    height: listViewHeight,
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 24),
                itemCount: state.expensesByCategory.length);
          }),
        ),
      ),
    );
  }
}
