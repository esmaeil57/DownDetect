import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../data/models/helpful_video_model.dart';

class HelpfulVideoDetailScreen extends StatefulWidget {
  final HelpfulVideo video;

  const HelpfulVideoDetailScreen({Key? key, required this.video}) : super(key: key);

  @override
  State<HelpfulVideoDetailScreen> createState() => _HelpfulVideoDetailScreenState();
}

class _HelpfulVideoDetailScreenState extends State<HelpfulVideoDetailScreen> {
  late WebViewController controller;
  bool isLoading = true;
  bool hasError = false;
  String? errorMessage;

  static const Color primaryColor = Color(0xFF0E6C73);
  static const double videoHeightRatio = 0.29;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    final embedUrl = _getYouTubeEmbedUrl(widget.video.url);
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (_) => setState(() {
          isLoading = true;
          hasError = false;
        }),
        onPageFinished: (_) => setState(() => isLoading = false),
        onWebResourceError: (error) {
          setState(() {
            isLoading = false;
            hasError = true;
            errorMessage = 'Failed to load video: ${error.description}';
          });
        },
      ));

    if (embedUrl != null) {
      controller.loadRequest(Uri.parse(embedUrl));
    } else {
      setState(() {
        isLoading = false;
        hasError = true;
        errorMessage = 'Invalid YouTube URL';
      });
    }
  }

  String? _getYouTubeEmbedUrl(String url) {
    final videoId = _extractYouTubeVideoId(url);
    return videoId != null
        ? 'https://www.youtube.com/embed/$videoId?autoplay=1&rel=0&modestbranding=1'
        : null;
  }

  String? _extractYouTubeVideoId(String url) {
    final regExp = RegExp(
      r'^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#&?]*).*',
      caseSensitive: false,
    );
    final match = regExp.firstMatch(url);
    if (match != null && match.groupCount >= 7) {
      final id = match.group(7);
      return id?.length == 11 ? id : null;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildVideoSection(context),
          Expanded(child: _buildDetailsSection(context)),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: BackButton(color: Colors.white),
      title: Text(
        widget.video.title,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
      ),
      centerTitle: true,
      toolbarHeight: MediaQuery.of(context).size.height * 0.12,
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
    );
  }
  Widget _buildVideoSection(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * videoHeightRatio,
        width: double.infinity,
        child: hasError
            ? _buildErrorWidget()
            : Stack(
          children: [
            WebViewWidget(controller: controller),
            if (isLoading)
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                    SizedBox(height: 16),
                    Text('Loading video...', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsSection(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(widget.video.title),
            const SizedBox(height: 12),
            _buildInfoCard(
              icon: Icons.description,
              title: 'Description',
              content: widget.video.description,
              iconColor: primaryColor,
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              icon: Icons.link,
              title: 'YouTube URL',
              content: widget.video.url,
              iconColor: primaryColor,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('URL copied to clipboard'),
                    backgroundColor: Colors.grey,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey.shade800),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: iconColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: iconColor),
              ),
            ],
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: onTap,
            child: Text(
              content,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                decoration: onTap != null ? TextDecoration.underline : TextDecoration.none,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.refresh),
            label: const Text('Reload Video'),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: _initializeWebView,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            icon: const Icon(Icons.share),
            label: const Text('Share'),
            style: OutlinedButton.styleFrom(
              foregroundColor: primaryColor,
              side: BorderSide(color: primaryColor),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Share functionality would be implemented here'),
                  backgroundColor: primaryColor,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.white70),
              const SizedBox(height: 16),
              const Text(
                'Failed to Load Video',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                errorMessage ?? 'An error occurred while loading the video',
                style: const TextStyle(color: Colors.white70, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor, foregroundColor: Colors.white),
                onPressed: _initializeWebView,
              ),
            ],
          ),
        ),
      ),
    );
  }
}