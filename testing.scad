








$fa = 1;
$fs = 0.1;


use <vendors/UtilitySCAD-R1/utility.scad>;

width = 100;
length = 2;
height = 50;

module shape()
{
    cube([width,length,height]);
}

module shape_flat()
{
    cube([width,height,length]);
}

module cut_corner()
{
    size = 2;
    scale([1,1.1,1])
    {
        translate([-1,0,size])
        {
            rotate([0,90,0])
            {
                linear_extrude(width + 2)
                {

                    polygon([[0,0],[0,size],[size,size]],[[0,1,2]]);

                }
            }
        }
    }
}

module cut_corner_horz()
{
    size = 2;
    scale([1,1.1,1])
    {
        translate([-1,0,size])
        {
            rotate([0,90,0])
            {
                linear_extrude(width + 2)
                {

                    polygon([[size,0],[0,size],[size,size]],[[0,1,2]]);

                }
            }
        }
    }
}

difference()
{
    shape_flat();

    translate([0,height - 2,0])
    {
        cut_corner_horz();
    }
}