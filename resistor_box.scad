

use <small_box.scad>;

use <vendors/UtilitySCAD-R1/utility.scad>;

module symbol()
{

        translate([30,0,(25 / 2)])
        {
            rotate([90,0,0])
            {
                linear_extrude(2)
                {
                   import(file = "resistor.svg", center = true);
                }
            }
        }
}

translate([0,0,0])
{

    difference()
    {
        small_box(70,95,90,0.2);
        translate([0,1.9,0])
        {
            move_z(5)
            {
                resistor_text();
                
            }   
            translate([0,0,15])
            {
                center(60,70)
                {
                    symbol();

                }
            }

        }
    }
}

module center_z(centering_z,target_z)
{
    z = (target_z - centering_z) / 2;
    translate([0,0,z])
    {
        children();
    }
}

module center_y(centering_y,target_y)
{
    y = (target_y - centering_y) / 2;
    translate([0,y,0])
    {
        children();
    }
}

module resistor_text()
{
    rotate([90,0,0])
    {
        linear_extrude(2)
        {
            text("47");
        }
    }
}
