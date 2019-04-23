---创建 boss
local M = {}

local function showHit( self, objectPool )
        local hit = objectPool:getObject( "hit" );
        self.parent:insert( hit );
        hit:toFront();
        transition.fadeOut( hit , { time = 500 } );
        self:setSequence( "hurt" );
        timer.performWithDelay(500 ,function ()
            self:setSequence( "comm" );
            self:play();
        end );
end

function M.showBoss( extraGroup )
    local bossOptions =
    {
        width = 128,
        height = 128,
        numFrames = 10,
        sheetContentWidth = 640,
        sheetContentHeight = 256
    };
    local bossSheet = graphics.newImageSheet( "image/boss/boss.png", bossOptions );
    local bossSprite = {
        { name = "comm", start = 1, count = 5, time = 1500, loopCount = 0 },
        { name = "trick", start = 6, count = 2, time = 100, loopCount = 1 },
        { name = "hurt", start = 8, count = 1, time = 1000, loopCount = 1 },
        { name = "win", start = 9, count = 2, time = 1000, loopCount = 0 },
    };
    local boss = display.newSprite( extraGroup ,bossSheet, bossSprite );
    boss.x = screenXWidth * 0.9;
    boss.y = screenYHeight * 0.35;
    boss.blood = 500;
    boss.name = "boss";
    boss.trick = false;  -- 是否在释放大招
    boss.show = false;  -- 是否显示
    boss.showHit = showHit;  -- 是否被攻击
    boss.width = boss.contentWidth * 1.5;
    boss.height = boss.contentHeight * 1.5;
    boss.xScale = 1.2;
    boss.yScale = 1.2;
    boss:play();
    physics.addBody( boss, "static", { friction=0,isSensor = true } );
    boss.gravityScale = 0
    boss.isSleepingAllowed = false;
    return boss;
end

-- 显示bossBar信息
function M.showBossInfo( extraGroup )
    -- 血量文本
    local bossBloodText = display.newText(  extraGroup, 100000 ,0, 0, "Arial", 20 );
    bossBloodText.anchorX = 0.5;
    bossBloodText.anchorY = 0.5;
    bossBloodText.x = screenXCenter;
    bossBloodText.y = screenYHeight - 25;
    bossBloodText:setFillColor( 1, 222/255, 180/255 );
    bossBloodText:toBack();

    -- boss头像
    local bossHead = display.newImageRect( extraGroup, "image/boss/bossHead.png" ,94,  99);
    bossHead.anchorX = 0;
    bossHead.anchorY = 1;
    bossHead.x = 0;
    bossHead.y = screenYHeight;
    bossHead:toBack();

    -- boss血量条
    local bossBloodScrip = display.newImageRect( extraGroup, "image/other/bloodBar.png", screenXWidth * 1.3, screenYHeight * 0.045 );
    bossBloodScrip.anchorX = 0;
    bossBloodScrip.anchorY = 1;
    bossBloodScrip.x = -40;
    bossBloodScrip.y = screenYHeight - 5;
    bossBloodScrip:toBack();

    -- boss血量条框
    local bossBloodBar = display.newImageRect( extraGroup,"image/other/barBox.png",screenXWidth * 1.3, screenYHeight * 0.06);
    bossBloodBar.anchorX = 0;
    bossBloodBar.anchorY = 1;
    bossBloodBar.x = -40;
    bossBloodBar.y = screenYHeight;
    bossBloodBar:toBack();
    return bossBloodText, bossBloodScrip;
end

return M;
