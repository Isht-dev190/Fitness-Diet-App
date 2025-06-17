import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

abstract class VideoPlayerState {}

class VideoPlayerInitial extends VideoPlayerState {}
class VideoPlayerLoading extends VideoPlayerState {}
class VideoPlayerReady extends VideoPlayerState {
  final YoutubePlayerController controller;
  VideoPlayerReady(this.controller);
}
class VideoPlayerError extends VideoPlayerState {
  final String message;
  VideoPlayerError(this.message);
}

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  YoutubePlayerController? _controller;

  VideoPlayerCubit() : super(VideoPlayerInitial());

  void initialize(String videoId) {
    emit(VideoPlayerLoading());
    try {
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
      emit(VideoPlayerReady(_controller!));
    } catch (e) {
      emit(VideoPlayerError(e.toString()));
    }
  }

  YoutubePlayerController? get controller => _controller;

  @override
  Future<void> close() {
    _controller?.dispose();
    return super.close();
  }
} 