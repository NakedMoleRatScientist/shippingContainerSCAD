use <small_box.scad>;
use <vendors/UtilitySCAD-R1/utility.scad>;

width = 200;
length = 100;
height = 100;
thickness = 5;
thickness_2 = thickness * 2;
resistor_w = 70;
m = 0.2;

module endstop()
{
    cube([3 - m,3 - m,3 - m]);
}

module place_endstops(h)
{
   // endstop();
    move_z(h - 3 + m)
    {
        endstop();

    }
}

module divide_container()
{
    h_division = 4;
    v_division = 4;
    wall = 1;
    spacing = wall / h_division;
    x_multiply = (width - 10) / h_division;
    box_w = (width - 10) / h_division;
    cut = 0.1;
    mini_h = (height - thickness_2)/ v_division;
    difference()
    {
        cube([width,length,height]);
        for (i = [0:1:h_division - 1])
        {
            start_x = 5 + i * (x_multiply + (wall / (h_division - 1)));
            for (z = [0:1:v_division - 1])
            {
                start_z = 5 + z * (mini_h + wall / (v_division - 1));
                translate([start_x,-cut,start_z])
                {
                    cut_box(box_w - wall,length - 5,mini_h - wall);
                }
            }
        }
    }
//    difference()
//    {
//        cube([box_w + 3, 3,mini_h + 3]);
//        translate([1,-1,1])
//        {
//            cut_box(box_w - wall, 4, mini_h - wall);
//        }
//    }
    echo("width")
    echo(box_w - wall);
    echo(length - 5);
    echo(mini_h - wall);
    move_x(210)
    {
       // small_box(box_w - wall, length - 5, mini_h - wall, 0.1);
    }
}


module cut_box(box_w,box_l,box_h)
{
    difference()
    {
        solid_cube(box_w,box_l,box_h);
        center(3 - m,box_w)
        {
            translate([0,5,0])
            {
                place_endstops(box_h);
            }
        }
    }
}

module generate_to_fit()
{
    
    into_c = (width - 10) / resistor_w;
    cutoff = floor(into_c);
    wall = 2;
    m = 0.2;
    difference()
    {
        cube([width,length,height]);
        cut = 0.1;

        for(w = [0:1:cutoff - 1])
        {
            increase = (resistor_w + wall) * w + thickness;
            translate([increase,-cut,thickness])
            {
                cut_box(resistor_w,length - thickness,height - thickness_2);
            }
        }
        leftover = thickness + (wall * cutoff) + (resistor_w * cutoff);
        end = width - thickness - leftover;
        reps = 2;
        mini_h = (height - thickness_2 - wall) / reps;
        for (i = [0:1:reps - 1])
        {
            translate([leftover,-cut,thickness + ((mini_h + wall) * i)])
            {
                cut_box(end,length - thickness,mini_h);
            }
        }
        
    }
    
}

generate_to_fit();