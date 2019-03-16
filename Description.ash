// Script header for module 'Description'
//
// Author: Andrew MacCormack (SSH)
//   Please use the PM function on the AGS forums to contact
//   me about problems with this module
// 
// Abstract: Provides descriptions of the current thing the mouse is over
// Dependencies:
//
//   AGS 2.71 or later
//
// Functions:
//
//  Description.OverlayMode();
//		Set the module to use an overlay to display text
//
//  Description.GUIMode(GUIControl *gc);
//    Set the module to use the specified GUI Control (button or label) to
//    display text
//
//  Description.StringOnly(); 
//  	Default: do not display text, but rather just set the Description.Text 
//    variable with the right value, for the user to play with. This can also be
//    used as an "off" mode.
//
// Configuration:
//
//  There are various variables used to configure how the module behaves:
//
// 	 Description.VerbMode
//		This is an enumerated setting that controls which text is displayed:
//												Using Inv Item				Normal
//		eDescVerbModeNever	@HS@									@HS@
// 	eDescVerbModeUseOnly  Use @AI@ on @HS@			@HS@
//	   eDescVerbModeAuto  Use @AI@ on @HS@			AutoVerb @HS@
// 		 eDescVerbModeUser  Use @AI@ on @HS@			VerbS @HS@
//
//    where @HS@ is the location name, and @AI@ is the active inventory name
//    "Use" is the content of the Description.UseS string, "on" is the content of
//    Description.PrepositionS, and "VerbS" is the content of the 
//		Description.VerbS string. "AutoVerb" is set by the following mapping:
//											Mouse mode						AutoVerb value
//												eModeLookat						Description.LookS
//												eModePickup						Description.GetS
//												eModeTalkto						Description.TalkS
//												eModeInteract					Description.UseS
//												eModeWalkto						Description.WalkS
//
//   
//   Description.Location
//    Another enumerated setting:
//			eDescLocationStatic
//				GUI stays in one place, like FoA or Monkey Island (not supported for
//				Overlays
//			eDescLocationFollow
//				Text follows the mouse cursor around
// 			eDescLocationSticky
//        When mouse goes over location, Text appears by mouse, but does not 
//				move until mouse leaves location.
//
//	 Description.IncludeInventory
//		Boolean value: if true (default) then Inventory items count as locations
//		to be displayed, if false, they do not.
//
//   Description.ButtonsWithFont
//    Integer: if <0, ignore GUI buttons, otehrwise if buttons use the font
//    specified (e.g. an invisible one) then use the Text as tooltip.
//
//   Description.NoVerbOverNothing
//    Boolean: if false, displays the verb even if not over a location. If true
// 		(default) then displays nothing. Do not set to false in Sticky mode, as
//    it makes it look a mess.
//
//   Description.OffsetX/Y
//    Integers that descibe the X/Y offset from mouse cursor to display the
//    text in Follow or Sticky mode
//
//   Description.Max/MinX/Y
//    4 numbers setting the outside bounds of where the text is allowed to be
//		displayed. Defaults to the screen edges.
//
//	 Description.CropGUIToo
//		Boolean, defaulting false. Normally Follow and Sticky mode trim the GUI
//    Control specified (in GUI mode) to the width of the text. Setting this
//    will crop the GUI, too.
//
//   Description.FadeStart/End/InSpeed/OutSpeed
//     Control the fading in/out of a GUI. Start and End specify the initial and
//     final transparency values for fading in, and the speeds specify the 
//		 change per cycle when fading in or out
//
//	 Description.OLFont/Width/Color
//     Specify the properties of the Overlay using in Overlay mode. For GUIs, 
//     they are picked up from the GUI settings
//
// Example:
//
// function game_start() // called when the game starts, before the first room is loaded
//  {
//    Description.Location=eDescLocationSticky;
//    Description.VerbMode=eDescVerbModeUseOnly;
//    Description.OLColor=65000;
//    Description.OverlayMode();
//  }
//
// Caveats:
//
//   Cannot use a GUI button for description in 2.71
//   Haven't tried ALL the combinations of settings yet!
//
// Revision History:
//
// 28 Apr 06: v1.0  First release of Description module
//  1 May 06: v1.01 Made 2.71 compatible and default to be more like OverHot
// 11 May 06: v1.02 Added ButtonsWithFont and fixed some bugs
//
// Licence:
//
//   Description AGS script module
//   Copyright (C) 2006 Andrew MacCormack
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to 
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in 
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
// DEALINGS IN THE SOFTWARE.

enum DescriptionLocation {eDescLocationStatic, eDescLocationSticky, eDescLocationFollow};
enum DescriptionDisplayType {eDescDisplayNone, eDescDisplayGUIControl, eDescDisplayOverlay};
enum DescriptionVerbMode {eDescVerbModeNever, eDescVerbModeUseOnly, 
	eDescVerbModeAuto, eDescVerbModeUser };

struct Descriptions {
  import function OverlayMode(); // set to use overlay
  import function GUIMode(GUIControl *gc); // set to use GUI
  import function StringOnly(); // no display
  DescriptionVerbMode VerbMode; // how the text is formatted
  DescriptionLocation Location; // where to move the ol/gui to
  
  writeprotected String Text;   // The current value being used

	// Config
  String UseS;          // Default "Use"
  String PrepositionS;  // Default "on" (or "with"?)
  String TalkS;         // Default "Talk to"
  String GetS;          // Default "Get"
  String LookS;         // Default "Look at"
  String WalkS;         // Default "Walk to"
  String VerbS;         // User defined verb string
 
  bool IncludeInventory;// Should custom inv items also work? (default true)
	int ButtonsWithFont;  // Descriptions on GUI buttons with font N 

  // Follow and Static only:
  bool NoVerbOverNothing; // Don't have any text if not over something (default true)
  
  // Follow and Sticky only:
  int OffsetX;  // relative to mouse
  int OffsetY;
  int MinX;     // min/max bounds
  int MinY;
  int MaxX;
  int MaxY;

  // GUI only:
  bool CropGUIToo; // set width of GUI as well as GUIControl (default false)
  int FadeStart; // (max) transparency when first at location
  int FadeEnd;   // (min) transparency after on location a while
  int FadeInSpeed; // value to change transparency by, per cycle
  int FadeOutSpeed; // value to change transparency by, per cycle
  
  // OL only:
  int OLFont;
  int OLWidth;
  int OLColor;
  
  // Internal
  import function rep_ex(); // $AUTOCOMPLETEIGNORE$
  import function OLTidy(); // $AUTOCOMPLETEIGNORE$
  protected DescriptionDisplayType DisplayType; //gui, ol or none
  protected GUIControl *gc;
  protected Overlay *ol;
  protected String last;
  protected int x;
  protected int y;
  protected int alpha;
  protected int width;
  protected import function Update_Position(int font, int width);
  protected import function Update_String();
  protected import function Update_GUI();
  protected import function Update_Overlay();
};
 
  
import Descriptions Description;
