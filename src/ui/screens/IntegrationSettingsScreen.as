package ui.screens
{
	import flash.system.System;
	
	import feathers.controls.DragGesture;
	import feathers.controls.Label;
	import feathers.themes.BaseMaterialDeepGreyAmberMobileTheme;
	import feathers.themes.MaterialDeepGreyAmberMobileThemeIcons;
	
	import model.ModelLocator;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	import ui.AppInterface;
	import ui.screens.display.LayoutFactory;
	import ui.screens.display.settings.integration.LoopSettingsList;
	import ui.screens.display.settings.integration.SiDiarySettingsList;
	
	import utils.Constants;
	
	[ResourceBundle("integrationsettingsscreen")]

	public class IntegrationSettingsScreen extends BaseSubScreen
	{	
		/* Display Objects */
		private var loopSettings:LoopSettingsList;
		private var loopLabel:Label;
		private var siDiaryLabel:Label;
		private var siDiarySettings:SiDiarySettingsList;
		
		public function IntegrationSettingsScreen() 
		{
			super();
			
			setupHeader();
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			setupContent();
			adjustMainMenu();
		}
		
		/**
		 * Functionality
		 */
		private function setupHeader():void
		{
			/* Set Header Title */
			title = ModelLocator.resourceManagerInstance.getString('integrationsettingsscreen','screen_title');
			
			/* Set Header Icon */
			icon = getScreenIcon(MaterialDeepGreyAmberMobileThemeIcons.integrationTexture);
			iconContainer = new <DisplayObject>[icon];
			headerProperties.rightItems = iconContainer;
		}
		
		private function setupContent():void
		{
			//Deactivate menu drag gesture 
			AppInterface.instance.drawers.openGesture = DragGesture.NONE;
			
			//Loop Section Label
			loopLabel = LayoutFactory.createSectionLabel(ModelLocator.resourceManagerInstance.getString('integrationsettingsscreen','loop_section_label'));
			screenRenderer.addChild(loopLabel);
			
			//Loop Settings
			loopSettings = new LoopSettingsList();
			screenRenderer.addChild(loopSettings);
			
			//SiDiary Section Label
			siDiaryLabel = LayoutFactory.createSectionLabel(ModelLocator.resourceManagerInstance.getString('integrationsettingsscreen','sidiary_section_label'));
			screenRenderer.addChild(siDiaryLabel);
			
			//SiDiary Settings
			siDiarySettings = new SiDiarySettingsList();
			screenRenderer.addChild(siDiarySettings);
		}
		
		private function adjustMainMenu():void
		{
			AppInterface.instance.menu.selectedIndex = 3;
		}
		
		/**
		 * Event Handlers
		 */
		override protected function onBackButtonTriggered(event:Event):void
		{
			//Save Settings
			if (loopSettings.needsSave)
				loopSettings.save();
			
			//Activate menu drag gesture
			AppInterface.instance.drawers.openGesture = DragGesture.EDGE;
			
			//Pop Screen
			dispatchEventWith(Event.COMPLETE);
		}
		
		/**
		 * Utility
		 */
		override public function dispose():void
		{
			if (loopSettings != null)
			{
				loopSettings.dispose();
				loopSettings = null;
			}
			
			if (loopLabel != null)
			{
				loopLabel.dispose();
				loopLabel = null;
			}
			
			if (siDiaryLabel != null)
			{
				siDiaryLabel.dispose();
				siDiaryLabel = null;
			}
			
			if (siDiarySettings != null)
			{
				siDiarySettings.dispose();
				siDiarySettings = null;
			}
			
			super.dispose();
			
			System.pauseForGCIfCollectionImminent(0);
		}
		
		override protected function draw():void 
		{
			var layoutInvalid:Boolean = isInvalid( INVALIDATION_FLAG_LAYOUT );
			super.draw();
			icon.x = Constants.stageWidth - icon.width - BaseMaterialDeepGreyAmberMobileTheme.defaultPanelPadding;
		}
	}
}