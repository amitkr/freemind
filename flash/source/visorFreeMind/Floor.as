﻿/*FreeMind - A Program for creating and viewing Mindmaps
 *Copyright (C) 2000-2005  Joerg Mueller, Daniel Polansky, Christian Foltin and others.
 *
 *See COPYING for Details
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either version 2
 *of the License, or (at your option) any later version.
 *
 *This program is distributed in the hope that it will be useful,
 *but WITHOUT ANY WARRANTY; without even the implied warranty of
 *MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *GNU General Public License for more details.
 *
 *You should have received a copy of the GNU General Public License
 *along with this program; if not, write to the Free Software
 *Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 *
 * Created on 25.04.2005
 */
/**
* Floor: Is the container of the Browser
*/
class  visorFreeMind.Floor {

	private var mc_cont:MovieClip;
	private  var mc_floor:MovieClip=null;
	private var mc_fondo:MovieClip=null;
	private var mc_shots:MovieClip=null;
	
	function Floor(mc:MovieClip){
		mc_cont=mc; //father
		mc_floor=mc_cont.createEmptyMovieClip("floor",5);
		mc_floor.mouseDown=false;
		mc_fondo=mc_cont.createEmptyMovieClip("fondo",2);
		mc_shots=mc_cont.createEmptyMovieClip("mc_shots",8888);
		mc_shots._visible=false;
		fillFondo();
		makeDraggable();
	}

	function centerNode(node:MovieClip){
		mc_floor._x=Stage.width/2-node._x-node._width/2;
		mc_floor._y=Stage.height/2-node._y-node._height/2;
	}
	
	function showNode(node:MovieClip){
		if((mc_floor._x+node._x)<0)
			mc_floor._x=-node._x;
		if((mc_floor._y+node._y)<0)
			mc_floor._y=-node._y;
		if((mc_floor._x+node._x+node._width)>Stage.width)
			mc_floor._x=Stage.width-node._width-node._x;
		if((mc_floor._y+node._y+node._height)>Stage.height)
			mc_floor._y=Stage.height-node._y-node._height;
	}
	
	function fillFondo(){
		var mc_c1=mc_fondo.createEmptyMovieClip("c1",1);
		var color=getBackgroundColor();
		mc_c1.lineStyle(1,color,100);
		mc_c1.beginFill(color,100);
		mc_c1.moveTo(0,0);
		mc_c1.lineTo(Stage.width,0);
		mc_c1.lineTo(Stage.width,Stage.height);
		mc_c1.lineTo(0,Stage.height);
		mc_c1.lineTo(0,0);
		mc_c1.endFill();
	}

	function changeBgColor(color){
			var freeMindVars = SharedObject.getLocal("freeMindBrowser");
			freeMindVars.data.bgColor=color;
			freeMindVars.flush();
			this.fillFondo();
	}


	function getBackgroundColor(){
		var freeMindVars = SharedObject.getLocal("freeMindBrowser");
		if(!freeMindVars.data.bgColor){
			freeMindVars.data.bgColor=0xFFFFFF;
		}
		return freeMindVars.data.bgColor;
	}

	function makeDraggable(){
		mc_floor.onMouseDown=function(){
			trace("makeDraggable");
			this.startDrag();
			this.mouseDown=true;
		}

		mc_floor.onMouseUp=function(){
			this.stopDrag();
			this.mouseDown=false;
		}

		mc_floor.onMouseWheel=function(delta){trace("mosewheel");
			if(this.mouseDown)
				this._x+=delta*3;
			else
				this._y+=delta*3;
		}
		Mouse.addListener(mc_floor);
	}

	function notDraggable(){
		trace("makenotDraggable");
		mc_floor.stopDrag();
		mc_floor.onMouseDown=undefined;
		mc_floor.onMouseUp=undefined;
	}

	function getCanvas(){
		return mc_floor;
	}

	function getShotsCont(){
		return mc_shots;
	}


	function clear(){
		mc_floor.clear();
	}

}
