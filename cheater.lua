function LargeBuilding:createCheatUI()
    self._cheatLayer = display.newColorLayer(cc.c4b(0,0,0,255)):addto(UIMgr:currentScene():rootForEffect()):setTouchSwallowEnabled(true):zorder(999)
    TipsMgr:addTips("让我们来作弊吧！")

    local characters = DataMgr:getCharacterModelList()
    local charIndex = 1
    -- local character = characters[charIndex]

    local equipListData = characters[charIndex]:getEquipModelList()
    local equipQualityArr = {}
    -- dump(characters[charIndex]:getEquipModelList())

    local function getCharById (id)
       return CharacterConfigMgr:getInstance():getConfigById(id)
    end

    local baseDataY = display.height - _adjust(50)
    local skillDataY = baseDataY - 170
    local equipDataY = baseDataY - 305

    local baseLeftX = 400

    local qualityName = {"白-D","绿-C","绿-C+","蓝-B","蓝-B+","蓝-B++","紫-A","紫-A+","紫-A++","紫-AA","橙-S","橙-S+","橙-S++","橙-SS","橙-SSS","红-X"}
    local qualityCounter = {} -- char,equip 1~6 equipListData[1]:quality()
    qualityCounter.charQual = characters[charIndex]:quality()
    for i=2,7 do
        qualityCounter["equipQual"..(i-1)] = equipListData[i-1]:quality()
    end
    qualityCounter.maxQual = 16
    qualityCounter.shiftCounter = function (qName)
        if qualityCounter[qName] == qualityCounter.maxQual then
            qualityCounter[qName] = 1
        else
            qualityCounter[qName] = qualityCounter[qName] + 1
        end
        self.gzUpdataData()
    end
    -- qualityCounter.shiftCounter("equipQual1") 

    local function setQualityNameByNumber (qual)
        return qualityName[qual]
    end

    display.newTTFLabel({text="=================================== 基本数据 ===================================", size=20, color=cc.c3b(0,238,238)}):anchor(0, 0.5):addTo(self._cheatLayer):pos(baseLeftX-275, baseDataY)

    local nameLabel = display.newTTFLabel({text="【名字】："..getCharById(characters[charIndex]:characterId()):name(), size=20, color=cc.c3b(0,238,238)}):anchor(0, 0.5):addTo(self._cheatLayer):pos(baseLeftX-250, baseDataY - 30)
    local IDLabel = display.newTTFLabel({text=" --> ID: "..characters[charIndex]:characterId(), size=20, color=cc.c3b(0,238,238)}):anchor(0, 0.5):addTo(self._cheatLayer):pos(baseLeftX-250+150, baseDataY - 30)
    -------------------------------------------------------------------
    local LvLabel = display.newTTFLabel({text="【等级】：              "..characters[charIndex]:level(), size=20, color=cc.c3b(0,238,238)}):anchor(0, 0.5):addTo(self._cheatLayer):pos(baseLeftX-250, baseDataY - 55)
    local lvEditBtnArr = {-10,-5,-1,0,0,1,5,10}
    for i=1,#lvEditBtnArr do
        local trend = "+"
        if lvEditBtnArr[i]<0 then
            trend = "-"
        end
        if lvEditBtnArr[i] ~= 0 then
            utils:createTestBtn({name=trend..math.abs(lvEditBtnArr[i]), pos=cc.p(baseLeftX-250+100+(i-1)*37, baseDataY - 65), size=cc.size(30, 20), callFunc=function()

            end, parent=self._cheatLayer})    
        end    
    end
    -------------------------------------------------------------------
    local GdLabel = display.newTTFLabel({text="【星级】：     "..characters[charIndex]:grade(), size=20, color=cc.c3b(0,238,238)}):anchor(0, 0.5):addTo(self._cheatLayer):pos(baseLeftX-250, baseDataY - 80)
    utils:createTestBtn({name="--", pos=cc.p(baseLeftX-250+100, baseDataY - 90), size=cc.size(30, 20), callFunc=function()

    end, parent=self._cheatLayer})
    utils:createTestBtn({name="++", pos=cc.p(baseLeftX-250+100+37+37, baseDataY - 90), size=cc.size(30, 20), callFunc=function()

    end, parent=self._cheatLayer}) 
    -------------------------------------------------------------------
    local QyLabel = display.newTTFLabel({text="【品质】："..characters[charIndex]:quality(), size=20, color=cc.c3b(0,238,238)}):anchor(0, 0.5):addTo(self._cheatLayer):pos(baseLeftX-250, baseDataY - 105)

    local QyNameLabel = display.newTTFLabel({text="  --> "..setQualityNameByNumber(characters[charIndex]:quality()), size=20, color=cc.c3b(0,238,238)}):anchor(0, 0.5):addTo(self._cheatLayer):pos(baseLeftX-250+100, baseDataY - 105)
    utils:createTestBtn({name=">>", pos=cc.p(baseLeftX-250+100+37*4, baseDataY - 115), size=cc.size(30, 20), callFunc=function()
        qualityCounter.shiftCounter("charQual")
    end, parent=self._cheatLayer}) 
    -------------------------------------------------------------------
    local ApLabel = display.newTTFLabel({text="【AP点】："..characters[charIndex]:actionPoint(), size=20, color=cc.c3b(0,238,238)}):anchor(0, 0.5):addTo(self._cheatLayer):pos(baseLeftX-250, baseDataY - 130)


    display.newTTFLabel({text="=================================== 技能数据 ===================================", size=20, color=cc.c3b(0,238,238)}):anchor(0, 0.5):addTo(self._cheatLayer):pos(baseLeftX-275, skillDataY)
    -- dump(characters[charIndex]:getSkillModelList()["warSkillEnergy"]:skillId())
    local function getSkillIdBySpName (str)
        if not characters[charIndex]:getSkillModelList()[str] then
            return "NuLL"
        end
        return characters[charIndex]:getSkillModelList()[str]:skillId()
    end
    -- dump (skillList)
    local skillLabel_1 = display.newTTFLabel({text="【怒气技】："..getSkillIdBySpName("warSkillEnergy"), size=20, color=cc.c3b(0,238,238)}):anchor(0, 0.5):addTo(self._cheatLayer):pos(baseLeftX-250, skillDataY - 30)
    local skillLabel_2 = display.newTTFLabel({text="【主动技】："..getSkillIdBySpName("warSkillAuto"), size=20, color=cc.c3b(0,238,238)}):anchor(0, 0.5):addTo(self._cheatLayer):pos(baseLeftX+50+100, skillDataY - 30)

    local skillLabel_3 = display.newTTFLabel({text="【登舰技】："..getSkillIdBySpName("warSkillDuel"), size=20, color=cc.c3b(0,238,238)}):anchor(0, 0.5):addTo(self._cheatLayer):pos(baseLeftX-250, skillDataY - 55)
    local skillLabel_4 = display.newTTFLabel({text="【战术技】："..getSkillIdBySpName("warSkillPassiveAttr"), size=20, color=cc.c3b(0,238,238)}):anchor(0, 0.5):addTo(self._cheatLayer):pos(baseLeftX+50+100, skillDataY - 55)

    local skillLabel_5 = display.newTTFLabel({text="【被动技】："..getSkillIdBySpName("warSkillPassiveType"), size=20, color=cc.c3b(0,238,238)}):anchor(0, 0.5):addTo(self._cheatLayer):pos(baseLeftX-250, skillDataY - 80)
    local skillLabel_6 = display.newTTFLabel({text="【被动技】："..getSkillIdBySpName("warSkillPassiveSelf"), size=20, color=cc.c3b(0,238,238)}):anchor(0, 0.5):addTo(self._cheatLayer):pos(baseLeftX+50+100, skillDataY - 80)

    local skillLabel_7 = display.newTTFLabel({text="【被动技】："..getSkillIdBySpName("warSkillPassiveRing"), size=20, color=cc.c3b(0,238,238)}):anchor(0, 0.5):addTo(self._cheatLayer):pos(baseLeftX-250, skillDataY - 105)

    display.newTTFLabel({text="=================================== 装备数据 ===================================", size=20, color=cc.c3b(0,238,238)}):anchor(0, 0.5):addTo(self._cheatLayer):pos(baseLeftX-275, equipDataY)

    local equipLabel_1 = display.newTTFLabel({text="【机炮】："..equipListData[1]:equipId().."->Lv."..equipListData[1]:level().."->"..setQualityNameByNumber(equipListData[1]:quality()), size=20, color=cc.c3b(0,238,238)}):anchor(0, 0.5):addTo(self._cheatLayer):pos(baseLeftX-250, equipDataY - 30)
    utils:createTestBtn({name=">>", pos=cc.p(baseLeftX-250+37*9, equipDataY - 40), size=cc.size(30, 20), callFunc=function()
        qualityCounter.shiftCounter("equipQual1")
    end, parent=self._cheatLayer}) 
    local equipLabel_2 = display.newTTFLabel({text="【装甲】："..equipListData[2]:equipId().."->Lv."..equipListData[1]:level().."->"..setQualityNameByNumber(equipListData[1]:quality()), size=20, color=cc.c3b(0,238,238)}):anchor(0, 0.5):addTo(self._cheatLayer):pos(baseLeftX+50+100, equipDataY - 30)
    utils:createTestBtn({name=">>", pos=cc.p(baseLeftX+150+37*9, equipDataY - 40), size=cc.size(30, 20), callFunc=function()
        qualityCounter.shiftCounter("equipQual2")
    end, parent=self._cheatLayer}) 
    local equipLabel_3 = display.newTTFLabel({text="【导航】："..equipListData[3]:equipId().."->Lv."..equipListData[1]:level().."->"..setQualityNameByNumber(equipListData[1]:quality()), size=20, color=cc.c3b(0,238,238)}):anchor(0, 0.5):addTo(self._cheatLayer):pos(baseLeftX-250, equipDataY - 55)
    utils:createTestBtn({name=">>", pos=cc.p(baseLeftX-250+37*9, equipDataY - 65), size=cc.size(30, 20), callFunc=function()
        qualityCounter.shiftCounter("equipQual3")
    end, parent=self._cheatLayer})
    local equipLabel_4 = display.newTTFLabel({text="【操控】："..equipListData[4]:equipId().."->Lv."..equipListData[1]:level().."->"..setQualityNameByNumber(equipListData[1]:quality()), size=20, color=cc.c3b(0,238,238)}):anchor(0, 0.5):addTo(self._cheatLayer):pos(baseLeftX+50+100, equipDataY - 55)
    utils:createTestBtn({name=">>", pos=cc.p(baseLeftX+150+37*9, equipDataY - 65), size=cc.size(30, 20), callFunc=function()
        qualityCounter.shiftCounter("equipQual4")
    end, parent=self._cheatLayer})
    local equipLabel_5 = display.newTTFLabel({text="【引擎】："..equipListData[5]:equipId().."->Lv."..equipListData[1]:level().."->"..setQualityNameByNumber(equipListData[1]:quality()), size=20, color=cc.c3b(0,238,238)}):anchor(0, 0.5):addTo(self._cheatLayer):pos(baseLeftX-250, equipDataY - 80)
    utils:createTestBtn({name=">>", pos=cc.p(baseLeftX-250+37*9, equipDataY - 90), size=cc.size(30, 20), callFunc=function()
        qualityCounter.shiftCounter("equipQual5")
    end, parent=self._cheatLayer})
    local equipLabel_6 = display.newTTFLabel({text="【核晶】："..equipListData[6]:equipId().."->Lv."..equipListData[1]:level().."->"..setQualityNameByNumber(equipListData[1]:quality()), size=20, color=cc.c3b(0,238,238)}):anchor(0, 0.5):addTo(self._cheatLayer):pos(baseLeftX+50+100, equipDataY - 80)
    utils:createTestBtn({name=">>", pos=cc.p(baseLeftX+150+37*9, equipDataY - 90), size=cc.size(30, 20), callFunc=function()
        qualityCounter.shiftCounter("equipQual6")
    end, parent=self._cheatLayer})
    -------------------------------------------------------------------
    self.gzUpdataData = function ()
        nameLabel:setString("【名字】："..getCharById(characters[charIndex]:characterId()):name());
        IDLabel:setString(" --> ID: "..characters[charIndex]:characterId());

        LvLabel:setString("【等级】：              "..characters[charIndex]:level());
        GdLabel:setString("【星级】：     "..characters[charIndex]:grade());
        -- QyLabel:setString("【品质】："..characters[charIndex]:quality());
        -- QyNameLabel:setString(" --> "..setQualityNameByNumber(characters[charIndex]:quality()));
        QyLabel:setString("【品质】："..qualityCounter["charQual"]);
        QyNameLabel:setString(" --> "..setQualityNameByNumber(qualityCounter["charQual"]));
        ApLabel:setString("【AP点】："..characters[charIndex]:actionPoint());

        skillLabel_1:setString("【怒气技】："..getSkillIdBySpName("warSkillEnergy"));
        skillLabel_2:setString("【主动技】："..getSkillIdBySpName("warSkillAuto"));
        skillLabel_3:setString("【登舰技】："..getSkillIdBySpName("warSkillDuel"));
        skillLabel_4:setString("【战术技】："..getSkillIdBySpName("warSkillPassiveAttr"));
        skillLabel_5:setString("【被动技】："..getSkillIdBySpName("warSkillPassiveType"));
        skillLabel_6:setString("【被动技】："..getSkillIdBySpName("warSkillPassiveSelf"));
        skillLabel_7:setString("【被动技】："..getSkillIdBySpName("warSkillPassiveRing"));

        equipListData = characters[charIndex]:getEquipModelList()
        equipLabel_1:setString("【机炮】："..equipListData[1]:equipId().."->Lv."..equipListData[1]:level().."->"..setQualityNameByNumber(qualityCounter["equipQual"..1]));
        equipLabel_2:setString("【装甲】："..equipListData[2]:equipId().."->Lv."..equipListData[2]:level().."->"..setQualityNameByNumber(qualityCounter["equipQual"..2]));
        equipLabel_3:setString("【导航】："..equipListData[3]:equipId().."->Lv."..equipListData[3]:level().."->"..setQualityNameByNumber(qualityCounter["equipQual"..3]));
        equipLabel_4:setString("【操控】："..equipListData[4]:equipId().."->Lv."..equipListData[4]:level().."->"..setQualityNameByNumber(qualityCounter["equipQual"..4]));
        equipLabel_5:setString("【引擎】："..equipListData[5]:equipId().."->Lv."..equipListData[5]:level().."->"..setQualityNameByNumber(qualityCounter["equipQual"..5]));
        equipLabel_6:setString("【核晶】："..equipListData[6]:equipId().."->Lv."..equipListData[6]:level().."->"..setQualityNameByNumber(qualityCounter["equipQual"..6]));
        for i=1,6 do
            equipQualityArr[i] = qualityCounter["equipQual"..i]
        end
    end

    utils:createTestBtn({name="换人", pos=cc.p(display.width - _adjust(100)-100, display.height - _adjust(75)), size=cc.size(50, 30), callFunc=function()
        -- charIndex = 2
        if charIndex == #characters then
            charIndex = 1
        else
            charIndex = charIndex + 1
        end
        self.gzUpdataData()
    end, parent=self._cheatLayer})

    local param = {}



    utils:createTestBtn({name="发送", pos=cc.p(display.width - _adjust(100), display.height - _adjust(50)-500), size=cc.size(70, 35), callFunc=function()
        -- local config = TesterConfigMgr:getInstance():getConfigById(1)
            param.charID = characters[charIndex]:characterId()
            param.level = characters[charIndex]:level()
            param.grade = characters[charIndex]:grade()
            param.quality = qualityCounter["charQual"]
            param.actionPoint = 100
            param.warSkillList = {}
            -- param.warSkillList = characters[charIndex]:getSkillModelList()
            for k,v in pairs(characters[charIndex]:getSkillModelList()) do
                param.warSkillList[k] = {}
                param.warSkillList[k].skillId = v:skillId()
                param.warSkillList[k].level = v:level()
            end
            param.equipList = {}
            for k,v in pairs(equipListData) do
                -- dump (v)
                param.equipList[k] = {}
                param.equipList[k].equipId = v:equipId()
                param.equipList[k].level = v:level()
                param.equipList[k].quality = equipQualityArr[k]
            end

            -- dump (param)
            NetClient:sendMsg(ic.MSGTYPE_USER_GM_COMMAND, {command="upgrade", param1 = json.encode(param)})
    end, parent=self._cheatLayer})

    utils:createTestBtn({name="返回", pos=cc.p(display.width - _adjust(100), display.height - _adjust(50)), size=cc.size(70, 35), callFunc=function()
        dump ("Txt name "..nameLabel:getString())
        self._cheatLayer:removeFromParent()
        self._cheatLayer = nil
    end, parent=self._cheatLayer})
