-- 创建 红药 道具
local M = {}

-- 碰撞函数
local function onCollision ( event )
    local object;
    if ( "began" == event.phase ) then
        if ( "redPill" == event.target.name ) then
            object = event.target;
        else
            object = event.other;
        end
        Runtime:dispatchEvent( { name = "callbackObject", object = object } );
        Runtime:dispatchEvent( { name = "changeBlood" , target = "redPill",  Blood = 100 } );
    end
end

-- 创建 红药 函数
function M.new()
    -- 创建红药
    local  RedPill = display.newImageRect( "image/prop/redPill.png", 38, 41 );
    RedPill.x = -100;
    -- 添加碰撞监听
    RedPill:addEventListener( "collision", onCollision );
    return RedPill;
end

return M;