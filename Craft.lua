function craft(crargs)
    os.loadAPI("sugurapi/gt")
    term.clear()












    if fs.exists("AndysPrograms/craft/settings") then
        settings.load("AndysPrograms/craft/settings")
    end
    local maxW, maxH = term.getSize()
    
    
    
    function exit()
        term.clear()
        term.setCursorPos(1, 1)
        print("Starting")
        openset = 0
    end
    function chngset()
        chngsel = 1
    end
    
    function savesets()
        settings.save("AndysPrograms/craft/settings")
    end
    gpstab = {}
    local stgpsx, stgpsy, stgpsz = gps.locate(5)
    table.insert(gpstab, stgpsx)
    table.insert(gpstab, stgpsy)
    table.insert(gpstab, stgpsz)
    table.insert(gpstab, "n")
    if fs.exists("AndysPrograms/craft/settings") == false then
        if fs.exists("AndysPrograms/craft") == false then
          fs.makeDir("AndysPrograms/craft")
        end
    
    
    
    local temp = {}

        settings.set("item Location", gpstab)
        settings.set("item slots", temp)
        settings.set("put Location", gpstab)
        settings.set("put slot", temp)
        savesets()
      
        
        
      end
    function resetmenu()
    deftab = {}
    setmenu = {}
    setmenu = {
        {text = "Finish editing:", options = "Finish", handler = exit},
        {text = "Item Location", setname = "item Location", options = settings.get("item Location"), type = deftab, handler = chngset},
        {text = "Item Slots", setname = "item slots", options = settings.get("item slots"), type = deftab, handler = chngset},
        {text = "Put Location", setname = "put Location", options = settings.get("put Location"), type = deftab, handler = chngset},
        {text = "Put Slot", setname = "put slot", options = settings.get("put slot"), type = "num", handler = chngset}
    }
    
    end
    resetmenu()
    
    function addsettings(num, value)
        settings.set(setmenu[num].setname, value)
        savesets()
    end
    
    openset = 1
    
    if crargs[1] == "noset" then
        openset = 0
    end
    
    while openset == 1 do
    
    local overprintw = 0
    
    local sublet = 0
    if openset == 1 then
        chngsel = 0
        term.clear()
        local setsoffset = 3
        local selitem = 1
        --if (maxH) < (#setmenu * 2) then
        --    selitem = maxH / 2
       -- elseif (maxH) > (#setmenu) then
           --selitem = 1
        --end
        divamloop = 0
        divamloopo = 0
        divamo = 0
        function printmenu(menu)
            while divamloopo > 1 do
                --setsoffset = setsoffset + #setmenu[sets].text / maxW
                setsoffset = setsoffset - 1
                divamloopo = divamloopo - 1
            end

            while divamloop > 1 do
                --setsoffset = setsoffset + #setmenu[sets].text / maxW
                setsoffset = setsoffset - 1
                divamloop = divamloop - 1
            end

            for sets=1,#setmenu do
                
                setsmul = (sets * 2) - 1
                if (setsmul + setsoffset) <= maxH then
                    divam = #setmenu[sets].text / maxW
                    --print(divam)
                    while divam > 1 do
                        --setsoffset = setsoffset + #setmenu[sets].text / maxW
                        setsoffset = setsoffset + 1
                        divam = divam - 1
                        divamloop = divamloop + 1
                    end
                    term.setCursorPos(1, setsmul + setsoffset) 
                    print(setmenu[sets].text)
                    --print(divam)
                    term.setCursorPos(1, (setsmul + 1) + setsoffset) 
                    if setmenu[sets].options ~= nil then

                        term.clearLine()
                        prntset = setmenu[sets].options
                        if (type(prntset) == "table") then
                            prntset = table.concat(setmenu[sets].options, ", ")
                        end
                        divamo = (#tostring(prntset) / maxW) + 1
                        --print(divamo)
                        while divamo > 1 do
                            --setsoffset = setsoffset + #setmenu[sets].text / maxW
                            setsoffset = setsoffset + 1
                            divamo = divamo - 1
                            divamloopo = divamloopo + 1
                        end
                        if selitem == sets then
                            if chngsel == 1 then 
                                input = read()
                                if input then
                                    inptesset = setmenu[sets].type
                                    if type(inptesset) == "table" then
                                        settingsinputtable = {}
                                        input2 = string.gsub(input, ", ", ",")
                                        --print(input)
                                        for i in string.gmatch(input2, '([^,]+)') do
                                            table.insert(settingsinputtable, i)
                                        end
                                        --print(input)
                                        addsettings(selitem, settingsinputtable)
                                    end
                                    if type(inptesset) ~= "table" then
                                        addsettings(selitem, input)
                                    end
                                    resetmenu()
                                    --print(chngsel)
                                    chngsel = 0
                                end
        
                            else
                                print(">  "..prntset)
                            end
                        else
                            print("   "..prntset)
                        end

                    end

                end
            end
        end
        function onsel(menu, selected)
            menu[selected].handler()
        end
    
        function onkeypress(key, menu, selected)
            if key == keys.enter or key == keys.space then
                if chngsel == 0 then
                    onsel(menu, selected)
                end
               -- if chngsel == 1 and (key == keys.enter or key == keys.space) then
                 --   chngsel = 0
               -- end
            elseif key == keys.up or key == keys.w then
                if selitem > 1 then
                    setsoffset = setsoffset + 2
                    --setsoffset = math.floor(setsoffset)
                    selitem = selitem - 1
                end
            elseif key == keys.down or key == keys.s then
                if selitem < (#menu) then
                    setsoffset = setsoffset - 2 
                    --setsoffset = math.floor(setsoffset)
                    selitem = selitem + 1 
                end
            elseif key == keys.q then
                exit()
            end
        end
    
    while openset == 1 do
        term.setCursorPos(1, 1) 
        term.clear()
        printmenu(setmenu)
        event, key = os.pullEvent("key")
        onkeypress(key, setmenu, selitem)
    end



end




end
















    while true do






    ---------------------
    ---------------------
    ---------------------
    --CHANGE HERE START--
    ---------------------
    ---------------------
    ---------------------
    pieloc = settings.get(setmenu[4].setname)
    pieslot = tonumber(settings.get(setmenu[5].setname))





    wait_time = 60 / 72
    wait_time = wait_time / 8
    -------------------
    -------------------
    --CHANGE HERE END--
    -------------------
    -------------------


    itemlocs = {
        {itloc = {303, 69, 348, "s"}, itslot = 1},
        {itloc = {303, 66, 331, "n"}, itslot = 2},
        {itloc = {305, 65, 327, "w"}, itslot = 3}
    }
    itemlocs = {}
    itemlocss = {}
    itemlocstemp = {}
    itemlocstempfin = {}
    itemloctab = settings.get(setmenu[2].setname)
    itemslottab =settings.get(setmenu[3].setname)
    loadioffset = 0
    for i=1,#itemslottab do
        itemlocstemp = {}
        itemlocstempfin = {}
        for i2=1 + loadioffset,4 + loadioffset do
            table.insert(itemlocstemp, itemloctab[i2]) 
            --print(table.concat(itemlocstemp, ", "))
            --sleep(2)
            
        end
        loadioffset = loadioffset + 4
        table.insert(itemlocs, {itloc = itemlocstemp, itslot = tonumber(itemslottab[i])})
        table.insert(itemlocss, itemlocstempfin)
    end
--for i=1,#itemlocs do
--    print(table.concat(itemlocs[i].itloc, ", "))
--print(itemlocs[i].itloc)
--print(itemlocs[i].itslot)
--end
--sleep(5)


function cdrop(slot, crloc)
    if turtle.getItemCount(slot) ~= 0  then
        turtle.turnLeft()
        gt.goto(crloc)
        turtle.select(slot)
        while turtle.getItemCount(slot) ~= 0 do
            turtle.drop()
            term.setCursorPos(1,1)
            print("Putting: "..slot)
            if turtle.getItemCount(slot) ~= 0 then
                sleep(wait_time)
            end
        end
    end
end
                            
                        
                            
function cgrab(slot, crloc)
    if turtle.getItemCount(slot) == 0 then
        turtle.select(slot)
        gt.goto(crloc)
        while turtle.getItemCount(slot) == 0 do
            turtle.suck()
            term.setCursorPos(1,1)
            print("Getting: "..slot)
            if turtle.getItemCount(slot) == 0 then
                sleep(wait_time)
            end
        end
    end
end
    
function checkcraft(slot, cheloc)
    fullitems = 0
    for i =1,#itemlocs do
        if turtle.getItemCount(i) ~= 0 then
            fullitems = fullitems + 1
        end
        if fullitems == #itemlocs then
            term.setCursorPos(1,1)
            print("Crafting: "..slot)
            turtle.select(slot)
            turtle.craft()
            cdrop(slot, cheloc)
        end
    end
end

function getitems()
    local preslot = 1
    for i=1,#itemlocs do
        if itemlocs[i].itslot ~= nil then
            preslot = itemlocs[i].itslot
        else
            preslot = i
        end
        cgrab(preslot, itemlocs[i].itloc)
    end
end


checkcraft(pieslot, pieloc)
getitems()
checkcraft(pieslot, pieloc)
break






end
end