end

function LargeBuilding:createDebugUI()
    self._debugLayer = display.newColorLayer(cc.c4b(0,0,0,255)):addto(UIMgr:currentScene():rootForEffect()):setTouchSwallowEnabled(true):zorder(999)

    local editBox = ccui.EditBox:create(cc.size(_adjust(240), _adjust(40)) ,display.newScale9Sprite() ,nil,nil )
    editBox:setFontName(DEF_TTF_FONT)
    editBox:setFontSize(_adjust(24))
    editBox:setFontColor(cc.c4b(0, 0, 0, 255))
    editBox:setMaxLength(50)
    editBox:setPosition(cc.p(display.width/2, display.height/2))
    self._debugLayer:addChild(editBox)
    editBox:setPlaceHolder("command:")
    editBox:setPlaceholderFontColor(cc.c3b(80,80,80))
    editBox:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)

    local function execute(str)
        if GMCommand:execute(str) then
            utils:runFuncDelayTime(0.1, function()
                if self._debugLayer then
                    self._debugLayer:removeFromParent()
                    self._debugLayer = nil
                end
            end)
        else
            TipsMgr:addTips("尚未支持该命令，请大胆的向程序GG提需求吧")            
        end
    end

    editBox:registerScriptEditBoxHandler(function(eventName, sender)
        if eventName == "began" then            
        elseif eventName == "ended" then            
        elseif eventName == "return" then
            execute(sender:getText())
        elseif eventName == "changed" then

        end
    end)

    display.newSprite("#scale9_qihuashi_zonglandiceng.png"):addto(self._debugLayer):anchor(0.5, 0.5):pos(display.width/2, display.height/2)

    utils:createTestBtn({name="关闭", pos=cc.p(display.width - _adjust(150), display.height - _adjust(100)), size=cc.size(70, 35), callFunc=function()
        self._debugLayer:removeFromParent()
        self._debugLayer = nil
    end, parent=self._debugLayer})

    display.newTTFLabel({text="主人，请输入命令", size=20, color=cc.c3b(255,0,0)}):anchor(0.5, 0.5):addTo(self._debugLayer):pos(display.width/2, display.height/2 + _adjust(60))
    utils:createTestBtn({name="确定", pos=cc.p(display.width*2/3, display.height/2 - _adjust(17)), size=cc.size(70, 35), callFunc=function()
        execute(editBox:getText())
    end, parent=self._debugLayer})

    display.newTTFLabel({text='提示：当前支持的命令有：gem， vip， gold， item， character， fps，level。'
        ..'\n使用举例：'
        ..'\n设置金币数量为100，输入"gold,100"，点击确定；'
        ..'\n添加1个id为1012的道具，输入 "item,1012,1"，点击确定；'
        ..'\n开启/关闭fps ，输入"fps"，点击确定；'
        ..'\n刷新玩家数据：gm后台改玩家数据后，输入refreshuserinfo 或 rfu 后即可刷新玩家数据；',

        size=20, 
        color=cc.c3b(0, 255,0), 
        align = cc.TEXT_ALIGNMENT_LEFT,
        valign = cc.VERTICAL_TEXT_ALIGNMENT_BOTTOM, 
        dimensions = cc.size(display.width - _adjust(100), 400)}):anchor(0.5, 0):addTo(self._debugLayer):pos(display.width/2, _adjust(50))


        utils:createTestBtn({name="顾钊专用", pos=cc.p(_adjust(150), display.height - _adjust(100)), size=cc.size(70, 35), callFunc=function()

            -- param = {
            -- charID = ,
            -- level = ,
            -- grade = ,
            -- actionPoint = ,
            -- warSkillList = {
            --     EnegySkill = {
            --         skillId = ,
            --         level =
            --     }
            -- },
            -- equipList = {
            --     {
            --         equipId = ,
            --         level = ,
            --         quality = ,

            --     },
            -- }
        -- }

        local config = TesterConfigMgr:getInstance():getConfigById(1) 

        -- dump(config:getEquipList())
        -- dump(config:getWarSkillList())

        local param = {}

        param["charID"] = config:charID()
        param["level"] = config:level()
        param["grade"] = config:grade()
        param["actionPoint"] = config:actionPoint()

        param["warSkillList"] = config:getWarSkillList()
        param["equipList"] = config:getEquipList()

        -- dump(param)
        
        -- dump(json.encode(param))


        -- NetClient:sendMsg(ic.MSGTYPE_TEST_UPGRADE,{param=json.encode(param)})

        NetClient:sendMsg(ic.MSGTYPE_USER_GM_COMMAND, {command="upgrade", param1=json.encode(param)})

    end, parent=self._debugLayer})

end
