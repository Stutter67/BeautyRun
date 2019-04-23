-- 创建 加速 道具
local M = {}

-- 碰撞函数
local function onCollision ( event )
    local object;
    if ( "began" == event.phase ) then
        if ( "star" == event.target.name ) then
            object = event.target;
        else
            object = event.other;
        end
        Runtime:dispatchEvent( { name = "callbackObject", object = object } );
        Runtime:dispatchEvent( { name = "changePlayerStatus", target = "star",  time = 6000 } );
        Runtime:dispatchEvent( { name = "changeJump", target = "star" } );
    end
end

-- 创建 加速 函数
function M.new()
    -- 创建 加速
    local starOptions =
    {
        width = 127,
        height = 108,
        numFrames = 4,
        sheetContentWidth = 508,
        sheetContentHeight = 108,
    };
    local starSheet = graphics.newImageSheet( "image/prop/star.png", starOptions );
    local starSprite = { { start = 1, count = 4, time = 500 } };
    local Star = display.newSprite( starSheet, starSprite );
    Star.x = -100;
    Star.width = Star.contentWidth * 0.4;
    Star.height = Star.contentHeight * 0.4;
    Star.xScale = 0.3;
    Star.yScale = 0.3;
    Star:play();
    -- 添加碰撞监听
    Star:addEventListener( "collision", onCollision );
    return Star;
end

return M;