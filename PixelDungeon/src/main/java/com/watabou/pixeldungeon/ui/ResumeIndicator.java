package com.watabou.pixeldungeon.ui;

import com.watabou.noosa.Image;
import com.watabou.pixeldungeon.Assets;
import com.watabou.pixeldungeon.Dungeon;

public class ResumeIndicator extends Tag {
	
	private ImageButton btnResume;
	
	public ResumeIndicator() {
		super( 0x00000000);
		
		setSize( 24, 26 );
		
		setVisible(true);
	}
	
	@Override
	protected void createChildren() {
		super.createChildren();
		
		add(btnResume = new ImageButton(new Image(Assets.UI_ICONS,16,0)) {
			@Override
			protected void onClick() {
				Dungeon.hero.resume();
			}
		});
	}
	
	@Override
	protected void layout() {
		btnResume.setPos(x-btnResume.width() + width(), y +(height() - btnResume.height())/2 );
		
		super.layout();
	}
	
	
	@Override
	public void update() {
		
		boolean visible = Dungeon.hero.lastAction != null;
		
		btnResume.setVisible(visible);
		setVisible(visible);
		
		super.update();
	}

}
