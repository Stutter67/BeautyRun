-- 创建 飞剑 道具
local M = {}

-- 碰撞函数
local function onCollision ( event )
    if ( "began" == event.phase ) then
        local object;
        if "sword" == event.target.name then
           object = event.target;
        else
            object =event.other;
        end
        local scale = mR();
        local flyX =  event.x + mR( 150, 250 );
        local flyY =  event.y - mR( 150, 210 );
        local flyRota = mR( 450, 720 );
        timer.performWithDelay(1 , function ()
            physics.removeBody( object );
            transition.to( object, { time = 600, xScale = scale, yScale = scale, x = flyX, y = flyY, rotation = flyRota, onComplete = function ()
                object.xScale = 1;
                object.yScale = 1;
                object.rotation = 180;
                object.yAct = true;
                Runtime:dispatchEvent( { name = "callbackObject", object = object } )
            end; } )
        end )
        if object.trick == false then
            Runtime:dispatchEvent( { name = "changeSword", target = "sword", object = object } );
        end
        Runtime:dispatchEvent( { name = "changeBlood" , target = "sword", Hurt = mR( 20, 40 ); } );
    end
end

-- 普通攻击
local function dynamicSword( self, distanceText, player )
    -- 宝剑普通攻击
    if self and mF( distanceText.text % 20 ) == 0 and self.yAct == true  then
        physics.addBody( self, "static", { friction = 0, bounce = 0 } );
        local temp = player.y - 30;
        transition.to( self, { y = temp } );
        if( mF( distanceText.text % 200 ) == 0 and self.yAct == true ) then
            transition.cancel( self );
            self.yAct = false;
            transition.to( self, { x = - 300, time = 2500, onComplete = function ()
                self.yAct = true;
                self.finish = true;
                Runtime:dispatchEvent( { name = "callbackObject", object = self } );
            end } );
        end;
    end;
end

-- boss技能
function M.triSword ( resetSword, y , extraGroup )
    local sword1 = resetSword()
    sword1.x = screenXWidth - sword1.contentWidth * 0.5;
    sword1.y = y;
    sword1.trick = true;
    extraGroup:insert( sword1 );
    local sword2 = resetSword()
    sword2.x = sword1.x
    sword2.y = sword1.y + 60;
    sword2.trick = true;
    extraGroup:insert( sword2 );
    local sword3 = resetSword()
    sword3.x = sword1.x;
    sword3.y = sword1.y + 120;
    sword3.trick = true;
    extraGroup:insert( sword3 );

    -- 设置延迟释放飞行
    timer.performWithDelay( 3000, function( )
        transition.to( sword3, { x = -300, time = 1000, onComplete = function ()
            Runtime:dispatchEvent( { name = "callbackObject", object = sword3 } );
            transition.to( sword2, { x = -300, time = 1000, onComplete = function ()
                Runtime:dispatchEvent({ name = "callbackObject", object = sword2 } );
                transition.to( sword1, { x = -300, time = 1000, onComplete = function ()
                    Runtime:dispatchEvent({ name = "callbackObject", object = sword1 } );
                end } );
            end } );
        end } );
    end );
end

-- 创建飞剑函数
function M.new( )
    local swordOptions =
    {
        width = 154,
        height = 47,
        numFrames = 7,
        sheetContentWidth = 1081,
        sheetContentHeight = 47
    };
    local swordSheet = graphics.newImageSheet( "image/skill/sword.png", swordOptions );
    local swordSprite = { { start = 1, count = 7, time = 600 } };
    local Sword = display.newSprite( swordSheet, swordSprite );
    Sword.x = - 300;
    Sword.y = - 300;
    Sword.finish = false;
    Sword.name = "sword";
    Sword.yAct = true;  -- 是否出于垂直定位状
    Sword.trick = false; -- 是否是大招中的剑
    Sword.width = Sword.contentWidth * 0.9;
    Sword.height = Sword.contentHeight * 0.7;
    Sword.rotation = 180;
    Sword.dynamicSword = dynamicSword
    Sword:play();
    physics.addBody( Sword,  "static", { friction = 0, bounce = 0 } );
    -- 添加碰撞监听
    Sword:addEventListener( "collision", onCollision );
    return Sword;
end

return M;



