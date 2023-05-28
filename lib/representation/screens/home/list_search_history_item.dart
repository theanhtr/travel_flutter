import 'package:flutter/material.dart';

import '../../../helpers/history/search_history.dart';
import '../../widgets/tapable_widget.dart';

class ListSearchHistoryItem extends StatefulWidget {
  const ListSearchHistoryItem({super.key, this.searchHistory, this.controller });

  final List<String>? searchHistory;
  final TextEditingController? controller;
  @override
  State<ListSearchHistoryItem> createState() => _ListSearchHistoryItemState();
}

class _ListSearchHistoryItemState extends State<ListSearchHistoryItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: (widget.searchHistory?.map((e) => TapableWidget(
        onTap: () {
          widget.controller?.text = e;
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.history),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth:
                      MediaQuery.of(context).size.width *
                          0.76,
                    ),
                    child: Text(
                      e,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                TapableWidget(
                  onTap: () {
                    SearchHistory()
                        .deleteSearchItem(e)
                        .then((value) => {
                      setState(() {
                      }),
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child:
                    Icon(Icons.delete_forever_outlined),
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.blueAccent,
            ),
          ],
        ),
      )) ??
          [])
          .toList(),
    );
  }
}
