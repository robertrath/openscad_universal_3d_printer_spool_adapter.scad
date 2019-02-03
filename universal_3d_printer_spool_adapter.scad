// Universal 3D Printer Spool Adapter
// ==================================
//
// This universal design adapts a filament supplier's spool to a 3d printer's spool holder.
//
// Initially I created two entries adapting HobbyKing and Mamorubot spools to a
// Cocoon Create Touch or Wanhao Duplicator i3 Plus spool holder.
// 
// As I am expecting to use spools from other filament suppliers and the list of combinations
// of dimensions to increase I have created an indexed list of parameters which can grow over time
// in this one design.
//
// I you want to bypass the indexing and just enter your own parameters while experimenting then
// simply edit the section 'Assign adapter parameters' below. If you do so please message me 
// your new adapter combination and I will add it to the index.
//
// To use this for an existing adapter combination,
// edit the section 'Uncomment One Adapter In the Following Set To Render' below so that only
// one entry for 'Adapter' is given.  

// List of Available Spool to 3D Printer Spool Holder Combinations
HobbyKingPETGtoWanhaoDuplicatori3Plus = 0; // or ...to Cocoon Create Touch
MamorubotPETGtoWanhaoDuplicatori3Plus = 1; // or ...to Cocoon Create Touch

// Uncomment One Adapter In the Following Set To Render

//Adapter = HobbyKingPETGtoWanhaoDuplicatori3Plus;
Adapter = MamorubotPETGtoWanhaoDuplicatori3Plus;

// Adapter Details (table of all parameters for all adapters)
//                                             [adapt diam', org' diam', height, lip height, lip ext', tube thickn', rad' thickn']
HobbyKingPETGtoWanhaoDuplicatori3PlusDetails = [74.2,        32.0,       60.0,   1.6,        2.0,      1.0,          1.0         ];
MamorubotPETGtoWanhaoDuplicatori3PlusDetails = [53.2,        32.0,       60.0,   1.6,        2.0,      1.0,          1.0         ];

// Parameters Index (all parameters which control this design see descriptions in 'Assign adapter parameters' below )
adapt_diameter_index    = 0;
original_diameter_index = 1;
height_index            = 2;
lip_height_index        = 3;
lip_extension_index     = 4;
tube_thickness_index    = 5;
radial_thickness_index  = 6;

// Collection Of All Adapters (must match Adapter Details entries)
Adapters = [HobbyKingPETGtoWanhaoDuplicatori3PlusDetails,
            MamorubotPETGtoWanhaoDuplicatori3PlusDetails];

// Assign adapter parameters
// If you just want to experiment you can enter parameters directly here rather than use the index

adapt_diameter    = Adapters[Adapter][adapt_diameter_index   ]; // the internal diameter of the new spool 74.2 for HobbyKing PETG, 53.2 for Mamorubot PETG
original_diameter = Adapters[Adapter][original_diameter_index]; // the diameter of spool required for your printer's spool holder                        
height            = Adapters[Adapter][height_index           ]; // height/width of your spool                                                             
lip_height        = Adapters[Adapter][lip_height_index       ]; // the length of the lip in addition the height/width                                    
lip_extension     = Adapters[Adapter][lip_extension_index    ]; // how far the lip extends past the adapter diameter                                     
tube_thickness    = Adapters[Adapter][tube_thickness_index   ]; // thickness of the tube sections                                                        
radial_thickness  = Adapters[Adapter][radial_thickness_index ]; // thickness of the radial sections                                                      

$fn               = 120; // make larger for more accurate curvature, smaller for faster rendering

adapter();

module adapter()
{
  union()
  {
    lip();
    barrel();
  }  
}

module barrel()
{
  difference()
  {
  union()
  {
    difference() {cylinder(d =adapt_diameter,h=height+lip_height); cylinder(d=adapt_diameter-2*tube_thickness,h=height+lip_height);}
    cylinder(d =original_diameter+2*tube_thickness,h=height+lip_height);
    for (i = [0:45:315])
    {    
      //rotate(a = i) rotate_extrude(angle=4,convexity=10)
      //square([(adapt_diameter-.2)/2,height],false);
      rotate(a = i, convexity=10)
      translate([0,0,(height+lip_height)/2]) cube([adapt_diameter-tube_thickness,radial_thickness,height+lip_height],true);
    }
  }
  cylinder(d=original_diameter,h=height+lip_height);
  }
}  

module lip()
{
  difference() {cylinder(d =adapt_diameter+2*lip_extension,h=lip_height); cylinder(d=adapt_diameter-2*tube_thickness,h=lip_height);}
}    

