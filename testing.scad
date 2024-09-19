








$fa = 1;
$fs = 0.1;


use <vendors/UtilitySCAD-R1/utility.scad>;

width = 20;
length = 20;
height = 15;
thickness = 5;
thickness_2 = thickness * 2;

module lock()
{
    difference()
    {
        cube([width,length,height]);
        translate([0,0,-0.1])
        {
            center(10,20)
            {
                center_y(3,length)
                {
                    cube([10,3,height + 0.2]);
                }
            }
            center(5,20)
            {
                center_y(10,length)
                {
                   translate([0,0,5 + 0.1])
                   {
                        cube([5,10,5]);
                   }
                }
            }
        }
        translate([10,10,-0.1])
        {
            cylinder(height - 10 + 0.1,5,5);
        }
        
    }
}

//lock();

key();

module key()
{
    center_y(5,10)
    {
        cube([10,5,10]);
    }  
    center(5,10)
    {
        translate([0,0,5])
        {
            cube([5,10,5]);
        }
    }
}