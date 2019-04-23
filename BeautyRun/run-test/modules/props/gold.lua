-- 创建 金币 函数
local M = {}

-- 碰撞函数
local function onCollision ( event )
    local object;
    if ( "began" == event.phase ) then
        if ( "gold" == event.target.name ) then
            object = event.target;
        else
            object = event.other;
        end
        Runtime:dispatchEvent( { name = "callbackObject", object = object } );
        Runtime:dispatchEvent( { name = "changeGold" , target = "gold", Score = 10 } );
    end
end

local function moveGold( self, player )
    local disX = self.x - player.x;
    local disY = self.y - player.y;
    if disX < 700 then
        if disX > 0  then
            if disX > 150 then
                self:translate( -15, 0 );
            else
                self:translate( -12, 0 );
            end
        else
            self:translate( 15, 0 );
        end
        if disY > 0 then
            if disY > 80 then
                self:translate( 0, -7 );
            else
                self:translate( 0, -20 );
            end
        else
            self:translate( 0, 7 );
        end
    end
end

-- 创建金币函数
function M.new()
    -- 创建金币
    local Gold = display.newImageRect( "image/prop/gold.png", 20, 20 );
    Gold.alpha = 0;
    Gold.moveGold = moveGold;
    -- 添加碰撞监听
    Gold:addEventListener( "collision", onCollision );
    return Gold;
end

return M;