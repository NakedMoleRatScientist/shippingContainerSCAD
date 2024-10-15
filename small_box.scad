$fa = 1;
$fs = 0.1;
use <vendors/UtilitySCAD-R1/utility.scad>;

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

module small_box(width,length,height,m = 0,print = "all",div=1)
{
    thickness = 5;
    side_thickness = 1.5;
    cut = 0.1;
    m_2 = m * 2;
    w = width - m_2;
    l = length - m_2;
    z = height - m_2;
    handle_w = 10;
    handle_h = 5;
    handle_l = 2;
    total_h = (z - handle_h) / 2 - 2;
    if (print == "box" || print == "all")
    {
        difference()
        {
            cube([w,l,z]);
            //Create rail
            move_y(3)
            {
                center(3,width)
                {
                    move_z(-0.1)
                    {
                        cube([3,length - 5,3 + cut + m]);
                    }
                 }
            }
            //inside volume
        
            translate([side_thickness + m,thickness,thickness])
            {
                r = 3;
                r_2 = r * 2;
                thickness_2 = thickness * 2;
                inside_w = w - (side_thickness * 2) - m;
                inside_l = l - thickness_2;
                wall = 2;
                divider_l = divide_by_y(inside_l,wall,div);
                for(i=[0:1:div - 1])
                {
                    hull()
                    {
                        translate([0,(divider_l + wall) * i,0])
                        {
                            hulling(inside_w,r,z + 1,thickness);
                            translate([0,divider_l - r_2,0])
                            {
                                hulling(inside_w,r,z + 1,thickness);

                            }
                        }
                    }
                 }
                 
            }
            // Cutting off to allow free movement.
            translate([-cut,l - 3,z - 1])
            {
                cube([w + 0.2,3 + cut,3]);
                translate([0,1,-1])
                {
                    cube([w + 0.2,2 + cut,3]);
                }
                translate([0,2,-2])
                {
                    cube([w + 0.2,2 + cut,3]);
                }
            }
            //Nameplate holder
            translate([1,-cut,1])
            {

                cube([w - 2,1 + cut,total_h - 2]);
                cube([w - 2,2 + cut,total_h - 3]);

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
    translate([w + 1,0,0])
    {
        plate_m = 0.05;
        plate_m2 = plate_m * 2;
        plate_l = total_h - 2 - plate_m2;
        if (print == "nameplate1" || print == "all" || print == "nameplate")
        {
            cube([w - 2 - plate_m2,plate_l - 1,0.2]);
        }
        if(print == "nameplate2" || print == "all" || print == "nameplate")
        {
            translate([0,0,0.2])
            {
                cube([w - 2 - plate_m2,plate_l - 1,0.8]);
                
            }
            translate([0,0,1])
            {
                cube([w - 2 - plate_m2,plate_l,1]);
            }
        }

    }    
       

}



small_box(46.5,95,44,0.4,"box");

