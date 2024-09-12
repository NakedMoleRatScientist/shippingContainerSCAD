
front = "0.1uF"
back = "1uF"
if ENV['front'] != nil
    front = ENV['front']
end
if ENV['back'] != nil
    back = ENV['back']
end

task :generate do
    start = "OpenSCAD -o #{front}-#{back}.stl 0.1-1uF.scad"
    print_option = " -D print=\\\"box\\\""
    front_option = " -D front=\\\"#{front}\\\""
    back_option = " -D back=\\\"#{back}\\\""
    box = start + print_option + front_option + back_option
    sh box
    start = "OpenSCAD -o #{front}-#{back}-nameplate1.stl 0.1-1uF.scad"
    print_option = " -D print=\\\"nameplate1\\\""
    nameplate1 = start + print_option + front_option + back_option
    sh nameplate1
    start = "OpenSCAD -o #{front}-#{back}-nameplate2.stl 0.1-1uF.scad"
    print_option = " -D print=\\\"nameplate2\\\""
    nameplate2 = start + print_option + front_option + back_option
    sh nameplate2

end
