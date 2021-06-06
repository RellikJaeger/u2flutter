import 'package:flutter/material.dart';
import 'VideoGridWidget.dart';

class VideoListBuilder {
  Future<dynamic> _refresh;
  Function refresh;

  VideoListBuilder(this._refresh, this.refresh);

  Widget build() {
    return FutureBuilder(
        future: _refresh,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasError) {
              return _body(snapshot.data);
            } else {
              print(snapshot);
              return Center(
                child: TextButton(
                  child: Text("加载失败，点击重试"),
                  onPressed: () => refresh(),
                ),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _body(dynamic data) {
    final list = data["items"];
    if (list is List) {
      return VideoGridWidget(
        list,
        grid: false,
      );
    }
    return Center(child: Text(data.toString()));
  }
}
