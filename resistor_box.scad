

use <small_box.scad>;

use <vendors/UtilitySCAD-R1/utility.scad>;

print = "all";
width = 70;
length = 95;
height = 90;
m = 0.2;
module symbol()
{
        translate([33,10,0])
        {

                linear_extrude(2)
                {
                   import(file = "resistor.svg", center = true);
                }
        }
}

difference()
{
small_box(width,length,height,m,print);
    if (print == "nameplate2" || print == "all")
    {
        translate([width + 1.2,0.5,0.2])
        {
            move_x(25)
            {
                resistor_text();
            }
            move_y(10)
            {
                symbol();
            }
        }
    }
}
    
module resistor_text()
{
    linear_extrude(2)
    {
        text("47");
    }
}
