-- 创建 蓝药 道具
local M = {}

-- 碰撞函数
local function onCollision ( event )
    local object;
    if ( "began" == event.phase ) then
        if ( "bluePill" == event.target.name ) then
            object = event.target;
        else
            object = event.other;
        end
        Runtime:dispatchEvent( { name = "callbackObject", object = object } );
        Runtime:dispatchEvent( { name = "changeMagic" , target = "bluePill",  magic = 10 } );
    end
end

-- 创建 蓝药 函数
function M.new()
    -- 创建蓝药
    local  BluePill = display.newImageRect( "image/prop/bluePill.png", 38, 41 );
    BluePill.x = -100;
    -- 添加碰撞监听
    BluePill:addEventListener( "collision", onCollision );
    return BluePill;
end

return M;