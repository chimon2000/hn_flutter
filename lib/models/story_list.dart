import 'dart:io';

import 'package:hn_flutter/models/story.dart';
import 'package:hnpwa_client/hnpwa_client.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

part 'story_list.g.dart';

class StoryList = StoryListBase with _$StoryList;

typedef LoadStories = Future<Feed> Function();

enum LoadType { Initial, Reload }

abstract class StoryListBase implements Store {
  @observable
  var isLoading = true;

  @observable
  var isSelectedStoryLoading = true;

  Observable<Story> selectedStory = Observable(null);

  @observable
  ObservableList<Story> stories = ObservableList<Story>();

  final client = new HnpwaClient();

  @action
  Future<void> loadSelectedStory(int id) async {
    this.isSelectedStoryLoading = true;

    var item = await client.item(id);
    print(item.url);
    var response = item.url != null
        ? await http.post(
            "https://parser.chimon.net",
            body: convert.jsonEncode({"url": item.url, "format": "markdown"}),
            headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          )
        : null;
    var itemDetail = response != null ? convert.jsonDecode(response.body) : {};

    selectedStory.value = new Story(
        title: item.title,
        url: item.url,
        user: item.user,
        commentsCount: item.commentsCount,
        points: item.points,
        id: item.id,
        timeAgo: item.timeAgo,
        content: itemDetail['content'],
        markdown: itemDetail['markdown'],
        leadImageUrl: itemDetail['lead_image_url']);

    this.isSelectedStoryLoading = false;
  }

  @action
  Future<void> loadStories({
    String type = 'news',
    LoadType loadType = LoadType.Initial,
  }) async {
    if (loadType == LoadType.Initial) {
      this.isLoading = true;
    }

    LoadStories fn = client.news;
    if (type == 'news') {
      print('top');

      fn = client.news;
    }
    if (type == 'newest') {
      print('newest');
      fn = client.newest;
    }
    if (type == 'jobs') {
      print('jobs');

      fn = client.jobs;
    }
    if (type == 'show') {
      fn = client.show;
    }

    var stories = await fn();
    this.stories.clear();
    this.stories.addAll(stories.items.map((story) {
      return Story(
        title: story.title,
        url: story.url,
        user: story.user,
        commentsCount: story.commentsCount,
        points: story.points,
        id: story.id,
        timeAgo: story.timeAgo,
      );
    }));

    if (loadType == LoadType.Initial) {
      this.isLoading = false;
    }
  }
}

final StoryList stories = StoryList();
