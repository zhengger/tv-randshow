import 'package:flutter/material.dart';

import 'package:tv_randshow/src/models/search_model.dart';
import 'package:tv_randshow/src/ui/views/base_view.dart';
import 'package:tv_randshow/src/ui/widgets/search_bar_widget.dart';
import 'package:tv_randshow/src/utils/states.dart';

class SearchView extends StatefulWidget {
  SearchView({Key key}) : super(key: key);

  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController(text: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<SearchModel>(
      onModelReady: (model) {},
      builder: (context, child, model) => Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                SearchBarWidget(
                    editingController: textEditingController,
                    searchModel: model),
                Expanded(child: _renderData(model))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderData(SearchModel model) {
    if (model.listTvShow == null) {
      if (model.state == ViewState.init) {
        return Center(child: Text('Search data'));
      } else {
        return Center(child: CircularProgressIndicator());
      }
    } else {
      return GridView.builder(
        semanticChildCount: model.listTvShow.length,
        padding: EdgeInsets.all(16.0),
        itemCount: model.listTvShow.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return model.listTvShow[index];
        },
      );
    }
  }
}