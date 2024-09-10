 /*This library, part of UtilitySCAD, is placed into the public domain by NMR_Scientist. */

 use <utility.scad>;


$fa = 1;
$fs = 0.1;

diameter = 5.6;
t = 2;
m = 0.2;
height = 5 - m;
width = 10;

hook(diameter,t,width,height);
translate([20,0,0])
{
    hook_upper(diameter,t,width,height);
}

translate([25,0,0])
{
    hook_mirrored(diameter,t,width,height);
}

translate([70,0,0])
{
    beveled_circular_hook(20,2.1,18,7,3.1);
}

module hook(diameter,t,width,height)
{
    inner_r = diameter / 2;
    outer_r = inner_r + t;
    translate([outer_r,outer_r,0])
    {
        difference()
        {
            cylinder(height,outer_r,outer_r);
            translate([0,0,-1])
            {
                cylinder(height + 2,inner_r,inner_r);
            }
            translate([0,-inner_r,-1])
            {
                cube([outer_r,inner_r * 2,height + 2]);
            }
        }
        translate([0,inner_r,0])
        {
            cube([outer_r + width,t,height]);
        }
        translate([0,-outer_r,0])
        {
            cube([outer_r,t,height]);
        }
    }
}

module hook_upper(diameter,t,width,height)
{

    inner_r = diameter / 2;
    outer_r = inner_r + t;
    echo(outer_r);
    move_z = outer_r * 2 + width;
    translate([0,0,move_z])
    {
        rotate([0,90,0])
        {
            hook(diameter,t,width,height);
        }
    }
}

module hook_mirrored(diameter,t,width,height)
{
    hook(diameter,t,width,height);
    total_length = diameter + width + t * 2;
    color("red")
    {
        translate([total_length * 2,0,0])
        {
            mirror([1,0,0])
            {
                hook(diameter,t,width,height);
            }
        }
    }
}


module beveled_circular_hook(width,length,height,diameter,neck_w)
{
    above_bevel = bevel_height(bevel_radius(length));
    total_h = above_bevel + diameter * 2;
    if (total_h > height)
    {
        echo("WARNING: Height might need to be raised or nail diameter needs to be smaller");
    }
    if (length <= 2)
    {
        echo("WARNING: Depth too low, allowing voids to be created.");
    }
    difference()
    {
        bevel_up_back_45(width,length,height);
        translate([0,length - 2,above_bevel])
        {


            circular_hook(diameter,width,neck_w);
        }
    }
}

module circular_hook(diameter,width,neck_w)
{
    r = diameter / 2;
    center(diameter,width)
        hor_cylinder_y(3,r);
    move_z(diameter - 1)
        center(neck_w,width)
            cube([neck_w,3,diameter + 1]);

    center(diameter,width)
    {
        hull()
        {
            hor_cylinder_y(1,r);
            move_object_z(diameter * 2,r)
            {
                hor_cylinder_y(1,r);
            }
        }
    }
}
