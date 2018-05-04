#!/bin/bash
# Useage:
#    COIN_CONFIG_DIR=/absolute/path/to/model/altcoin sh bash/makecoin.sh
#
echo  " "
echo  "Make sure you make coin!"
echo  " "
read -e -p "Enter coin name  (e.g. wattcoin) : " COIN_NAME
DIR=`pwd`
COIN_CONFIG_FILE=$DIR/model/$COIN_NAME/coin.cfg
echo $COIN_CONFIG_FILE;
if  [ -n "$DIR" -a -d "$DIR" -a -f "$COIN_CONFIG_FILE" ] ; then 
	echo Loading configuration from "$COIN_CONFIG_DIR"
else 
	echo $COIN_CONFIG_DIR is not valid directory; 
	exit -2; 
fi


function getValue(){
	value=$(grep "$1=.*" "$COIN_CONFIG_FILE" | sed -e "s/.*=\(.*\)/\1/g" ) 
	echo -n $value;
}

echo Step 0: loading configuration variables
	AnyCoin=$(getValue "name") ; 
	AnyCoin_Lower=$(getValue "name_lower");
	AnyCoin_zh_CN=$(getValue "name_zh_CN"); 
	AnyCoinUint=$(getValue "unit");
	AnyCoinUintUpper=$(getValue "unit_upper");
echo Step 1: replace images
	cp -rf $COIN_CONFIG_DIR/src ./
	cp -rf $COIN_CONFIG_DIR/share ./
