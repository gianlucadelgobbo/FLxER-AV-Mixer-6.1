﻿package FLxER.comp {	import FLxER.main.Txt;	public class ButtonTxt extends ButtonBase {		public function ButtonTxt(xx:Number,yy:Number,ww:uint,hh:uint,t:String,f:Function, p:String, alt:String):void {			super(xx, yy, ww, hh, f, p, alt);			lab = new Txt(0,0,w,h,t,Preferences.th,"puls");			this.addChild(lab);		}	}}