
front = "0.1uF"
back = "1uF"
if ENV['front'] != nil
    front = ENV['front']
end
if ENV['back'] != nil
    back = ENV['back']
end

task :box8x4 do
    start = "OpenSCAD -o #{front}-#{back}.stl 8x4_drawers.scad"
    print_option = " -D print=\\\"box\\\""
    front_option = " -D front=\\\"#{front}\\\""
    back_option = " -D back=\\\"#{back}\\\""
    box = start + print_option + front_option + back_option
    sh box
    start = "OpenSCAD -o #{front}-#{back}-nameplate1.stl 8x4_drawers.scad"
    print_option = " -D print=\\\"nameplate1\\\""
    nameplate1 = start + print_option + front_option + back_option
    sh nameplate1
    start = "OpenSCAD -o #{front}-#{back}-nameplate2.stl 8x4_drawers.scad"
    print_option = " -D print=\\\"nameplate2\\\""
    nameplate2 = start + print_option + front_option + back_option
    sh nameplate2

end

task :big_box do
        start = "OpenSCAD -o resistor_box.stl resistor_box.scad"
        box = " -D print=\\\"box\\\""
        nameplate1 = " -D print=\\\"nameplate1\\\""
        nameplate2 = " -D print=\\\"nameplate2\\\""
        sh (start + box)
        start = "OpenSCAD -o resistor-nameplate1.stl resistor_box.scad"
        sh (start + nameplate1)
        start = "OpenSCAD -o resistor-nameplate2.stl resistor_box.scad"
        sh (start + nameplate2)
end
