-- 创建场景
local composer = require( "composer" );
local scene = composer.newScene();


-- 参数声明
-- 全局变量声明：常用的函数参数全局变量声明
screenXWidth = display.contentWidth;
screenXCenter = screenXWidth * 0.5;
screenYHeight = display.contentHeight;
screenYCenter = screenYHeight * 0.5;   -- 屏幕参数
mR = math.random;
mF = math.floor;                       -- 常用函数

-- 本地变量声明
-- modules模块的引入声明
local backgroundModule, fireModule, createSectionModule;        -- 场景模块[背景模块, 地板模块, 场景创建模块]
local buttonModule, attackModule, swordModule;                  -- 攻击模块[己方攻击按钮模块,已方攻击模块, 对方攻击模块]
local shieldModule, shadowModule;                               -- 效果模块[盾牌效果模块, 光影效果模块]
local playRoleModule, hudBarModule, bossModule;                 -- 角色模块[玩家角色, 玩家面板信息, boss角色 ]

-- game本地参数声明
local distance, distChange, distChange2, levelSpeed, lvlChange = 0, 0, 0, 5, 0 ;                      -- 速度数值 [距离, 距离变化, 距离变化2, 速度等级, 速度增量]  这行参数主要用于画面速度的控制和调整
local distanceText, goldText, bloodText, magicText, bloodStrip, magicStrip,  magicTemp, bloodTemp;    -- HudBar的面板数据[ 距离文本, 金币文本, 血量文本, 法力文本, 血量条, 法力条, 血量上限, 法力上限 ]  这行参数主要用于角色HudBar面板数据的修改和展示
local sword, sword1, sword2, sword3;                            -- 攻击模块对应的变量[敌方：普通攻击, 大招攻击1, 大招攻击2, 大招攻击3, 攻击对象池 ,攻击伤害效果 己方：攻击对象池
local background, fireGround1, fireGround2,objectPool;                                                           -- 后台模块对应的对象
local player, boss, bossBloodText = nil, nil, 10000;                                                  -- 角色模块对应的对象[己方角色 敌方角色 敌方血量文本 ]
local gameIsActive, bossLive = false, false;                                                          -- 游戏状态的控制参数
local objectGroup, extraGroup;                                                                        -- 画面显示对象容器
-- game本地函数声明
local touchPlayerJump, createGame, createSection, createText;                                                    -- 预先声明的本地函数名 [游戏循环, 跳跃监听, 初始化场景, 场景创建, 伤害文本显示, 金币数量修改， 游戏结束 ]
local gameLoop, resetSword, callbackObject, changeJump, changePlayerStatus, changeMagic, changeSword, changeBlood, changeGold , createAttack, gameOver;   --[画面循环函数, 重置剑， 角色跳跃状态监听  人物属性监听， 法力值监听 血量监听 金币监听 攻击动画监听  游戏结束监听]


-- Todo 以下代码控制整个游戏程序。
-- 创建 physics 函数
physics = require( "physics" );
physics.start();
physics.setGravity( 0, 20 );
physics.setDrawMode( "hybrid" );  --Todo 设置物理模型遮罩(仅在模拟器调试时使用,完成后正式发布之前时应当将其注释)

-- 实现人物跳跃(全局监听函数)
function touchPlayerJump( event )
	if "ended" == event.phase and  false == player.star then -- 如果不处于飞行状态则进行跳跃控制  通过点击屏幕进行跳跃
		if false == player.singleJump then
			player:changeGravity( 10 );
		end
		if false == player.doubleJump then
			player:changeGravity( 10 );
		end
		if false == player.thirdJump then
			player:changeGravity( 10 );
		end
		-- 判断跳跃的次数
		if  false == player.singleJump then
			player.singleJump = true;
		elseif false == player.doubleJump then
			player.doubleJump = true;
			player:revolve();
		else
			player.thirdJump = true;
			player:revolve();
		end
		-- 如果处于飞行状态则控制飞行  通过长按触摸进行移动
	elseif "moved" == event.phase and true == player.star then
		timer.performWithDelay( 40 ,function ( )
			player.y = event.y;
		end )
	end
end

-- 创建游戏场景
function createGame()
	-- 删除回收上一个场景的显示对象
	for i = objectGroup.numChildren, 1, -1 do
		local object = objectGroup[ i ];
		if object then
			objectPool:putObject( object );
		end
	end

	-- 清空额外的对象
	for i = extraGroup.numChildren, 1, -1 do
		local object = extraGroup[ i ];
		if object then
			display.remove( object );
			object = nil;
		end
	end
	if player then
		display.remove( player );
		player = nil;
	end
	if fireGround1 then
		display.remove( fireGround1 );
		fireGround1 = nil;
	end
	if fireGround2 then
		display.remove( fireGround2 );
		fireGround2 = nil;
	end

	-- 重新刷新加载模块
	-- 背景模块
	backgroundModule = require( "modules.grounds.background" );
	fireModule = require( "modules.grounds.fire" );
	fireGround1, fireGround2 = fireModule.new( extraGroup );

	-- 玩家角色
  playRoleModule = require("modules.roles.playRole");
	player = playRoleModule.new();
	extraGroup:insert( player );

	-- 创建场景
	createSectionModule.createSection( objectGroup );
end




-- 重置飞剑状态
function resetSword()
	local sword = objectPool:getObject( "sword" );
	sword.x = screenXWidth - sword.contentWidth * 0.5;
	sword.finish = false;
	sword.trick = false;
	sword.y = screenYCenter;
	sword.alpha = 1;
	sword.yAct = true;
	physics.addBody( sword,  "static", { friction = 0, bounce = 0 } );
	extraGroup:insert( sword );
	return sword;
end

-- 循环游戏播放的监听器
function gameLoop( event )
	if gameIsActive == true then
		-- 设置变速
		if player.x < screenXWidth * 0.2 then
			physics.setGravity( 0.3 ,20 );
		elseif  player.x > screenXWidth * 0.2 and player.x < screenXWidth * 0.6 and player.star == false  then
			physics.setGravity( 0, 20 );
		elseif player.x > screenXWidth * 0.6 then
			physics.setGravity( -0.3 ,20 );
		end

		-- 动态增加距离
		distance = distance + 1;
		distanceText.text = mF( distance  + ( levelSpeed * 0.6 ) );

		-- 每帧监听血量和法力值的变化
		if ( tonumber( bloodText.text ) ) < 0 then
			bloodText.text = 0;
		end
		bloodStrip.width = bloodTemp * bloodText.text * 0.002;
		if ( tonumber( magicText.text ) < 0 ) then
			magicText.text = 0;
		end
		magicStrip.width = magicTemp * magicText.text * 0.01;

		-- 显示宝剑
		if tonumber( distanceText.text ) == 150 then
			sword = resetSword();
			extraGroup:insert( sword );
		end
		-- 宝剑攻击判定
		if sword then
			sword:dynamicSword( distanceText, player )
			if sword.finish == true then
				 --如果处于boss释放大招阶段,则延迟重置动画
				if distanceText.text % 1100 == 0 then
					timer.performWithDelay( 6000, function ( event )
						sword = resetSword();
					end  );
				else
					sword = resetSword();
				end
			end
		end
	end

		-- 显示boss
		if tonumber( distanceText.text ) == 1000 then
			boss = bossModule.showBoss( extraGroup );
			bossBloodText = bossModule.showBossInfo( extraGroup );
			bossLive = true;
		end

		-- 设置boss技能动画
		if tonumber( mF(distanceText.text % 1100 ) ) == 0  then
			boss.show = true;
			-- 显示招数名称
			transition.fadeOut( display.newImage( extraGroup, "image/skill/swordEffect.png", boss.x -200 , boss.y - 100 ) ,{ time = 2000 } );
			boss:setSequence( "trick" );
			boss:play();
			swordModule.triSword( resetSword, player.y, extraGroup );
			timer.performWithDelay( 7000 , function()
				boss:setSequence( "comm" );
				boss:play();
			end)
		end;


		-- 移动平台道具,并回收超过内容区域的资源
		for i = objectGroup.numChildren, 1, -1 do
			local object = objectGroup[ i ];
			if object ~= nil and object.y ~= nil and object.name ~= nil then
				object:translate( -levelSpeed, 0 );
				if object.name == "gold" and  player.absorption == true  then
					object:moveGold( player )
				end
				if object.x <= -300 then
					objectPool:putObject( object );
				end
			end
		end

		-- 移动背景图片
		backgroundModule.updateMedBackground( levelSpeed );
		fireModule.updateFireFloor( levelSpeed, fireGround1, fireGround2 );

		-- 设置人物的光影
		shadowModule.updateShadow( player,objectPool, extraGroup );

		-- 判断任务是否超出的范围,如果超过则执行游戏结束函数
	if( tonumber( bloodText.text ) <=  0 or player.x < - 5 )then
		gameIsActive = false;
		gameOver();
	end

		-- 设置随着距离需要到动态修改的内容
		distChange = distChange + 1;
		-- 每300距离恢复5点法力值
		if distChange >= 300 and levelSpeed < 10 then
			if tonumber( magicText.text ) < 100 then
				magicText.text = magicText.text + 5;
			end
			lvlChange = 0.02;
			if distance >= 4000 then
				lvlChange = 0.005;
			end
			distChange = 0;
			levelSpeed = levelSpeed + lvlChange;
		end

		-- 每隔一段距离创建新的平台场景
		distChange2 = distChange2 + levelSpeed;
		if distChange2 >= 1600 then
			distChange2 = 0;
			createSectionModule.createSection( objectGroup ); -- 创建场景函数
		end
	end


-- 触发攻击的监听器
function createAttack( event )
	if "attack"  == event.target then
		if tonumber( magicText.text ) > 0 then
			local att = objectPool:getObject("attack");
			att.alpha = 1;
			physics.addBody( att,  "static", { friction = 0, bounce = 0 } );
			att.x = player.x + 150;
			att.y = player.y - 15;
			extraGroup:insert( att );
			transition.to( att , { x = screenXWidth * 0.85, y = screenYHeight * 0.4, time = 2000, onComplete = function ()
				objectPool:putObject( att );
				if true == bossLive and true == boss.show then
					boss:showHit( objectPool );
					local hurt = mR(50 ,150);
					hudBarModule.createText( "-"..hurt, boss.x ,boss.y - 40 );
					bossBloodText.text = bossBloodText.text - hurt;
				end
			end } )
			Runtime:dispatchEvent( { name = "changeMagic" , target = "attack" ,magic = -5 } );
		else
			hudBarModule.createText( "法力值不足" ,screenXCenter , screenYCenter );
		end
	end
end

-- 修改金币的监听器
function changeGold( event )
	if  "gold"  == event.target then
		if event.Score then
			goldText.text = goldText.text + event.Score;
		end
	end
end



-- 判断是否重置飞剑的监听器
function changeSword( event )
	if "sword" == event.target then
		player:hurtSword();
		sword = event.object;
		if boss and sword.trick == false then
			timer.performWithDelay( 1 , function()
				sword = resetSword();
				extraGroup:insert( sword );
			end )
		end
	end
end

-- 修改血量的监听器
function changeBlood( event )
	if "sword"  == event.target or "fire"  == event.target then
		if false == player.invincible then
			bloodText.text = bloodText.text - event.Hurt;
			hudBarModule.createText( "- "..event.Hurt, player.x, player.y );
		end
	elseif "redPill"  == event.target then
		if tonumber( bloodText.text ) < 400 then
			bloodText.text = bloodText.text + event.Blood;
		else
			bloodText.text = 500;
		end
	end
end

-- 修改法力值的监听器
function changeMagic( event )
	if "bluePill" == event.target then
		if tonumber( magicText.text ) < 50 then
			magicText.text = magicText.text + event.magic;
		else
			magicText.text = 100;
		end
	elseif "attack" == event.target then
		magicText.text = magicText.text + event.magic;
	end
end

-- 修改角色状态的监听器（统一监听四个内容）
function changePlayerStatus( event )
	if "star" == event.target then
		player.star = true;
		player.invincible = true;
		levelSpeed = 10;
        player:starFly(  event.time  );
        timer.performWithDelay( event.time + 1,function()
            levelSpeed = 6;
            player.star = false;
            player.invincible = false;
        end );
	elseif "adsorption" == event.target then
		player.absorption = true;
		timer.performWithDelay( event.time ,function()
			player.absorption = false;
		end );
	elseif "shield" == event.target then
		player.invincible = true;
		shieldModule.showShield( player , objectPool );
	elseif "bigPill" == event.target then
		player.invincible = true;
		player.bigPill = true;
		player:changeSize(  1.5 );
		timer.performWithDelay( 6000, function()
			player.invincible = false;
			player.bigPill = false;
			player:changeSize( 1 );
		end )
	end
end

-- 修改跳跃状态
function  changeJump( event )
	if "fire" == event.target or "platform"  == event.target or "star"  == event.target then
		player.singleJump, player.doubleJump, player.thirdJump = false, false, false;
		player:setSequence( "run" );
		player:play();
	end
end


-- 回收对象
function callbackObject( event )
	print(event.object.name)
	objectPool:putObject( event.object );
end


-- 结束游戏函数
function gameOver()
	display.newImage( "image/other/gameOver.jpg" ,screenXCenter , screenYCenter );
	physics:pause();   -- 暂停物理引擎
	player:pause();    -- 暂停动画播放
    -- 停止函数监听
	Runtime:removeEventListener( "enterFrame",gameLoop );
	Runtime:removeEventListener( "touch", touchPlayerJump );
	Runtime:removeEventListener( "changeJump", changeJump );
	Runtime:removeEventListener( "changeGold", changeGold );
	Runtime:removeEventListener( "changeBlood", changeBlood );
	Runtime:removeEventListener( "changeMagic", changeMagic );
	Runtime:removeEventListener( "changeSword", changeSword );
	Runtime:removeEventListener( "createAttack", createAttack );
	Runtime:removeEventListener( "changePlayerStatus", changePlayerStatus );
end


-- 以下开始进入场景
-----------------------------------------------
----------- *** scene:create  *** -------------
----------  创建需要显示资源对象  ---------------
-----------------------------------------------
function scene:create( event )
    local sceneGroup = self.view;
	-- 显示群组
  objectGroup = display.newGroup();   -- 静态群组
  extraGroup = display.newGroup();    -- 动态群组
  sceneGroup:insert( objectGroup );
  sceneGroup:insert( extraGroup );

	-- 角色相关信息栏
	hudBarModule = require( "modules.roles.hudBar" );      -- 读取hud面板静态数据[包括静态图片资源(头像,框,图标)和动态资源(金币,距离,血量,法力)]
	distanceText = hudBarModule.showDistanceText();
	goldText = hudBarModule.showGoldText();
	bloodStrip = hudBarModule.showBloodStrip();
	magicStrip = hudBarModule.showMagicStrip();
	magicTemp = magicStrip.contentWidth;
	bloodText = hudBarModule.showBloodText();
	magicText = hudBarModule.showMagicText();
	bloodTemp = bloodStrip.contentWidth;

	-- 获取对象池
	local objectPools = require( "modules.ObjectPool" )
	objectPool = objectPools.getObjectPool();

	-- 创建游戏必须的模块
	createSectionModule = require( "modules.section.createSection" );   -- 场景模块



	buttonModule = require("modules.effects.button");     -- 调用我方攻击函数
	buttonModule.new();

	swordModule = require("modules.props.sword");         -- 创建敌方攻击函数

	bossModule = require("modules.roles.bossRole");       -- bossm模块

	attackModule = require( "modules.effects.attack" );   -- 攻击模块

	shieldModule = require( "modules.props.shield" );     -- 盾牌模块

	shadowModule = require( "modules.effects.shadow" );   -- 引入人物光影

    -- 创建初始游戏创景
	createGame();
end


-----------------------------------------------
------------ *** scene:show  *** --------------
---------------启动定时器,监听器等---------------
-----------------------------------------------
function scene:show( event )
	composer.removeHidden( false );
	if ( "did" == event.phase ) then
    gameIsActive = true;   -- 激活游戏状态
    -- 监听游戏函数
    Runtime:addEventListener( "enterFrame",gameLoop );
    Runtime:addEventListener( "touch", touchPlayerJump );
    Runtime:addEventListener( "callbackObject", callbackObject );
    Runtime:addEventListener( "changeJump", changeJump );
    Runtime:addEventListener( "changeGold", changeGold );
    Runtime:addEventListener( "changeBlood", changeBlood );
    Runtime:addEventListener( "changeSword", changeSword );
    Runtime:addEventListener( "changeMagic", changeMagic );
    Runtime:addEventListener( "createAttack", createAttack );
    Runtime:addEventListener( "changePlayerStatus", changePlayerStatus );
	end
end


	-----------------------------------------------
	------------ *** scene:hide  *** --------------
	---------------取消定时器,监听器等---------------
	-----------------------------------------------
	function scene:hide( event )
		gameIsActive = false;        -- 停止游戏的运行
		objectPool:clearPool();      -- 移除所有池对象
		-- 移除监听函数
		Runtime:removeEventListener( "enterFrame",gameLoop );
		Runtime:removeEventListener( "touch", touchPlayerJump );
		Runtime:removeEventListener( "changeJump", changeJump );
		Runtime:removeEventListener( "changeGold", changeGold );
		Runtime:removeEventListener( "changeBlood", changeBlood );
		Runtime:removeEventListener( "changeMagic", changeMagic );
		Runtime:removeEventListener( "changeSword", changeSword );
		Runtime:removeEventListener( "createAttack", createAttack );
		Runtime:removeEventListener( "changePlayerStatus", changePlayerStatus );
	end


	-----------------------------------------------
	-------------    scene:destroy    -------------
	-----------------------------------------------
	function scene:destroy( event )  end


	-- 添加场景监听器
	scene:addEventListener( "create", scene );
	scene:addEventListener( "show", scene );
	scene:addEventListener( "hide", scene );
	scene:addEventListener( "destroy", scene );


	-- 返回scene
	return scene;

