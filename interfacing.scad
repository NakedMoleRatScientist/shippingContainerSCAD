use <vendors/UtilitySCAD-R1/utility.scad>;

size = 5;
width = 10;
height = 15;
m_2 = 0.2;
m = 0.1;

difference()
{
    cube([width,size,height]);
    translate([size,-0.1,size])
    {
        cube([width,size + 0.2,height - (size * 2)]);
    }
    center_y(2,5)
    {
        translate([size - 2,0,size - 2])
        {
            cube([width,2,height - (size * 2) + 4]);
        }
    }
}

translate([30,0,0])
{
    cube([width - 5,height - (size * 2),size]);
    center_z(2 - m_2,5)
    {
        translate([-2 + m,-2 + m,0])
        {
            cube([width - 5 + 4,height - (size * 2) + 4,2 - m_2]);
        }
    }
}