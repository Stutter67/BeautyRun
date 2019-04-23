-- 创建 玩家角色
local M = {}


-- 设置 预碰撞监听函数[实现人物能够从平台底下穿过的效果]
local function throughPlatform ( event )
    local platform = event.other;
    if ( "platform" == platform.name ) then
        if event.target.y > platform.actY then
            event.contact.isEnabled = false;   -- 禁用底层触发碰撞
        end
    end
end

-- 改变人物跳跃是重力设置的方法
local function changeGravity( self, number )
    self:setLinearVelocity( 0, 0 );
    if false == self.bigPill then
        self:applyForce( 0, -number, self.x, self.y );
    else
        self:applyForce( 0, -( number * 2.25) , self.x, self.y );
    end
    self:setSequence( "jump" );
end

-- 让人物飞行
local function starFly( self, time )
    self:setLinearVelocity( 0, 0 );
    self:applyForce( 0, 0, self.x, self.y );
    self.gravityScale = 0;
    transition.to( self, { time = 100, rotation = 90, onComplete = function ()
        transition.to( self, { time = time - 200, x = self.x + 50, onComplete = function ()
            transition.to( self, { time = 100, rotation = 360, onComplete = function()
                self.gravityScale = 1;
                self.rotation = 0;
                self:play();
            end } );
        end } );
    end } );
end

-- 修改 人物模型大小的函数
local function changeSize( self, size )
    transition.to( self, { xScale = size, yScale = size, time = 200, onComplete = function()
        physics.removeBody( self );
        local rad = size * ( self.width * 0.5 );
        local height = size * ( self.height * 0.5);
        local physicsShape = { rad, height, -rad, height, -rad, -height, rad,-height };   -- 新的模型大小为原始模型大小的1.5倍
        physics.addBody( self,  "dynamic", { friction = 0, bounce = 0, shape = physicsShape } );
        self.isFixedRotation = true; 	   -- 角色角度修正 开启
        self.isSleepingAllowed = false;  -- 角色休眠     关闭
    end } );
end

-- 使人物旋转
local function revolve( self )
    transition.to( self, { rotation = 360 ,time = 200 ,onComplete = function()
        self.rotation = 0;
    end } );
end

-- 人物受伤的动画
local function hurtSword( self )
    local hitOptions =
    {
        width = 125,
        height = 86,
        numFrames = 3,
        sheetContentWidth = 375,
        sheetContentHeight = 86
    };
    local hitSheet = graphics.newImageSheet( "image/skill/hit.png", hitOptions );
    local hitSprite = { { start = 1, count = 3, time = 1000 } };
    local hit = display.newSprite( self.parent, hitSheet, hitSprite );
    hit.anchorX = 0.5;
    hit.anchorY = 1;
    hit.x = self.x;
    hit.y = self.y + 50;
    hit:play();
    hit:toFront();
    transition.fadeOut( hit , { time = 500, onComplete = function()
        transition.cancel( hit );
        display.remove( hit );
    end } );
end



-- 创建 玩家角色函数
function M.new()
    local playerOptions =
    {
        width = 60,
        height = 75,
        numFrames = 18,
        sheetContentWidth = 365,
        sheetContentHeight = 225
    }
    local playerSheet = graphics.newImageSheet( "image/role/role.png", playerOptions );
    local playerSprite = {
        { name = "run", start = 1, count = 17, time = 1000 },
        { name = "jump", start = 18, count = 1, time = 1000 },
    }
    local player = display.newSprite( playerSheet, playerSprite );
    player.x = 250;                   -- 角色 初始X轴位置
    player.y = screenYHeight * 0.2;   -- 角色 初始Y轴位置
    player.name = "player";           -- 角色名称
    player.invincible = false;        -- 无敌
    player.showShield = showShield;            -- 盾牌
    player.star = false;              -- 冲锋
    player.bigPill = false;           -- 变大
    player.absorption = false;        -- 吸收
    player.singleJump = false;        -- 一段跳
    player.doubleJump = false;        -- 二段跳
    player.thirdJump  = false;        -- 三段跳
    player.changeGravity = changeGravity;  -- 修改人物重力的方法
    player.changeSize = changeSize;        -- 修改人物模型的方法
    player.revolve = revolve;              -- 人物旋转
    player.starFly = starFly;
    player.hurtSword = hurtSword;
    player:play();
    physics.addBody( player,  "dynamic", { friction = 0, bounce = 0 } );
    player.isFixedRotation = true; 	    -- 角色角度修正 开启
    player.isSleepingAllowed = false;   -- 角色休眠    关闭
    player:addEventListener( "preCollision", throughPlatform );    -- 添加预碰撞函数
    return player;
end






return M;