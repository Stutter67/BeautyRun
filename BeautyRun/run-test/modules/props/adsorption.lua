-- 创建 吸收 道具
local M = {}

-- 碰撞函数
local function onCollision ( event )
    local object;
    if ( "began" == event.phase ) then
        if ( "adsorption" == event.target.name ) then
            object = event.target;
        else
            object = event.other;
        end
        Runtime:dispatchEvent( { name = "callbackObject", object = object } );
        Runtime:dispatchEvent( { name = "changePlayerStatus" , target = "adsorption", time = 15000 } );
    end
end

-- 创建 吸收 道具
function M.new()
    -- 创建吸收图像
    local adsorptionOptions =
    {
        width = 50,
        height = 54,
        numFrames = 4,
        sheetContentWidth = 200,
        sheetContentHeight = 54,
    };
    local adsorptionSheet = graphics.newImageSheet( "image/prop/adsorption.png", adsorptionOptions );
    local adsorptionSprite = { { start = 1, count = 4, time = 800 } };
    local Adsorption = display.newSprite( adsorptionSheet, adsorptionSprite );
    Adsorption.xScale = 1.5;
    Adsorption.yScale = 1.5;
    Adsorption.x = -100;
    Adsorption:play();
    physics.addBody( Adsorption,  "static", { friction = 0, bounce = 0 } );
    -- 添加局部碰撞监听
    Adsorption:addEventListener( "collision", onCollision );
    return Adsorption;
end

return M;