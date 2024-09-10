$fa = 1;
$fs = 0.1;
use <vendors/UtilitySCAD-R1/utility.scad>;

module small_box(width,length,height,m = 0,print = 0)
{
    thickness = 5;
    side_thickness = 2;
    cut = 0.1;
    m_2 = m * 2;
    w = width - m_2;
    l = length - m_2;
    z = height - m_2;
    handle_w = 10;
    handle_h = 5;
    handle_l = 2;
    total_h = (z - handle_h) / 2 - 2;
    if (print == 0)
    {
        difference()
        {
            cube([w,l,z]);
            //Make the middle part height 3 mm lower. Helps make it easier to fit the drawers into the shipping container.
            translate([-cut,thickness,z - 3])
            {
                cube([w + (cut * 2),l - (thickness * 2),4]);
            }
            //inside volume
            translate([side_thickness + m,thickness,thickness])
            {
                inside_w = w - (side_thickness * 2) - m;
                hull()
                {
                    hor_cylinder(inside_w,1);
                    translate([0,0,z - thickness])
                    {
                        hor_cylinder(inside_w,1);
                    }
                    translate([0,l - (thickness * 2) - 2,0])
                    {
                        hor_cylinder(inside_w,1);
                        translate([0,0,z - thickness])
                        {
                            hor_cylinder(inside_w,1);
                        }
                    }
                }
            }
            translate([-cut,l - 3,-cut])
            {
                cube([w + (cut * 2),3 + cut,3 + cut]);
            }
            translate([1,-cut,1])
            {
                difference()
                {
                    cube([w - 2,2 + cut,total_h]);
                }
            }
            center_z(handle_h,z)
            {
                center(handle_w,w)
                {
                    handle(handle_w,handle_l,handle_h);
                        
                }
                
            }
        }
    }
    if (print == 1)
    {
        translate([w + 1,0,0])
        {
            cube([w - 2 - m_2,total_h - m_2,2]);
        }
    }

}

module solid_cube(width,length,height)
{
    cube([width,length,height]);
}

small_box(40,100,25,0.1);

module handle(w,l,h)
{
    translate([0,0,0])
    {
        rotate([90,0,90])
        {
            linear_extrude(w)
            {
              polygon(points=[[0,0],[l,0],[0,h]],paths=[[0,1,2]]);
            }
        }
        translate([0,l - 1,-0.9])
        {
            cube([w,1,1]);
        }
        translate([0,-0.9,0])
        {
            cube([w,1,h]);
        }
    }
}