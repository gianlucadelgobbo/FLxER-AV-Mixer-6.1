﻿package FLxER.modules.MappingSVG {	import flash.events.Event;	import flash.net.FileReference;		import FLxER.comp.ButtonTxt;	import FLxER.comp.CheckBoxBase;	import FLxER.main.Txt;	import FLxER.modules.MappingSVG.MappingSVGDrawer;	import FLxER.panels.Module;	import FLxER.comp.ButtonBase;
	public class MappingSVGStarter extends Module {		private var penP:ButtonBase;		private var penDelP:ButtonBase;		private var penEditP:ButtonBase;		private var editP:CheckBoxBase;		private var clearP:ButtonTxt;		private var showFillP:CheckBoxBase;		private var saveP:ButtonTxt;		private var loadP:ButtonTxt;		private var setColP:ButtonTxt;		private var setColT:Txt;		private var guide:Txt;		private var myCol:String;		private var MyFile:FileReference;		private var myMappingSVGDrawer:MappingSVGDrawer;		private var currentShape:int;		private var handlesAcnt:Array;		private var shapesAcnt:Array;		private var shapesA:Array;		private var vertDist:uint = 40;		private var horzDist:uint = 10		private var drawermode:String				private var test:penEdit;				public function MappingSVGStarter() {			super(278,320,"MAPPING SVG");			init(null);		}		private function init(p:String):void {			if ((guide is Txt) && palette.stage.contains(guide)) palette.stage.removeChild(guide);			if ((saveP is ButtonTxt)  && palette.stage.contains(saveP)) palette.stage.removeChild(saveP);			if (Preferences.monitorOut && Preferences.monitorOutFS) {				drawPalette();			} else {				if (!guide) guide = new Txt(20, 30, 240, 0, "Impossible to found Fullscreen Monitor Out", Preferences.ts,"");				if (!saveP) saveP = new ButtonTxt(20, guide.y+guide.height+vertDist, 120, 15, "TRY AGAIN", init, "", "");				palette.stage.addChild(guide);				palette.stage.addChild(saveP);			}		}		private function drawPalette():void {			penP = new ButtonBase(20, 30, 30, 30, activatePen, "", "Pen (draw with bezier)");			penDelP = new ButtonBase(penP.x+horzDist+30, 30, 30, 30, activatePenDel, "", "Pen delete");			penEditP = new ButtonBase(penDelP.x+horzDist+30, 30, 30, 30, activatePenEdit, "", "Move (shapes, nodes, handles)");						penP.addChild(new pen());			penDelP.addChild(new penDelete());			penEditP.addChild(new penEdit());			editP = new CheckBoxBase(20, penEditP.y+vertDist, 120, 15, "ENABLE MAP EDITING", enableDrawer, "ENABLE MAP EDITING", true);			clearP = new ButtonTxt(20, editP.y+vertDist, 120, 15, "CLEAR", clearAll, "", "");			saveP = new ButtonTxt(20, clearP.y+vertDist, 120, 15, "SAVE", saveShapes, "", "");			loadP = new ButtonTxt(20, saveP.y+vertDist, 120, 15, "LOAD SVG MAP", loadMap, "", "");			setColT = new Txt(20, loadP.y+vertDist, 50, 15, "0000FF", Preferences.th,"input");			setColP = new ButtonTxt(130, setColT.y, 70, 15, "SET COLOR", setCol, "", "");			showFillP = new CheckBoxBase(20, setColP.y+vertDist, 120, 15, "SHOW SHAPE FILL", setShowFill, "", true);			editP.scaleX=loadP.scaleX=clearP.scaleX=saveP.scaleX=setColP.scaleX=setColT.scaleX=editP.scaleY=loadP.scaleY=clearP.scaleY=saveP.scaleY=setColP.scaleY=setColT.scaleY=2			guide = new Txt(20, 298, 240, 0, "- Press \"SHIFT\" to delete a point\n- Press on the first point of a shape to close it and start a new one", Preferences.ts,"");			palette.stage.addChild(penP);			palette.stage.addChild(penDelP);			palette.stage.addChild(penEditP);			palette.stage.addChild(editP);			palette.stage.addChild(loadP);			palette.stage.addChild(clearP);			palette.stage.addChild(saveP);			palette.stage.addChild(setColP);			palette.stage.addChild(setColT);			palette.stage.addChild(guide);			palette.stage.addChild(showFillP);			myMappingSVGDrawer = new MappingSVGDrawer(this);			Preferences.monitorOut.addChild(myMappingSVGDrawer);			penP.myDisable();			drawermode = "pen";			myMappingSVGDrawer.setDrawerMode(drawermode);		}		private function activatePen(p):void {			this[drawermode+"P"].myEnable();			drawermode = "pen";			penP.myDisable();			myMappingSVGDrawer.setDrawerMode(drawermode);		}		private function activatePenDel(p):void {			this[drawermode+"P"].myEnable();			drawermode = "penDel";			penDelP.myDisable();			myMappingSVGDrawer.setDrawerMode(drawermode);		}		private function activatePenEdit(p):void {			this[drawermode+"P"].myEnable();			drawermode = "penEdit";			penEditP.myDisable();			myMappingSVGDrawer.setDrawerMode(drawermode);		}		private function setShowFill(p):void {			myMappingSVGDrawer.showFill = p;			myMappingSVGDrawer.drawMap();			trace(p);		}		private function enableDrawer(p):void {			if (p) {				//myMappingSVGDrawer.setEditMap();				clearP.myEnable();				saveP.myEnable();				loadP.myEnable();				clearP.alpha=saveP.alpha=loadP.alpha=1;			} else {				//myMappingSVGDrawer.setUseMap();				clearP.myDisable();				saveP.myDisable();				loadP.myDisable();				clearP.alpha=saveP.alpha=loadP.alpha=.7;			}		}		private function setCol(e:Boolean):void {			myMappingSVGDrawer.setCol(setColT.text);		}		private function clearAll(e:Boolean):void {			myMappingSVGDrawer.clearAll();		}		private function saveShapes(e:Boolean):void {			myMappingSVGDrawer.saveShapes();		}		public function saveShapesAct(str:String):void {			var str2:String = "<?xml version='1.0'?><!DOCTYPE svg PUBLIC '-//W3C//DTD SVG 1.0//EN' 'http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd'><svg xmlns='http://www.w3.org/2000/svg'>"+str+"</svg>";			/*var result:XMLDocument = new XMLDocument();			result.ignoreWhite = true;			result.parseXML(str2);*/			MyFile = new FileReference();			MyFile.save(str2, "map.svg");		}		private function selectHandler(event:Event):void {            var file:FileReference = FileReference(event.target);            trace("selectHandler: name=" + file.name);            MyFile.load();        }		private function loadMap(val):void {			MyFile = new FileReference();			MyFile.addEventListener(Event.SELECT, selectHandler);            MyFile.addEventListener(Event.COMPLETE, mapDrawer);            MyFile.browse();        }		private function mapDrawer(val):void {			myMappingSVGDrawer.editMap(MyFile.data);		}	}}