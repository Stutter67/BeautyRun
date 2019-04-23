-- 创建 平台 场景
local M = {}

-- 碰撞函数
local function onCollision( event )
    if "began" == event.phase then
        Runtime:dispatchEvent( { name = "changeJump" , target = "platform" } );
    end
end

-- 创建 平台（5种类型） 函数
-- 平台对象额外包含一个属性：mainName,这是由于在对象池中需要维持这5中类型对象的区别，但是在游戏程序中将这5种对象视为完全相同的对象。
-- mainName:用于在对象池中区分类型
-- name: 用于在游戏中识别
function M.newPlatformComm()
    local platform = display.newImageRect( "image/ground/platformComm.png", 450, 236 );
    platform.alpha = 0;
    platform.mainName = "Comm"
    platform:addEventListener( "collision", onCollision );
    return platform;
end

function M.newPlatformLarge()
    local platform = display.newImageRect( "image/ground/platformLarge.png", 452, 226 );
    platform.alpha = 0;
    platform.mainName = "Large";
    platform:addEventListener( "collision", onCollision );
    return platform;
end
 
function M.newPlatformMed()
    local platform = display.newImageRect( "image/ground/platformMed.png", 290, 290 );
    platform.alpha = 0;
    platform.mainName = "Med";
    platform:addEventListener( "collision", onCollision );
    return platform;
end

function M.newPlatformSmall()
    local platform = display.newImageRect( "image/ground/platformSmall.png", 198, 384 );
    platform.alpha = 0;
    platform.mainName = "Small";
    platform:addEventListener( "collision", onCollision );
    return platform;
end

function M.newPlatformTiny()
    local platform = display.newImageRect( "image/ground/platformTiny.png", 136, 106 );
    platform.alpha = 0;
    platform.mainName = "Tiny"
    platform:addEventListener( "collision", onCollision );
    return platform;
end

return M;