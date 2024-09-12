$fa = 1;
$fs = 0.1;

use <small_box.scad>;
use <vendors/UtilitySCAD-R1/utility.scad>;

print = "box";
cut = 0.1;
width = 46.5;
length = 95;
height = 21.5;
m = 0.2;
m_2 = m * 2;
w = width - m_2;
l = length - m_2;
h = height - m_2;
front = "0.15uF";
back = "1.5uF";
title = str(front,"-",back);


difference()
{
    small_box(width,length,height,m,print,2);
    if (print == "box")
    {
        move_y(90)
        {
            refill();
            translate([5,1,13])
            {
                rotate([90,0,0])
                {
                    linear_extrude(4)
                    {
                        text(back,size = 8);
                    }
                }
            }
        }
        if (print == "box")
        {
            center_y(2,l)
            {
                depth = 2;
                translate([5,depth - 1,13])
                {
                    rotate([90,0,0])
                    {
                        linear_extrude(depth)
                        {
                            text(front,size = 5);
                        }
                    }
                }
                refill();
            }
         }
    }
    if (print == "nameplate2")
    {
        translate([w + 1.2,0.5,0.2])
        {
            box_text();
        }
    }

}

module refill()
{
    depth = 2;
    translate([5,depth - 1,6])
    {
        rotate([90,0,0])
        {
            linear_extrude(depth)
            {
                text("refill",size = 5);
            }
            
        }
    }
    translate([5,-1,12])
    {
        hr();
    }
        
}

module hr()
{
    cube([w - 10,2,0.2]);

}





module box_text()
{
    linear_extrude(2)
    {
        text(title,size = 5);
    }
}