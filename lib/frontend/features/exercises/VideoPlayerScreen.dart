import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'video_player_cubit.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class VideoPlayerScreen extends StatelessWidget {
  final String videoId;

  const VideoPlayerScreen({Key? key, required this.videoId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return BlocProvider(
      create: (_) => VideoPlayerCubit()..initialize(videoId),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Center(
          child: BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
            builder: (context, state) {
              if (state is VideoPlayerLoading) {
                return const CircularProgressIndicator();
              } else if (state is VideoPlayerError) {
                return Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                );
              } else if (state is VideoPlayerReady) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: primaryColor.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: YoutubePlayer(
                    controller: state.controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: primaryColor,
                    progressColors: ProgressBarColors(
                      playedColor: primaryColor,
                      handleColor: primaryColor,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}