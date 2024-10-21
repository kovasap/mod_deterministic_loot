::mods_hookExactClass("items/weapons/weapon", function(o) {

	function isDroppedAsLoot()
	{
		if (!this.item.isDroppedAsLoot())
		{
			return false;
		}

		local isPlayer = (
      this.m.LastEquippedByFaction == this.Const.Faction.Player
      || this.getContainer() != null
      && this.getContainer().getActor() != null
      && !this.getContainer().getActor().isNull()
      && this.isKindOf(this.getContainer().getActor().get(), "player"));
		local isLucky = (
      !this.Tactical.State.isScenarioMode() && !isPlayer
      && this.World.Assets.getOrigin().isDroppedAsLoot(this));
		local isBlacksmithed = (
      isPlayer && !this.Tactical.State.isScenarioMode()
      && this.World.Assets.m.IsBlacksmithed);
		return (
        this.m.AmmoMax == 0 || isPlayer ||
        this.m.Ammo > 0 && this.getCurrentSlotType() != this.Const.ItemSlot.Bag
        || this.m.Ammo > 0 && this.m.Ammo < this.m.AmmoMax
        && this.getCurrentSlotType() == this.Const.ItemSlot.Bag
      )
      && (
        this.m.Condition >= 12 || this.m.ConditionMax <= 1 || isLucky 
        || isBlacksmithed || !isPlayer 
        && this.isItemType(this.Const.Items.ItemType.Named)
        || this.isItemType(this.Const.Items.ItemType.Legendary)
      ) && (
        isPlayer || isLucky || this.isItemType(this.Const.Items.ItemType.Named)
        || this.isItemType(this.Const.Items.ItemType.Legendary)
      );
        // || this.Math.rand(1, 100) <= 90);
	}
});
