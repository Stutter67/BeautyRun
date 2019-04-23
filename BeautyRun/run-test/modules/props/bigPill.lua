
-- 创建 变大药 道具
local M = {}

-- 碰撞函数
local function onCollision ( event )
    local object;
    if ( "began" == event.phase ) then
        if ( "bigPill" == event.target.name ) then
            object = event.target;
        else
            object = event.other;
        end
        Runtime:dispatchEvent( { name = "callbackObject", object = object } );
        Runtime:dispatchEvent( { name = "changePlayerStatus" , target = "bigPill", time = 8000 } );
    end
end

-- 创建 变大药 函数
function M.new()
    -- 创建变大药
    local bigPillOptions =
    {
        width = 50,
        height = 54,
        numFrames = 4,
        sheetContentWidth = 200,
        sheetContentHeight = 54,
    }
    local bigPillSheet = graphics.newImageSheet( "image/prop/bigPill.png", bigPillOptions );
    local bigPillSprite = { { start = 1, count = 4, time = 500 } };
    local BigPill = display.newSprite( bigPillSheet, bigPillSprite );
    BigPill.x = -100;
    BigPill:play();
    physics.addBody( BigPill,  "static", { friction = 0, bounce = 0 } );
    -- 添加碰撞监听
    BigPill:addEventListener( "collision", onCollision );
    return BigPill;
end

return M;