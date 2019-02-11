import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hn_flutter/models/story_list.dart';
import 'package:hn_flutter/pages/story.dart';

class Stories extends StatefulWidget {
  final storyType;

  Stories({this.storyType = ''});

  @override
  StoriesState createState() {
    return new StoriesState();
  }
}

class StoriesState extends State<Stories> {
  @override
  void initState() {
    super.initState();
    print('init state');
    stories.loadStories(type: widget.storyType);
  }

  @override
  void didUpdateWidget(Stories oldWidget) {
    super.didUpdateWidget(oldWidget);

    print('did update ${oldWidget.storyType} ${widget.storyType}');
    stories.loadStories(type: widget.storyType);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    return Container(
      child: RefreshIndicator(
        child: Observer(
          builder: (_) {
            if (stories.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: stories.stories.length,
              itemBuilder: (_, index) {
                final story = stories.stories[index];

                return Observer(
                  builder: (_) {
                    var tileTitle = Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(story.title),
                      ],
                    );

                    if (true) {
                      tileTitle.children.add(
                        Text(
                          '${story.user} ${story.timeAgo}',
                          style: textTheme.caption,
                        ),
                      );
                    }

                    final subTitle = Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              '${story.points.toString()} points ${story.commentsCount.toString()} comments'),
                        ],
                      ),
                    );

                    final tile = ListTile(
                      dense: true,
                      title: tileTitle,
                      subtitle: subTitle,
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) {
                                  return Story(story.id);
                                },
                                fullscreenDialog: true));
                      },
                    );

                    return tile;
                  },
                );
              },
            );
          },
        ),
        onRefresh: () => stories.loadStories(loadType: LoadType.Reload),
      ),
    );
  }
}
