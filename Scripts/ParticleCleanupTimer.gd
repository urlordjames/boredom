extends Timer

onready var particle: Particles = get_parent()

func _ready():
	particle.restart()
	start(particle.get_lifetime())

func _on_ParticleCleanupTimer_timeout():
	particle.queue_free()
