extends Node2D

onready var timer = $Timer

var time = 0
var second = 0
var minute = 0
var hour = 0

func _ready():
	pass # Replace with function body.

func _process(delta):
	time += delta
	startTimer(time)

func startTimer(time):
	second = fmod(time, 60)
	minute = fmod(time / 60, 60)
	hour = fmod(time / 3600, 24)

	var hourText = "%02d" % hour
	var minuteText = "%02d" % minute
	var secondText = "%02d" % second

	timer.text = hourText + ":" + minuteText + ":" + secondText
	
