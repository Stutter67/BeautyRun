local sections = require( "modules.section.sectionData" );
local ObjectPoolFile = require( "modules.ObjectPool")
-- 创建场景
local createSection = {}

local lastSection = 0;  -- 创建的标识符，主要用于区别两个场景

-- 创建 场景 的函数
function createSection.createSection( objectGroup )
    local objectPool = ObjectPoolFile.getObjectPool();
    -- 创建随机数.使相邻的两个场景不会重复
    local sectInt = mR(1,#sections );
    if sectInt == lastSection then
        sectInt = mR(1,#sections );
    end
    lastSection = sectInt;

    -- 读取配置参数文件的配置数据,创建场景
    -- 平台
    for i = 1, #sections[ sectInt ][ "platforms" ] do
        local object = sections[ sectInt ][ "platforms" ][ i ];
        local platform =  objectPool:getObject( object[ "type" ].."" );
        platform.alpha = 1;
        platform.anchorX = 0.5;
        platform.anchorY = 0;
        platform.x = object[ "position" ][ 1 ] + ( 1024 * ( object[ "screen" ] ) );
        platform.y = object[ "position" ][ 2 ];               -- 此为图片文件的Y轴坐标位置
        platform.actY = platform.y + object[ "nilHeight" ];   -- 此为实际与玩家角色发生碰撞的位置
        platform.name = "platform";
        platform.type =  object[ "type" ];
        platform.width = object[ "widthHeight"][ 1 ];
        platform.height = object[ "widthHeight"][ 2 ];
        local rad = ( platform.width * 0.5 ) - 2;
        local height = ( platform.height * 0.5 ) - object[ "nilHeight" ];
        local physicsShape = { -rad, -height, rad, -height, -rad, -height + 50, rad,-height + 50 };  --设置实际的物理碰撞范围，需要扣除树木这种不会发生碰撞的高度
        physics.addBody( platform, "static", { friction = 0.2, bounce = 0, shape = physicsShape } );
        objectGroup:insert( platform );
    end

    -- 金币
    for i = 1, #sections[ sectInt ][ "golds" ] do
        local object = sections[ sectInt ][ "golds" ][ i ];
        local gold = objectPool:getObject( "gold" );
        gold.alpha = 1;
        gold.x = object[ "position" ][ 1 ] + ( 1024 * ( object[ "screen" ] ) );
        gold.y = object[ "position" ][ 2 ];
        gold.name = "gold";
        physics.addBody( gold, "static", { isSensor = true } );
        objectGroup:insert( gold )
    end

    -- 道具
    for i =1, #sections[ sectInt ][ "Props" ] do
        local object = sections[ sectInt ][ "Props" ][ i ];
        local prop = objectPool:getObject( object[ "type" ] );
        prop.alpha = 1;
        prop.x = object[ "position" ][ 1 ] + ( 1024 * ( object[ "screen" ] ) );
        prop.y = object[ "position" ][ 2 ];
        prop.name = object[ "type" ];
        local rad = ( prop.width * 0.5 ) - 8;
        local height = ( prop.height * 0.5 ) - 8
        local physicsShape = { -rad, -height, rad, -height, rad, height, -rad, height };
        physics.addBody( prop, "static", { isSensor = true, shape = physicsShape } );
        objectGroup:insert( prop );
    end
end

return createSection;