// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_list.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies

mixin _$StoryList on StoryListBase, Store {
  final _$isLoadingAtom = Atom(name: 'StoryListBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportObserved();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    mainContext.checkIfStateModificationsAreAllowed(_$isLoadingAtom);
    super.isLoading = value;
    _$isLoadingAtom.reportChanged();
  }

  final _$isSelectedStoryLoadingAtom =
      Atom(name: 'StoryListBase.isSelectedStoryLoading');

  @override
  bool get isSelectedStoryLoading {
    _$isSelectedStoryLoadingAtom.reportObserved();
    return super.isSelectedStoryLoading;
  }

  @override
  set isSelectedStoryLoading(bool value) {
    mainContext
        .checkIfStateModificationsAreAllowed(_$isSelectedStoryLoadingAtom);
    super.isSelectedStoryLoading = value;
    _$isSelectedStoryLoadingAtom.reportChanged();
  }

  final _$storiesAtom = Atom(name: 'StoryListBase.stories');

  @override
  ObservableList<Story> get stories {
    _$storiesAtom.reportObserved();
    return super.stories;
  }

  @override
  set stories(ObservableList<Story> value) {
    mainContext.checkIfStateModificationsAreAllowed(_$storiesAtom);
    super.stories = value;
    _$storiesAtom.reportChanged();
  }

  final _$loadSelectedStoryAsyncAction = AsyncAction('loadSelectedStory');

  @override
  Future<void> loadSelectedStory(int id) {
    return _$loadSelectedStoryAsyncAction
        .run(() => super.loadSelectedStory(id));
  }

  final _$loadStoriesAsyncAction = AsyncAction('loadStories');

  @override
  Future<void> loadStories(
      {String type = 'news', LoadType loadType = LoadType.Initial}) {
    return _$loadStoriesAsyncAction
        .run(() => super.loadStories(type: type, loadType: loadType));
  }
}
