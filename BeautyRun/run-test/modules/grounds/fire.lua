-- 创建 火焰
local M = {}

-- 碰撞函数
local function onCollision( event )
    if ( "began" == event.phase ) then
        Runtime:dispatchEvent( { name = "changeBlood", target = "fire", Hurt = 25  } );
        Runtime:dispatchEvent( { name = "changeJump", target = "fire" } );
    end
end

-- 创建最底层的火焰
function M.new( extraGroup )
    -- fireGround1
    local fireGround1 = display.newImageRect( extraGroup, "image/ground/fire.png", screenXWidth, 50 );
    fireGround1.x = screenXCenter;
    fireGround1.y = screenYHeight - 22;
    fireGround1.name = "fire";
    -- fireGround2
    local fireGround2 = display.newImageRect( extraGroup, "image/ground/fire.png", screenXWidth, 50 );
    fireGround2.x = 1.5 * screenXWidth;
    fireGround2.y = screenYHeight - 22;
    fireGround2.name = "fire";
    local physicsShape = { -screenXCenter,  20, screenXCenter, 20, screenXCenter, 40, -screenXCenter, 40 };
    physics.addBody( fireGround1,  "static", { friction = 0, bounce = 0, shape = physicsShape } );
    physics.addBody( fireGround2,  "static", { friction = 0, bounce = 0, shape = physicsShape } );
    fireGround1:addEventListener( "collision", onCollision );
    fireGround2:addEventListener( "collision", onCollision );
    return fireGround1, fireGround2;
end

-- 底层火焰动态修改
function M.updateFireFloor( levelSpeed , fireGround1, fireGround2)
    fireGround1:translate( -levelSpeed, 0 );
    fireGround2:translate( -levelSpeed, 0 );
    if -screenXCenter >= fireGround1.x then
        fireGround1.x = fireGround1.x + 2 * screenXWidth;
    end
    if -screenXCenter >= fireGround2.x then
        fireGround2.x = fireGround2.x + 2 * screenXWidth;
    end
end

return M;