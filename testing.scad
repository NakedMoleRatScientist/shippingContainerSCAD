








$fa = 1;
$fs = 0.1;


use <vendors/UtilitySCAD-R1/utility.scad>;

width = 100;
length = 200;
height = 50;
thickness = 3;
divider = 4;
function divide_by_y(target_l,center_l,times) = (target_l - center_l * (times - 1)) / times;

small_l = divide_by_y(length,thickness,divider);

r = 2;
for(i=[0:1:divider - 1])
{
    translate([0,(small_l + thickness) * i,0])
    {
        hull()
        {
            hor_cylinder(width,r);
            translate([0,0,height - (r * 2)])
            {
            hor_cylinder(width,r);
            }
            translate([0,small_l - (r * 2),0])
            {
                hor_cylinder(width,r);
                translate([0,0,height - (r * 2)])
                {
                    hor_cylinder(width,r);
                }
            }
        }
    }
}
translate([width,0,0])
{
    for(i=[0:1:divider - 1])
    {
        translate([0,(small_l + thickness) * i,0])
        {
            cube([width,small_l,height]);
        }
    }
}
translate([width * 2,0,0])
{
    cube([width,length,height]);

}