extends Control

@onready var healthBar = $HealthBar
@onready var GoldLabel = $GoldLabel

func Update_Gold_text(gold)->void:
	GoldLabel.text = "Gold : "+ str(gold)

func update_health_bar(curHp,maxHp)->void:
	healthBar.value = (100/maxHp) * curHp
	
