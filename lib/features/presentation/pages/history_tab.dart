import 'package:catimage/core/core.dart';
import 'package:catimage/features/presentation/bloc/history/history_bloc.dart';
import 'package:catimage/features/presentation/bloc/history/history_state.dart';
import 'package:catimage/features/presentation/pages/widgets/history_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('История'),
        centerTitle: true,
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is HistoryLoaded && state.items.isEmpty) {
            return const Center(child: Text('История пуста'));
          }
          if (state is HistoryLoaded) {
            return ListView.builder(
              padding: Core.constants.paddingVertical8,
              itemCount: state.items.length,
              itemBuilder: (context, index) =>
                  HistoryItem(cat: state.items[index]),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
