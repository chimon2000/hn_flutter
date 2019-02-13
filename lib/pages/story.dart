import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hn_flutter/models/story_list.dart';
import 'package:flutter_html/flutter_html.dart';

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
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    return Scaffold(
      body: SafeArea(child: Observer(
        builder: (_) {
          if (stories.isSelectedStoryLoading) {
            return Center(child: CircularProgressIndicator());
          }

          final story = stories.selectedStory.value;
          print('content ${story.content}');
          if (story != null) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  story.leadImageUrl != null
                      ? Image.network(story.leadImageUrl)
                      : null,
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      top: 16.0,
                    ),
                    child: Text(
                      '${story.title}',
                      style: textTheme.headline,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      bottom: 16.0,
                    ),
                    child: Html(
                      data: story.content,
                    ),
                  ),
                ].where((widget) => widget != null).toList(),
              ),
            );
          }

          return Center(
            child: Text('Goodaye mate'),
          );
        },
      )),
    );
  }
}
