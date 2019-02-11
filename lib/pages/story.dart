import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hn_flutter/models/story_list.dart';

class Story extends StatefulWidget {
  final int storyId;

  Story(this.storyId);

  @override
  StoryState createState() {
    return new StoryState();
  }
}

class StoryState extends State<Story> {
  @override
  void initState() {
    super.initState();
    stories.loadSelectedStory(widget.storyId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Observer(
        builder: (_) {
          if (stories.isSelectedStoryLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (stories.selectedStory.value != null) {
            print(stories.selectedStory.value.id);
            print(stories.selectedStory.value.content.length);
            return Center(child: Text(stories.selectedStory.value.title));
          }

          return Center(
            child: Text('Goodaye mate'),
          );
        },
      )),
    );
  }
}
