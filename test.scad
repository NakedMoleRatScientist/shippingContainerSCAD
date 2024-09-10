
size = 5;
width = 10;
m_2 = 0.2;
m = 0.1;

difference()
{
    cube([width,size,size]);
    translate([-m,-m,5])
    {
        cut_wall(size);
    }
}
    


module cut_wall(size)
{
    translate([0,1,-size + 1])
    {
        cube([width - 1,size - 2,size]);
    }
}

module wall(size)
{
    cube([10,size,size]);
    smaller_size = size - m_2;

    translate([0,1 + m,-size + 1])
    {
        cube([width - 1,size - 2 - m_2,size]);
    }
}

translate([20,0,0])
{
    wall(5);
}