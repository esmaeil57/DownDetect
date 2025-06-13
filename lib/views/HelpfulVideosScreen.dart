import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/models/helpful_video_model.dart';
import '../view_model/helpful_video_viewmodel.dart';
import '../view_model/auth_viewmodel.dart';
import 'helpful_video_detail_screen.dart';

class HelpfulVideosScreen extends StatefulWidget {
  const HelpfulVideosScreen({Key? key}) : super(key: key);

  @override
  _HelpfulVideosScreenState createState() => _HelpfulVideosScreenState();
}

class _HelpfulVideosScreenState extends State<HelpfulVideosScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  String? _thumbnailUrl;
  bool _isLoadingThumbnail = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HelpfulVideoViewModel>(context, listen: false).loadVideos();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  // Extract YouTube video ID from URL
  String? _extractYouTubeVideoId(String url) {
    RegExp regExp = RegExp(
      r'^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#&?]*).*',
      caseSensitive: false,
      multiLine: false,
    );

    Match? match = regExp.firstMatch(url);
    if (match != null && match.groupCount >= 7) {
      String? id = match.group(7);
      return id!.length == 11 ? id : null;
    }
    return null;
  }

  // Auto-fetch thumbnail when URL changes
  void _onUrlChanged(String url) {
    if (url.isEmpty) {
      setState(() {
        _thumbnailUrl = null;
      });
      return;
    }

    final videoId = _extractYouTubeVideoId(url);
    if (videoId != null) {
      setState(() {
        _isLoadingThumbnail = true;
        _thumbnailUrl = 'https://img.youtube.com/vi/$videoId/maxresdefault.jpg';
      });

      // Simulate loading delay
      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          _isLoadingThumbnail = false;
        });
      });
    } else {
      setState(() {
        _thumbnailUrl = null;
        _isLoadingThumbnail = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<HelpfulVideoViewModel, AuthViewModel>(
      builder: (context, videoViewModel, authViewModel, child) {
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
          body: videoViewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : _buildVideosContent(videoViewModel),
          // Only show FAB for admin users
          floatingActionButton: authViewModel.isAdmin
              ? FloatingActionButton(
            onPressed: () => _showAddVideoDialog(context),
            backgroundColor: Color(0xFF0E6C73),
            child: Icon(Icons.add, color: Colors.white),
          )
              : null,
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
            Icon(Icons.error_outline, size: 64, color: Colors.red.shade300),
            SizedBox(height: 16),
            Text(
              'Error: ${viewModel.errorMessage}',
              style: TextStyle(color: Colors.red, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => viewModel.loadVideos(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0E6C73),
                foregroundColor: Colors.white,
              ),
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
              'No videos available yet',
              style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
            ),
            SizedBox(height: 8),
            Consumer<AuthViewModel>(
              builder: (context, authViewModel, child) {
                return Text(
                  authViewModel.isAdmin
                      ? 'Tap the + button to add a YouTube video'
                      : 'Videos will appear here when added by admin',
                  style: TextStyle(color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                );
              },
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
            builder: (context) => HelpfulVideoDetailScreen(
              video: video,
            ),
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
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
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
                // Thumbnail with play button overlay
                Stack(
                  alignment: Alignment.center,
                  children: [
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
                    // Play button overlay
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.play_arrow, color: Colors.white, size: 24),
                    ),
                  ],
                ),

                // Video details
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          video.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.grey.shade800,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 6),
                        Text(
                          video.description,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.play_circle_outline,
                                size: 16, color: Color(0xFF0E6C73)),
                            SizedBox(width: 4),
                            Text(
                              'Tap to watch',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF0E6C73),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Admin controls
            Consumer<AuthViewModel>(
              builder: (context, authViewModel, child) {
                if (!authViewModel.isAdmin) return SizedBox.shrink();

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        icon: Icon(Icons.delete_outline, size: 18, color: Colors.red),
                        label: Text('Delete', style: TextStyle(color: Colors.red, fontSize: 12)),
                        onPressed: () => _confirmDeleteVideo(context, video.id),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDeleteVideo(BuildContext context, String videoId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Video'),
        content: Text('Are you sure you want to delete this video? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Provider.of<HelpfulVideoViewModel>(context, listen: false)
                  .deleteVideo(videoId);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Video deleted successfully'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showAddVideoDialog(BuildContext context) {
    // Reset form
    _titleController.clear();
    _descriptionController.clear();
    _urlController.clear();
    _thumbnailUrl = null;
    _isLoadingThumbnail = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Row(
            children: [
              Icon(Icons.video_library, color: Color(0xFF0E6C73)),
              SizedBox(width: 8),
              Text('Add New Video'),
            ],
          ),
          content: Container(
            width: double.maxFinite,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // URL Field
                    TextFormField(
                      controller: _urlController,
                      decoration: InputDecoration(
                        labelText: 'YouTube URL *',
                        hintText: 'https://www.youtube.com/watch?v=...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: Icon(Icons.link),
                      ),
                      keyboardType: TextInputType.url,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a YouTube URL';
                        }
                        if (_extractYouTubeVideoId(value) == null) {
                          return 'Please enter a valid YouTube URL';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setDialogState(() {
                          _onUrlChanged(value);
                        });
                      },
                    ),
                    SizedBox(height: 16),

                    // Thumbnail Preview
                    if (_isLoadingThumbnail)
                      Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0E6C73)),
                              ),
                              SizedBox(height: 8),
                              Text('Loading thumbnail...', style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      )
                    else if (_thumbnailUrl != null)
                      Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            _thumbnailUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: Colors.grey.shade200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.error_outline, color: Colors.grey),
                                  Text('Thumbnail not available', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                    if (_thumbnailUrl != null) SizedBox(height: 16),

                    // Title Field
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Video Title *',
                        hintText: 'Enter a descriptive title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: Icon(Icons.title),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                      maxLines: 2,
                    ),
                    SizedBox(height: 16),

                    // Description Field
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description *',
                        hintText: 'Describe what this video is about',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: Icon(Icons.description),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            Consumer<HelpfulVideoViewModel>(
              builder: (context, viewModel, child) {
                return ElevatedButton(
                  onPressed: viewModel.isLoading
                      ? null
                      : () {
                    if (_formKey.currentState!.validate()) {
                      final video = HelpfulVideo(
                        id: '', // Will be set by backend
                        title: _titleController.text.trim(),
                        description: _descriptionController.text.trim(),
                        url: _urlController.text.trim(),
                        thumbnail: _thumbnailUrl,
                      );

                      viewModel.addVideo(video);
                      Navigator.of(context).pop();

                      // Show success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Video added successfully'),
                          backgroundColor: Colors.teal,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0E6C73),
                    foregroundColor: Colors.white,
                  ),
                  child: viewModel.isLoading
                      ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : Text('Add Video'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}