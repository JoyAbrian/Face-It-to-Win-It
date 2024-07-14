extends Node

var peer_connection : WebRTCPeerConnection
var video_stream : WebRTCVideoStream = null

func _ready():
	if not Engine.has_singleton("WebRTCPeerConnection"):
		print("WebRTC is not available")
		return

	peer_connection = WebRTCPeerConnection.new()
	var error = peer_connection.initialize({})
	if error != OK:
		print("Error initializing peer connection: ", error)
		return

	video_stream = WebRTCVideoStream.new()
	peer_connection.add_stream(video_stream)
	video_stream.connect("frame_received", self, "_on_frame_received")

	# Request access to the webcam
	var request = WebRTCDataChannel.create_media_constraints()
	var constraints = {
		"audio": false,
		"video": request
	}
	WebRTCPeerConnection.get_singleton().get_user_media(constraints, self, "_on_get_user_media_success", "_on_get_user_media_failure")

func _on_get_user_media_success(stream):
	print("Got user media stream")
	video_stream.attach_to_stream(stream)

func _on_get_user_media_failure(error):
	print("Failed to get user media: ", error)

func _on_frame_received(frame):
	var image = frame.get_texture()
	$VideoRect.texture = image
