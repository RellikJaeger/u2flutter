const _defaultImg = "https://assets.suconghou.cn/defaultImg.png";
String videoCover(Object item) {
  final String id = getVideoId(item);
  if (id == "") {
    return _defaultImg;
  }
  return "https://app.suconghou.cn/video/" + id + ".jpg";
}

String videoCover2(Object item) {
  final String id = getVideoId(item);
  if (id == "") {
    return _defaultImg;
  }
  return "http://stream.pull.workers.dev/video/" + id + ".jpg";
}

String getVideoTitle(dynamic item) {
  final v = item["snippet"];
  if (v is Map && v["title"] is String) {
    return v["title"];
  }
  return "";
}

String getVideoDesc(dynamic item) {
  final v = item["snippet"];
  if (v is Map) {
    return v["description"];
  }
  return "";
}

// 兼容playlist 中的ID, 检测 youtube#playlist
String getVideoId(dynamic item) {
  String id = "";
  if (item["kind"] == "youtube#playlist") {
    return getPlayListVid(item);
  }
  final c = item["contentDetails"];
  if (c is Map) {
    if (c["videoId"] is String) {
      return c["videoId"];
    }
  }
  final v = item["id"];
  if (v is String) {
    id = v;
  } else {
    id = v["videoId"];
  }
  return id;
}

String getPlayListVid(dynamic item) {
  final s = item['snippet'];
  if (s is Map) {
    final t = s['thumbnails'];
    if (t is Map) {
      var w = t['medium'];
      if (t['default'] is Map) {
        w = t['default'];
      } else if (t['standard'] is Map) {
        w = t['standard'];
      } else if (t['high'] is Map) {
        w = t['high'];
      }
      final u = w['url'];
      final r = RegExp(r"/([\w\-]{6,12})/");
      final match = r.firstMatch(u);
      return match?.group(1) ?? "";
    }
  }
  return '';
}

String getChannelId(dynamic item) {
  String id = "";
  final v = item["snippet"];
  if (v is Map) {
    id = v["channelId"];
  }
  return id;
}

String getChannelTitle(dynamic item) {
  String title = "";
  final v = item["snippet"];
  if (v is Map) {
    title = v["channelTitle"];
  }
  return title;
}

String viewCount(dynamic item) {
  var n = 0;
  final v = item["statistics"];
  if (v is Map) {
    n = int.parse(v["viewCount"]);
  }
  if (n < 1) {
    return "";
  }
  if (n > 10000) {
    return "${(n / 1000).round()}万观看";
  }
  return "$n观看";
}

String pubAt(dynamic item) {
  final v = item["snippet"];
  var n = 0;
  if (v is Map) {
    final t = DateTime.parse(v["publishedAt"]);
    n = t.millisecondsSinceEpoch;
  }
  final d = (DateTime.now().millisecondsSinceEpoch - n) / 1000;
  const f = [
    [31536000, '年'],
    [2592000, '个月'],
    [604800, '星期'],
    [86400, '天'],
    [3600, '小时'],
    [60, '分钟'],
    [1, '秒']
  ];
  for (var i = 0; i < f.length; i++) {
    final t = f[i][0] as num;
    final e = f[i][1];
    final c = (d / t).floor();
    if (c != 0 && c > 0) {
      return "$c$e前";
    }
  }
  return "刚刚";
}

String duration(dynamic item) {
  final v = item["contentDetails"];
  if (v is Map) {
    final t = v["duration"].toString();
    if (t == "P0D") {
      return "直播";
    }
    var r = RegExp(r"([1-9]+)M$");
    final f = r.firstMatch(t);
    if (f != null) {
      final f1 = f.group(1)!;
      if (f1.length == 1) {
        return "0$f1:00";
      }
      return "$f1:00";
    }
    r = RegExp(r"\d+");
    final arr = [];
    for (final item in r.allMatches(t)) {
      final x = item.group(0)!;
      if (x.length == 1) {
        arr.add("0$x");
      } else {
        arr.add(x);
      }
    }
    return arr.join(":");
  }
  return "";
}

String getSubscriberCount(dynamic item) {
  final v = item["statistics"];
  var n = 0;
  if (v is Map) {
    final c = v["subscriberCount"];
    if (c is String) {
      n = int.parse(c);
    }
  }
  if (n < 1) {
    return "";
  }
  if (n > 10000) {
    return "${(n / 1000).round()}万订阅者";
  }
  return "$n订阅者";
}

String getVideoCount(dynamic item) {
  final v = item["statistics"];
  var n = 0;
  if (v is Map) {
    final c = v["videoCount"];
    if (c is String) {
      n = int.parse(c);
    }
  }
  return "$n个视频";
}

String getChannelUploadId(dynamic item) {
  final v = item["contentDetails"];
  if (v is Map) {
    final c = v["relatedPlaylists"];
    if (c is Map) {
      return c["uploads"];
    }
  }
  return "";
}

String getChannelFavoriteId(dynamic item) {
  final v = item["contentDetails"];
  if (v is Map) {
    final c = v["favorites"];
    if (c is Map) {
      return c["uploads"];
    }
  }
  return "";
}
