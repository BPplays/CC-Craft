if fs.exists("AndysPrograms/api/update") == false then
    fs.makeDir("AndysPrograms/api")
    shell.run("cd","AndysPrograms/api")
    shell.run("pastebin","get","1niw24Vd","update")
    shell.run("cd","..")
    shell.run("cd","..")
end
launcherargs = {...} 
fudargs = "sleep(5)\nshell.run(\"craft\", \"noset\")"
--print (fudargs)
--sleep (5)
farmlauncherloop = 1
while true do
    shell.run("AndysPrograms/api/update", "gt", "a3GBewNp", "AndysPrograms/api", "none", "none")
    local stu = fs.open("startup.lua", "w")
    stu.write(fudargs)
    stu.close()
    shell.run("AndysPrograms/api/update", "craft", "N5zTVskN", "AndysPrograms/craft", "none", "no", unpack(launcherargs))
    os.loadAPI("AndysPrograms/craft/craft")
    if farmlauncherloop > 1 then 
        launcherargs = {"noset"}
    end
    craft.craft(launcherargs)
    sleep(0) 
    if farmlauncherloop < 100 then
        farmlauncherloop = farmlauncherloop + 1
    end
end