echo Step 2: replace locale text
	sed -i -e "s/Watcoin/$AnyCoin/g" src/qt/locale/bitcoin_en.ts
	sed -i -e "s/Watcoin/$AnyCoin/g" src/qt/guiconstants.h
	sed -i -e "s/Watcoin/$AnyCoin/g" src/qt/res/bitcoin-qt.rc
	sed -i -e "s/黑币/$AnyCoin_zh_CN/g" src/qt/locale/bitcoin_zh_CN.ts
	sed -i -e "s/黑幣/$AnyCoin_zh_CN/g" src/qt/locale/bitcoin_zh_TW.ts
	sed -i -e "s/Watcoin/$AnyCoin/g" src/qt/locale/bitcoin_zh_TW.ts
	sed -i -e "s/Watcoin/$AnyCoin/g" src/qt/locale/bitcoin_vi_VN.ts
	sed -i -e "s/Watcoin/$AnyCoin/g" src/qt/locale/bitcoin_vi.ts
	sed -i -e "s/Watcoin/$AnyCoin/g" src/qt/locale/bitcoin_uk.ts
	sed -i -e "s/Watcoin/$AnyCoin/g" src/qt/locale/bitcoin_ur_PK.ts
	sed -i -e "s/Watcoin/$AnyCoin/g" src/qt/locale/bitcoin_tr.ts
	sed -i -e "s/Watcoin/$AnyCoin/g" src/qt/locale/bitcoin_th_TH.ts
	sed -i -e "s/Watcoin/$AnyCoin/g" src/qt/locale/bitcoin_sv.ts
	sed -i -e "s/Watcoin/$AnyCoin/g" src/qt/locale/bitcoin_sr.ts
	sed -i -e "s/Watcoin/$AnyCoin/g" src/qt/locale/


	sed -i -e "s/Watcoin/$AnyCoin/g" src/qt/askpassphrasedialog.cpp
	sed -i -e "s/Watcoin/$AnyCoin/g" src/qt/bitcoin.cpp
	sed -i -e "s/Watcoin/$AnyCoin/g" src/qt/bitcoinunits.cpp
	sed -i -e "s/Watcoin/$AnyCoin/g" src/qt/bitcoingui.cpp
	sed -i -e "s/Watcoin/$AnyCoin/g" src/qt/bitcoinstrings.cpp
	sed -i -e "s/Watcoin/$AnyCoin/g" src/qt/editaddressdialog.cpp
	sed -i -e "s/Watcoin/$AnyCoin/g" src/qt/forms/aboutdialog.ui
	sed -i -e "s/Watcoin/$AnyCoin/g" src/qt/forms/addressbookpage.ui
	sed -i -e "s/Watcoin/$AnyCoin/g" src/qt/forms/optionsdialog.ui
	sed -i -e "s/Watcoin/$AnyCoin/g" src/qt/optionsdialog.cpp
	sed -i -e "s/Watcoin/$AnyCoinUintUpper/g" src/qt/paymentserver.cpp
	sed -i -e "s/Watcoin/$AnyCoinUint/g" src/qt/rpcconsole.cpp
	sed -i -e "s/Watcoin/$AnyCoinUint/g" src/qt/sendcoinsdialog.cpp
	sed -i -e "s/Watcoin/$AnyCoinUint/g" src/qt/sendcoinsentry.cpp
	sed -i -e "s/Watcoin/$AnyCoinUint/g" src/qt/signverifymessagedialog.cpp
	sed -i -e "s/LMN/$AnyCoinUintUpper/g" src/qt/bitcoinunits.cpp
	sed -i -e "s/LMN/$AnyCoinUintUpper/g" src/qt/guiutil.cpp
	sed -i -e "s/lmn/$AnyCoinUintUpper/g" src/qt/bitcoinunits.cpp


	sed -i -e "s/Watcoin/$AnyCoin/g" src/util.cpp
	sed -i -e "s/Watcoin/$AnyCoin/g" src/init.cpp
	sed -i -e "s/Watcoin/$AnyCoin/g" src/kernel.cpp
	sed -i -e "s/Watcoin/$AnyCoin/g" src/main.cpp
	sed -i -e "s/Watcoin/$AnyCoin/g" src/miner.cpp
	sed -i -e "s/Watcoin/$AnyCoin/g" src/net.cpp
	sed -i -e "s/Watcoin/$AnyCoin/g" src/rpcdump.cpp
	sed -i -e "s/Watcoin/$AnyCoin/g" src/rpcmining.cpp
	sed -i -e "s/Watcoin/$AnyCoin/g" src/rpcmisc.cpp
	sed -i -e "s/Watcoin/$AnyCoin/g" src/rpcnet.cpp
	sed -i -e "s/Watcoin/$AnyCoin/g" src/rpcprotocol.cpp
	sed -i -e "s/Watcoin/$AnyCoin/g" src/rpcrawtransaction.cpp
	sed -i -e "s/Watcoin/$AnyCoin/g" src/rpcserver.cpp
	sed -i -e "s/Watcoin/$AnyCoin/g" src/rpcwallet.cpp
	sed -i -e "s/Watcoin/$AnyCoin/g" src/timedata.cpp
	sed -i -e "s/Watcoin/$AnyCoin/g" src/version.cpp
	
	sed -i -e "s/lemanum/$AnyCoin_Lower/g" src/util.cpp
	sed -i -e "s/lemanum/$AnyCoin_Lower/g" src/init.cpp
	sed -i -e "s/lemanum/$AnyCoin_Lower/g" src/miner.cpp
	sed -i -e "s/lemanum/$AnyCoin_Lower/g" src/rpcdump.cpp
	sed -i -e "s/lemanum/$AnyCoin_Lower/g" src/rpcmining.cpp
	sed -i -e "s/lemanum/$AnyCoin_Lower/g" src/rpcmisc.cpp
	sed -i -e "s/lemanum/$AnyCoin_Lower/g" src/rpcnet.cpp
	sed -i -e "s/lemanum/$AnyCoin_Lower/g" src/rpcprotocol.cpp
	sed -i -e "s/lemanum/$AnyCoin_Lower/g" src/rpcrawtransaction.cpp
	sed -i -e "s/lemanum/$AnyCoin_Lower/g" src/rpcserver.cpp
	sed -i -e "s/lemanum/$AnyCoin_Lower/g" src/rpcwallet.cpp
	find . -type f -print0 | xargs -0 sed -i 's/Lemanum/Watcoin/g'
	find . -type f -print0 | xargs -0 sed -i 's/LMN/WTC/g'
	find . -type f -print0 | xargs -0 sed -i 's/lmn/wtc/g'
