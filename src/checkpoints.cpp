// Copyright (c) 2009-2012 The Bitcoin developers
// Copyright (c) 2017 The Watcoin Project www.whobt.com
// Distributed under the MIT/X11 software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#include <boost/assign/list_of.hpp> // for 'map_list_of()'
#include <boost/foreach.hpp>

#include "checkpoints.h"

#include "txdb.h"
#include "main.h"
#include "uint256.h"


static const int nCheckpointSpan = 500;

namespace Checkpoints
{
    typedef std::map<int, uint256> MapCheckpoints;

    static MapCheckpoints mapCheckpoints =
        boost::assign::map_list_of
        (  0,     uint256("0x00000fa5213552fecc21a2dc47c7b9818ba1dd155f395d4823bee5a08154d08a") )
//        ( 280,    uint256("0x558eef5ec3a5da6a7e4071c7ef0fef5752d62a95d37d72794e0beaa8470521d4") )
//        ( 1000,   uint256("0xdfe49c78f988787426fdab060ecf173241544482500e82940f6cbc9f57020a9f") )
//        ( 2500,   uint256("0xc38a3b9a8b1ff11aed8b6edb846334adb069831f6ea0dae2565528120ee6281a") )
//        ( 5835,   uint256("0x74255be4dd4b54e45ecd4f7a000f1afe95a47d854666fc73f4784e0d87c8e0be") )
//        ( 7853,   uint256("0xae2f2497989ce8c4035f0d02b5b5f4fc9756753a9d43959bf6108e46f375c6db") )
//        ( 10000,  uint256("0x068eedf7395f1215d00d1b698f0a8f4b25cd42650fd00e90a0a4f953d46dcfdb") )
//        ( 12500,   uint256("0x493aa5e660443e95fc879f44b14f23b32a3643f75e52a7df098201653e198f70") )
//        ( 19000,   uint256("0x1465f3dbdf0b64131cbbd074dd13e7bac342079dadf5e34d82061c4174e378a9") )
//        ( 28000,    uint256("0x1b946dc7fca7d55fccd51f9ddea7ef53ed7a4d70de4810d5683ff0226b3bb608") )
//        ( 35000,    uint256("0x90669899561901093e9033a19babc0602b065b85ab776f23a4eb175f1ee0c54a") )
//        ( 40000,    uint256("0x73bcab8526f2626396275ca91d784a0206370b3b3ef595a16d09e4e5e9cbd02f") )
//        ( 58500,    uint256("0xd07a1ad4fac6e3b436820c73cd5314ed657f89e3c9a88a963893220e4985e7ec") )
//        ( 60000,    uint256("0x9a134a25745961423974b32ff006cd0e4119783cecaa568e3ae3fbbdf14f4c52") )
//        ( 65000,    uint256("0x8014a9b524a08b248919a80f561c1a109c820591ea3a15bec260fe33138de4e2") )
//        ( 70000,    uint256("0xdb432aa5a373e06a9b71e750f7132a4a1ba94f67d21b29842e1f054f72c2b2b1") )
//        ( 75000,    uint256("0xb8659a77d9c580ae37eff35ea3a93956f5640e997875b939dc6ec688ab6a0a5e") )
//        ( 80000,    uint256("0x0ad5097c652619901fef733558ca288874deb50688dc49be2f487b3f96cc2cd3") )
//        ( 85000,    uint256("0xff81ff3760cb6280e4298135c5ee02685169240a2c0e3ff55a40625c7b12996f") )

        ;

    // TestNet has no checkpoints
    static MapCheckpoints mapCheckpointsTestnet;

    bool CheckHardened(int nHeight, const uint256& hash)
    {
        MapCheckpoints& checkpoints = (TestNet() ? mapCheckpointsTestnet : mapCheckpoints);

        MapCheckpoints::const_iterator i = checkpoints.find(nHeight);
        if (i == checkpoints.end()) return true;
        return hash == i->second;
    }

    int GetTotalBlocksEstimate()
    {
        MapCheckpoints& checkpoints = (TestNet() ? mapCheckpointsTestnet : mapCheckpoints);

        if (checkpoints.empty())
            return 0;
        return checkpoints.rbegin()->first;
    }

    CBlockIndex* GetLastCheckpoint(const std::map<uint256, CBlockIndex*>& mapBlockIndex)
    {
        MapCheckpoints& checkpoints = (TestNet() ? mapCheckpointsTestnet : mapCheckpoints);

        BOOST_REVERSE_FOREACH(const MapCheckpoints::value_type& i, checkpoints)
        {
            const uint256& hash = i.second;
            std::map<uint256, CBlockIndex*>::const_iterator t = mapBlockIndex.find(hash);
            if (t != mapBlockIndex.end())
                return t->second;
        }
        return NULL;
    }

    // Automatically select a suitable sync-checkpoint 
    const CBlockIndex* AutoSelectSyncCheckpoint()
    {
        const CBlockIndex *pindex = pindexBest;
        // Search backward for a block within max span and maturity window
        while (pindex->pprev && pindex->nHeight + nCheckpointSpan > pindexBest->nHeight)
            pindex = pindex->pprev;
        return pindex;
    }

    // Check against synchronized checkpoint
    bool CheckSync(int nHeight)
    {
        const CBlockIndex* pindexSync = AutoSelectSyncCheckpoint();

        if (nHeight <= pindexSync->nHeight)
            return false;
        return true;
    }
}
