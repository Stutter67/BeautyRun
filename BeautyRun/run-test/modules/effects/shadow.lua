-- 创建 人物光影 效果
local M = {}

-- 创建 图像
function M.new()
    local shadow = display.newImageRect("image/role/roleShadow.png", 52 , 65 );
    shadow.anchorX = 0.5;
    shadow.anchorY = 0.5;
    shadow.alpha = 0;
    shadow.name = "shadow";
    return shadow;
end

-- 光影跟随
function M.updateShadow( player, objectPool, extraGroup )
    local shadow = objectPool:getObject( "shadow" );
    shadow.x = player.x - 45;
    shadow.y = player.y ;
    shadow.alpha = 1;
    shadow.xScale = player.xScale;
    shadow.yScale = player.yScale;
    shadow.rotation = player.rotation;
    extraGroup:insert( shadow );
    transition.to(  shadow , { time = 400, x = player.x - 200, y = player.y, alpha = 0, onComplete = function()
       objectPool:putObject( shadow )
    end })
end

return M;