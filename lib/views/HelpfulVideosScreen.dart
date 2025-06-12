import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/models/helpful_video_model.dart';
import '../view_model/helpful_video_viewmodel.dart';
import 'helpful_video_detail_screen.dart';

class HelpfulVideosScreen extends StatefulWidget {
  const HelpfulVideosScreen({Key? key}) : super(key: key);

  @override
  _HelpfulVideosScreenState createState() => _HelpfulVideosScreenState();
}

class _HelpfulVideosScreenState extends State<HelpfulVideosScreen> {
  final TextEditingController _urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HelpfulVideoViewModel>(context, listen: false).initialize();
    });
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HelpfulVideoViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text(
              'Helpful Videos',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            centerTitle: true,
            toolbarHeight: MediaQuery.of(context).size.height * 0.12,
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0E6C73), Color(0xFF199CA4)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
            ),
          ),
          body: viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : _buildVideosContent(viewModel),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showAddVideoDialog(context),
            backgroundColor: Color(0xFF0E6C73),
            child: Icon(Icons.add),
          ),
          // Bottom navigation bar removed as requested
        );
      },
    );
  }

  Widget _buildVideosContent(HelpfulVideoViewModel viewModel) {
    if (viewModel.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Error: ${viewModel.errorMessage}',
              style: TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => viewModel.loadVideos(),
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (viewModel.videos.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.video_library, size: 64, color: Colors.grey.shade400),
            SizedBox(height: 16),
            Text(
              'No videos added yet',
              style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
            ),
            SizedBox(height: 8),
            Text(
              'Tap the + button to add a YouTube video',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 16),
      itemCount: viewModel.videos.length,
      itemBuilder: (context, index) {
        final video = viewModel.videos[index];
        return _buildVideoCard(video, context);
      },
    );
  }

  Widget _buildVideoCard(HelpfulVideo video, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HelpfulVideoDetailScreen(videoUrl: video.url),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video thumbnail and details
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thumbnail
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  child: video.thumbnail != null
                      ? Image.network(
                    video.thumbnail!,
                    width: 120,
                    height: 90,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 120,
                      height: 90,
                      color: Colors.grey.shade300,
                      child: Icon(Icons.video_library, color: Colors.grey),
                    ),
                  )
                      : Container(
                    width: 120,
                    height: 90,
                    color: Colors.grey.shade300,
                    child: Icon(Icons.video_library, color: Colors.grey),
                  ),
                ),

                // Video details
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          video.title ?? 'Untitled Video',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          video.description ?? 'No description available',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAddVideoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add YouTube Video'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                hintText: 'Paste YouTube URL here',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.link),
              ),
              keyboardType: TextInputType.url,
            ),
            SizedBox(height: 8),
            Text(
              'The app will automatically save this video for all users.',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _urlController.clear();
            },
            child: Text('Cancel'),
          ),
          Consumer<HelpfulVideoViewModel>(
            builder: (context, viewModel, child) {
              return ElevatedButton(
                onPressed: viewModel.isAddingVideo
                    ? null
                    : () {
                  if (_urlController.text.isNotEmpty) {
                    viewModel.addVideo(_urlController.text.trim());
                    Navigator.of(context).pop();
                    _urlController.clear();

                    // Show a success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Video added successfully'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0E6C73),
                ),
                child: viewModel.isAddingVideo
                    ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : Text('Add'),
              );
            },
          ),
        ],
      ),
    );
  }
}