local M = {}
local pool = require( "modules.pool" );
local goldFile = require( "modules.props.gold" );
local redPillFile = require( "modules.props.redPill" );
local bluePillFile = require( "modules.props.bluePill" );
local starFile = require( "modules.props.star" );
local adsorptionFile = require( "modules.props.adsorption" );
local shieldFile = require( "modules.props.shield" );
local bigPillFile = require( "modules.props.bigPill" );
local platformsFile = require( "modules.grounds.platform" );
local swordModule = require( "modules.props.sword" );
local shadowModule = require( "modules.effects.shadow" );
local attackModule = require( "modules.effects.attack" );
local objectPool;

function M.getObjectPool()
    objectPool = pool.initPool();
    objectPool:createPool( goldFile.new , 16, "gold" );
    objectPool:createPool( bluePillFile.new , 8, "bluePill" );
    objectPool:createPool( redPillFile.new , 8, "redPill" );
    objectPool:createPool( adsorptionFile.new , 8, "adsorption" );
    objectPool:createPool( shieldFile.new , 8, "shield" );
    objectPool:createPool( bigPillFile.new , 8, "bigPill" );
    objectPool:createPool( starFile.new , 8, "star" );
    objectPool:createPool( platformsFile.newPlatformComm , 8, "Comm" );
    objectPool:createPool( platformsFile.newPlatformLarge , 8, "Large" );
    objectPool:createPool( platformsFile.newPlatformMed , 8, "Med" );
    objectPool:createPool( platformsFile.newPlatformSmall , 8, "Small" );
    objectPool:createPool( platformsFile.newPlatformTiny , 8, "Tiny" );
    objectPool:createPool( swordModule.new , 8, "sword" );
    objectPool:createPool( shadowModule.new, 10, "shadow" );
    objectPool:createPool( attackModule.newHit, 2, "hit" );
    objectPool:createPool( attackModule.new, 20, "attack" );
    return objectPool;
end

return M;