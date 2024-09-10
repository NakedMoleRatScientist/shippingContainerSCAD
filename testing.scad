








$fa = 1;
$fs = 0.1;


use <vendors/UtilitySCAD-R1/utility.scad>;

difference()
{
    size = 20;
    cube([5,size,size]);
    translate([-1,0,0])
    {
        hor_cylinder(52,size);
    }
}