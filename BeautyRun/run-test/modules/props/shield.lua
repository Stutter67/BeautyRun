-- 创建 盾牌 道具
local M = {}

-- 盾牌跟随人物角色
function M.showShield( player, objectPool )
    local shield = objectPool:getObject( "shield" );
    shield.name = "shield"
    shield.alpha = 1;
    player.parent:insert( shield );
    shield:toFront();
    timer.performWithDelay(10, function ( event )
        shield.x = player.x;
        shield.y = player.y;
        if event.count == 500 then
            player.invincible = false;
            objectPool:putObject( shield );
            timer.cancel( event.source );
        end
    end, -1  );
end

-- 碰撞函数
local function onCollision ( event )
    local object;
    if ( "began" == event.phase ) then
        if ( "shield" == event.target.name ) then
            object = event.target;
        else
            object = event.other;
        end
        Runtime:dispatchEvent( { name = "callbackObject", object = object } );
        Runtime:dispatchEvent( { name = "changePlayerStatus" , target = "shield", obj = object, time = 5000 } );

    end
end


-- 创建 盾牌 函数
function M.new()
    local shieldOptions =
    {
        width = 88,
        height = 116,
        numFrames = 7,
        sheetContentWidth = 616,
        sheetContentHeight = 116,
    };
    local shieldSheet = graphics.newImageSheet( "image/skill/shield.png", shieldOptions );
    local shieldSprite = { { start = 1, count = 7, time = 500 } };
    local Shield = display.newSprite( shieldSheet, shieldSprite );
    Shield.x = -100;
    Shield:play();
    physics.addBody( Shield,  "static", { friction = 0, bounce = 0 } );
    -- 添加碰撞监听
    Shield:addEventListener( "collision", onCollision );
    return Shield;
end

return M;