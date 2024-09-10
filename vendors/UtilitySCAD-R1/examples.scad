/* Public domain, for your own use. */
use <utility.scad>;

cube2 = [2,2,2];
d = 20;
cube([d,2,2]);
move_z(2)
{
    castellate(d,cube2);
}
move_y(4)
{
    cube3 = [4,2,2];
    d = 19;
    cube([d,2,2]);
    move_z(2)
    {
        castellate(d,cube3);
    }
}

translate([0,-20,0])
{
   bevel_up_back_45(10,10,20);
}

use <MCAD/regular_shapes.scad>;

translate([0,-30,0])
{
   bevel_up_front_45(10,2,20);
}
