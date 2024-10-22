$fa = 1;
$fs = 0.1;

include <vendors/BOSL2/std.scad>
use <vendors/UtilitySCAD-R1/utility.scad>;

cut = 0.1;

function divide_by_y(target_l,center_l,times) = (target_l - center_l * (times - 1)) / times;

module solid_cube(width,length,height)
{
    cube([width,length,height]);
}


module handle(w,l,h)
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

module hulling(inside_w,r,z,thickness)
{
    hor_cylinder(inside_w,r);
    translate([0,0,z + 0.1 - thickness - (r * 2)])
    {
        hor_cylinder(inside_w,r);
    }
}

module nameplate(w,cham,nameplate_h)
{
    cham_2 = cham * 2;
    cuboid([w - cham_2 - 14,2 + cut,cham * nameplate_h],chamfer=1,edges=[TOP+BACK],$fn=24);
}

module small_box(width,length,height,m = 0,print = "all",div=1)
{
    thickness = 5;
    side_thickness = 1.5;
    m_2 = m * 2;
    w = width - m_2;
    l = length - m_2;
    z = height - m_2;
    nameplate_h = 5;
    cham = 3;
    cham_2 = cham * 2;
    cham_move = cham / 2;
    if (print == "box" || print == "all")
    {
        difference()
        {
            cuboid([w,l,z],chamfer=cham,except=[TOP+LEFT,TOP+RIGHT]);
            //Create rail
            move_z((-z / 2) + 1.5 - cut)
            {
                cube([3,l - (cham * 2) - 1,3 + cut],center = true);
            }

            //inside volume
            translate([0,l / 4 ,10])
            {
                cuboid([w - 2,l / 2 - 6,z + 10],rounding=10);
                translate([0,l / 4 - 2,-10])
                {
                    nameplate(w,cham,nameplate_h);
                }
            }
            translate([0,-l / 4,10])
            {
                cuboid([w - 2,l / 2 - 6,z + 10],rounding=10);
                 translate([0,l / 4 - 2,-10])
                {
                    nameplate(w,cham,nameplate_h);
                }
            }
            //nameplate holder
            translate([0,-(l / 2) + 1 - cut,-(z / 2) + cham_move * nameplate_h + cham])
            {
                nameplate(w,cham,nameplate_h);
            }
            //handle
            translate([0,-(l / 2) + 1 - cut,0])
            {
                cuboid([10,2 + cut,5],chamfer=1);
            }
            
        }
    }
    translate([w + 1,0,0])
    {
        plate_m = 0.05;
        plate_m2 = plate_m * 2;
        plate_l = nameplate_h - 2 - plate_m2;
        if (print == "nameplate1" || print == "all" || print == "nameplate")
        {
                            //nameplate(w,cham,nameplate_h);

        }
        if(print == "nameplate2" || print == "all" || print == "nameplate")
        {
            
        }

    }    
    translate([w / 2,-l / 2,-(z / 2)])
    {
        cylinder(0.2,10,10);   
    }
    translate([-(w / 2),-l / 2,-(z / 2)])
    {
        cylinder(0.2,10,10);   
    }
    translate([-(w / 2),l / 2,-(z / 2)])
    {
        cylinder(0.2,10,10);   
    }
    translate([(w / 2),l / 2,-(z / 2)])
    {
        cylinder(0.2,10,10);   
    }

}



small_box(46.5,95,44,0.4,"all");

