

task :generate do
    front = "0.1uF"
    back = "1uF"
    if ENV['front'] != nil
        front = ENV['front']
    end
    if ENV['back'] != nil
        back = ENV['back']
    end
    start = "OpenSCAD -o #{front}-#{back}.stl 0.1-1uF.scad"
    print = " -D print=\\\"box\\\""
    front = " -D front=\\\"#{front}\\\""
    back = " -D back=\\\"#{back}\\\""
    command = start + print + front + back
    sh command
end

task :nameplate do
    front = "0.1uF"
    back = "1uF"
    if ENV['front'] != nil
        front = ENV['front']
    end
    if ENV['back'] != nil
        back = ENV['back']
    end
    start = "OpenSCAD -o #{front}-#{back}-nameplate.stl 0.1-1uF.scad"
    print = " -D print=\\\"nameplate\\\""
    front = " -D front=\\\"#{front}\\\""
    back = " -D back=\\\"#{back}\\\""
    command = start + print + front + back
    sh command
end
