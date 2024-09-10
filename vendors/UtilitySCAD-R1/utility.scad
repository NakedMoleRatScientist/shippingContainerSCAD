/*This library, part of UtilitySCAD, is placed into the public domain by NMR_Scientist.

Version: R1
Title: UtilitySCAD
Description: Miscellaneous utility modules I developed over the course of several projects to reuse common operations that were seen over various models.

History:
* ??/??/2024 - R1 - First release to be with a model whenever it is released.
*/

$fa = 1;
$fs = 0.1;

use <MCAD/regular_shapes.scad>;

//Move objects in the x-axis.
module move_x (x)
{
    translate([x,0,0])
    {
        children();
    }
}

//Move objects in the y-axis
module move_y (y)
{
    translate([0,y,0])
    {
        children();
    }
}

//Move objects in the z-ax
module move_z (z)
{
    translate([0,0,z])
    {
        children();
    }
}

//Move objects by a given point in all direction. -1 would means moving to the left, moving back, and moving down by one point.
module move_by(point)
{
    translate([point,point,point])
    {
        children();
    }
}

//Exactly like move_by, but a negation. Named for its very common use in adding tolerance to objects.
module move_by_margin(m)
{
    move_by(-m)
    {
        children();
    }
}

//A cylinder rotated to its side.
module hor_cylinder(width,r,r)
{
    move_y(r)
        move_z(r)
            rotate([0,90,0])
            {
                cylinder(width,r,r);
            }
}

module hor_cylinder_y(length,r)
{
    translate([r * 2,0,0])
    {
        rotate([0,0,90])
        {
            hor_cylinder(length,r);
        }
    }
}


//Cut a object at a given height and then move that object down, usually to zero if the object was placed at zero height.
module hor_cut(width,length,height)
{
    translate([0,0,-height])
    {
        difference()
        {
            children();
            translate([-1,-1,-1])
            {
                cube([width + 2,length + 2,height + 1]);
            }
        }
    }
}

function bevel_radius(length) = length * 2 / 3;
function bevel_height(r) = r * sqrt(3)/2;

//Bevel at 45 degree slope up, facing back, then extrude upward by height.
module bevel_up_back_45(width,length,height)
{
    r = bevel_radius(length);
    z = bevel_height(r);
    m = 0.1;
    m_2 = m * 2;
    difference()
    {
        translate([0,r / 2,z])
        {
            rotate([0,90,0])
            {
                triangle_prism(width,r);
            }
        }
        // Cut off to the required height.
        move_x(-m)
            move_y(-m)
                move_z(height)
                   cube([width + m,length + m,z * 2 - height]);
    }
    //If cutting off isn't happening simply add height.
    if (height >= z)
    {
        move_z(z)
        {
            cube([width,length,height - z]);
        }
    }
}

module bevel_up_front_45(width,length,height)
{
    r = bevel_radius(length);
    z = bevel_height(r);
    m = 0.1;
    m_2 = m * 2;
    difference()
    {
        translate([width,r,z])
        {
            rotate([0,90,180])
            {
                triangle_prism(width,r);
            }
        }
        // Cut off to the required height.
        move_x(-m)
            move_y(-m)
                move_z(height)
                   cube([width + m,length + m,z * 2 - height]);
    }
    //If cutting off isn't happening simply add height.
    if (height >= z)
    {
        move_z(z)
        {
            cube([width,length,height - z]);
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

//Center an object against a particular width of another object.
module center(centering_w,target_w)
{
    x = (target_w - centering_w) / 2;
    translate([x,0,0])
    {
        children();
    }
}

//Move object to a certain value of x, but also account for the object size, such that the object is place before the point x. For a postive value of x, that is before the x, for a negative value of x, that is next to x. Useful for dimensional accurate placement.
module move_object_x(x,r)
{
    diameter = r * 2;
    if (abs(x) < diameter)
    {
        echo("Cannot move!");
    }
    else
    {
        if (x > 0)
        {
            move_x(x - diameter)
            {
                children();
            }
        }
        else if (x < 0)
        {
            move_x(x + diameter)
                children();
        }
    }
}


//Move object to a certain value of z, but also account for the object size, such that the object is place before the point z. For a postive value of z, that is below of z, for a negative value of z, that is above z. Useful for dimensional accurate placement.
module move_object_z(z, r)
{
    diameter = r * 2;
    if (abs(z) < diameter)
    {
        echo("Cannot move!");
    }
    else
    {
        if (z > 0)
        {
            move_z(z - diameter)
            {
                children();
            }
        }
        else if (z < 0)
        {
            move_z(z + diameter)
                children();
        }
    }
}


//Generaate all notches in a castellation at the same time, and space each notch for the length of the notch.
module notches(n, multipler)
{
    for (x = [1:n])
    {
        final_x = (x - 1) * multipler;
        move_x(final_x)
        {
            if ((x - 1) % 2 == 0)
            {
               children();
            }
        }
    }
}

//Get the total width of the Castellation, starting with the first and last notches.
function CastellateTotalW(w,size) = (w - 1) % 2 == 1 ? (w - 1) * size.x : w * size.x;


//Center the resulting castellation of a certain cuboid size.
module castellate(width,size, m = 0)
{
    total_notches = floor(width / size.x);
    total_w = CastellateTotalW(total_notches,size);
    center(total_w,width)
    {
        notches(total_notches,size.x)
        {
            move_x(m)
            {
                shrink = [size.x - (m * 2),size.y,size.z];
                cube(shrink);
            }
        }
    }

}


