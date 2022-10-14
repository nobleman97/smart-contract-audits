``` bash
Compilation warnings/errors on /home/david/Documents/Projects/blockchain/audits/contracts/spinToken.sol:
Warning: SPDX license identifier not provided in source file. Before publishing, consider adding a comment containing "SPDX-License-Identifier: <SPDX-License>" to each source file. Use "SPDX-License-Identifier: UNLICENSED" for non-open-source code. Please see https://spdx.org for more information.
--> node_modules/@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol

Warning: SPDX license identifier not provided in source file. Before publishing, consider adding a comment containing "SPDX-License-Identifier: <SPDX-License>" to each source file. Use "SPDX-License-Identifier: UNLICENSED" for non-open-source code. Please see https://spdx.org for more information.
--> node_modules/@uniswap/v2-core/contracts/interfaces/IUniswapV2Pair.sol

Warning: SPDX license identifier not provided in source file. Before publishing, consider adding a comment containing "SPDX-License-Identifier: <SPDX-License>" to each source file. Use "SPDX-License-Identifier: UNLICENSED" for non-open-source code. Please see https://spdx.org for more information.
--> node_modules/@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol

Warning: SPDX license identifier not provided in source file. Before publishing, consider adding a comment containing "SPDX-License-Identifier: <SPDX-License>" to each source file. Use "SPDX-License-Identifier: UNLICENSED" for non-open-source code. Please see https://spdx.org for more information.
--> node_modules/@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router01.sol



SpinToken.swapTokensForTokens(uint256,address) (contracts/spinToken.sol#272-306) sends eth to arbitrary user
        Dangerous calls:
        - (wethsuccess) = uniswapV2Router.WETH().call{value: newEthBalance}() (contracts/spinToken.sol#287)
SpinToken.addLiquidity(uint256,uint256) (contracts/spinToken.sol#308-321) sends eth to arbitrary user
        Dangerous calls:
        - uniswapV2Router.addLiquidityETH{value: ethAmount}(address(this),tokenAmount,0,0,address(this),block.timestamp) (contracts/spinToken.sol#313-320)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#functions-that-send-ether-to-arbitrary-destinations

Reentrancy in SpinToken._transfer(address,address,uint256) (contracts/spinToken.sol#159-212):
        External calls:
        - swapAndSendToMarketing(marketingTokens) (contracts/spinToken.sol#184)
                - uniswapV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(tokenAmount,0,path,address(this),block.timestamp) (contracts/spinToken.sol#262-268)
                - IERC20(MARKETING_TOKEN).transfer(_marketingWalletAddress,marketBalance) (contracts/spinToken.sol#224)
                - IERC20(MARKETING_TOKEN).transfer(_rewardWalletAddress,rewardBalance) (contracts/spinToken.sol#226)
                - (wethsuccess) = uniswapV2Router.WETH().call{value: newEthBalance}() (contracts/spinToken.sol#287)
                - uniswapV2Router.swapExactTokensForTokensSupportingFeeOnTransferTokens(tokenAmount,0,path,address(this),block.timestamp) (contracts/spinToken.sol#298-304)
        - swapAndLiquify(liquidityTokens) (contracts/spinToken.sol#188)
                - uniswapV2Router.addLiquidityETH{value: ethAmount}(address(this),tokenAmount,0,0,address(this),block.timestamp) (contracts/spinToken.sol#313-320)
                - uniswapV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(tokenAmount,0,path,address(this),block.timestamp) (contracts/spinToken.sol#262-268)
        External calls sending eth:
        - swapAndSendToMarketing(marketingTokens) (contracts/spinToken.sol#184)
                - (wethsuccess) = uniswapV2Router.WETH().call{value: newEthBalance}() (contracts/spinToken.sol#287)
        - swapAndLiquify(liquidityTokens) (contracts/spinToken.sol#188)
                - uniswapV2Router.addLiquidityETH{value: ethAmount}(address(this),tokenAmount,0,0,address(this),block.timestamp) (contracts/spinToken.sol#313-320)
        State variables written after the call(s):
        - super._transfer(from,address(this),fees) (contracts/spinToken.sol#208)
                - _balances[from] = fromBalance - amount (node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol#239)
                - _balances[to] += amount (node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol#241)
        - super._transfer(from,to,amount) (contracts/spinToken.sol#211)
                - _balances[from] = fromBalance - amount (node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol#239)
                - _balances[to] += amount (node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol#241)
        - swapping = false (contracts/spinToken.sol#190)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#reentrancy-vulnerabilities

SpinToken.swapAndSendToMarketing(uint256) (contracts/spinToken.sol#215-227) ignores return value by IERC20(MARKETING_TOKEN).transfer(_marketingWalletAddress,marketBalance) (contracts/spinToken.sol#224)
SpinToken.swapAndSendToMarketing(uint256) (contracts/spinToken.sol#215-227) ignores return value by IERC20(MARKETING_TOKEN).transfer(_rewardWalletAddress,rewardBalance) (contracts/spinToken.sol#226)
SpinToken.recoverToken(address,uint256) (contracts/spinToken.sol#324-326) ignores return value by IERC20(_token).transfer(owner(),amount) (contracts/spinToken.sol#325)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#unchecked-transfer

SpinToken.swapAndSendToMarketing(uint256) (contracts/spinToken.sol#215-227) performs a multiplication on the result of a division:
        -marketBalance = (newBalance.div(100).mul(setratio)) (contracts/spinToken.sol#220)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#divide-before-multiply

SpinToken.updateUniswapV2Router(address)._uniswapV2Pair (contracts/spinToken.sol#98) is a local variable never initialized
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#uninitialized-local-variables

SpinToken.updateUniswapV2Router(address) (contracts/spinToken.sol#95-101) ignores return value by IUniswapV2Factory(uniswapV2Router.factory()).createPair(address(this),uniswapV2Router.WETH()) (contracts/spinToken.sol#98-100)
SpinToken.addLiquidity(uint256,uint256) (contracts/spinToken.sol#308-321) ignores return value by uniswapV2Router.addLiquidityETH{value: ethAmount}(address(this),tokenAmount,0,0,address(this),block.timestamp) (contracts/spinToken.sol#313-320)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#unused-return

ERC20Permit.constructor(string).name (node_modules/@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol#44) shadows:
        - ERC20.name() (node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol#62-64) (function)
        - IERC20Metadata.name() (node_modules/@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol#17) (function)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#local-variable-shadowing

SpinToken.setRatioForTransfer(uint256) (contracts/spinToken.sol#103-105) should emit an event for: 
        - setratio = value (contracts/spinToken.sol#104) 
SpinToken.setMarketingFee(uint256,bool) (contracts/spinToken.sol#120-125) should emit an event for: 
        - marketingSellFee = value (contracts/spinToken.sol#122) 
SpinToken.setSwapAtBalance(uint256) (contracts/spinToken.sol#337-339) should emit an event for: 
        - swapTokensAtAmount = newSwapAtAmount (contracts/spinToken.sol#338) 
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#missing-events-arithmetic

SpinToken.updateUniswapV2Pair(address).newAddress (contracts/spinToken.sol#107) lacks a zero-check on :
                - uniswapV2Pair = newAddress (contracts/spinToken.sol#108)
SpinToken.setMarketingWallet(address).wallet (contracts/spinToken.sol#111) lacks a zero-check on :
                - _marketingWalletAddress = wallet (contracts/spinToken.sol#112)
SpinToken.setrewardWallet(address).wallet (contracts/spinToken.sol#115) lacks a zero-check on :
                - _rewardWalletAddress = wallet (contracts/spinToken.sol#116)
SpinToken.recoverBNB(address,uint256).to (contracts/spinToken.sol#329) lacks a zero-check on :
                - to.transfer(amount) (contracts/spinToken.sol#330)
SpinToken.setMarketingToken(address).newToken (contracts/spinToken.sol#333) lacks a zero-check on :
                - MARKETING_TOKEN = newToken (contracts/spinToken.sol#334)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#missing-zero-address-validation

Variable 'SpinToken.updateUniswapV2Router(address)._uniswapV2Pair (contracts/spinToken.sol#98)' in SpinToken.updateUniswapV2Router(address) (contracts/spinToken.sol#95-101) potentially used before declaration: uniswapV2Pair = _uniswapV2Pair (contracts/spinToken.sol#99)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#pre-declaration-usage-of-local-variables

Reentrancy in SpinToken._transfer(address,address,uint256) (contracts/spinToken.sol#159-212):
        External calls:
        - swapAndSendToMarketing(marketingTokens) (contracts/spinToken.sol#184)
                - uniswapV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(tokenAmount,0,path,address(this),block.timestamp) (contracts/spinToken.sol#262-268)
                - IERC20(MARKETING_TOKEN).transfer(_marketingWalletAddress,marketBalance) (contracts/spinToken.sol#224)
                - IERC20(MARKETING_TOKEN).transfer(_rewardWalletAddress,rewardBalance) (contracts/spinToken.sol#226)
                - (wethsuccess) = uniswapV2Router.WETH().call{value: newEthBalance}() (contracts/spinToken.sol#287)
                - uniswapV2Router.swapExactTokensForTokensSupportingFeeOnTransferTokens(tokenAmount,0,path,address(this),block.timestamp) (contracts/spinToken.sol#298-304)
        - swapAndLiquify(liquidityTokens) (contracts/spinToken.sol#188)
                - uniswapV2Router.addLiquidityETH{value: ethAmount}(address(this),tokenAmount,0,0,address(this),block.timestamp) (contracts/spinToken.sol#313-320)
                - uniswapV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(tokenAmount,0,path,address(this),block.timestamp) (contracts/spinToken.sol#262-268)
        External calls sending eth:
        - swapAndSendToMarketing(marketingTokens) (contracts/spinToken.sol#184)
                - (wethsuccess) = uniswapV2Router.WETH().call{value: newEthBalance}() (contracts/spinToken.sol#287)
        - swapAndLiquify(liquidityTokens) (contracts/spinToken.sol#188)
                - uniswapV2Router.addLiquidityETH{value: ethAmount}(address(this),tokenAmount,0,0,address(this),block.timestamp) (contracts/spinToken.sol#313-320)
        State variables written after the call(s):
        - swapAndLiquify(liquidityTokens) (contracts/spinToken.sol#188)
                - _allowances[owner][spender] = amount (node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol#318)
Reentrancy in SpinToken.swapAndLiquify(uint256) (contracts/spinToken.sol#230-250):
        External calls:
        - swapTokensForEth(half) (contracts/spinToken.sol#241)
                - uniswapV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(tokenAmount,0,path,address(this),block.timestamp) (contracts/spinToken.sol#262-268)
        - addLiquidity(otherHalf,newBalance) (contracts/spinToken.sol#247)
                - uniswapV2Router.addLiquidityETH{value: ethAmount}(address(this),tokenAmount,0,0,address(this),block.timestamp) (contracts/spinToken.sol#313-320)
        External calls sending eth:
        - addLiquidity(otherHalf,newBalance) (contracts/spinToken.sol#247)
                - uniswapV2Router.addLiquidityETH{value: ethAmount}(address(this),tokenAmount,0,0,address(this),block.timestamp) (contracts/spinToken.sol#313-320)
        State variables written after the call(s):
        - addLiquidity(otherHalf,newBalance) (contracts/spinToken.sol#247)
                - _allowances[owner][spender] = amount (node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol#318)
Reentrancy in SpinToken.updateUniswapV2Router(address) (contracts/spinToken.sol#95-101):
        External calls:
        - IUniswapV2Factory(uniswapV2Router.factory()).createPair(address(this),uniswapV2Router.WETH()) (contracts/spinToken.sol#98-100)
        State variables written after the call(s):
        - uniswapV2Pair = _uniswapV2Pair (contracts/spinToken.sol#99)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#reentrancy-vulnerabilities-2

Reentrancy in SpinToken._transfer(address,address,uint256) (contracts/spinToken.sol#159-212):
        External calls:
        - swapAndSendToMarketing(marketingTokens) (contracts/spinToken.sol#184)
                - uniswapV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(tokenAmount,0,path,address(this),block.timestamp) (contracts/spinToken.sol#262-268)
                - IERC20(MARKETING_TOKEN).transfer(_marketingWalletAddress,marketBalance) (contracts/spinToken.sol#224)
                - IERC20(MARKETING_TOKEN).transfer(_rewardWalletAddress,rewardBalance) (contracts/spinToken.sol#226)
                - (wethsuccess) = uniswapV2Router.WETH().call{value: newEthBalance}() (contracts/spinToken.sol#287)
                - uniswapV2Router.swapExactTokensForTokensSupportingFeeOnTransferTokens(tokenAmount,0,path,address(this),block.timestamp) (contracts/spinToken.sol#298-304)
        - swapAndLiquify(liquidityTokens) (contracts/spinToken.sol#188)
                - uniswapV2Router.addLiquidityETH{value: ethAmount}(address(this),tokenAmount,0,0,address(this),block.timestamp) (contracts/spinToken.sol#313-320)
                - uniswapV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(tokenAmount,0,path,address(this),block.timestamp) (contracts/spinToken.sol#262-268)
        External calls sending eth:
        - swapAndSendToMarketing(marketingTokens) (contracts/spinToken.sol#184)
                - (wethsuccess) = uniswapV2Router.WETH().call{value: newEthBalance}() (contracts/spinToken.sol#287)
        - swapAndLiquify(liquidityTokens) (contracts/spinToken.sol#188)
                - uniswapV2Router.addLiquidityETH{value: ethAmount}(address(this),tokenAmount,0,0,address(this),block.timestamp) (contracts/spinToken.sol#313-320)
        Event emitted after the call(s):
        - Approval(owner,spender,amount) (node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol#319)
                - swapAndLiquify(liquidityTokens) (contracts/spinToken.sol#188)
        - SwapAndLiquify(half,newBalance,otherHalf) (contracts/spinToken.sol#249)
                - swapAndLiquify(liquidityTokens) (contracts/spinToken.sol#188)
        - Transfer(from,to,amount) (node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol#243)
                - super._transfer(from,to,amount) (contracts/spinToken.sol#211)
        - Transfer(from,to,amount) (node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol#243)
                - super._transfer(from,address(this),fees) (contracts/spinToken.sol#208)
Reentrancy in SpinToken.swapAndLiquify(uint256) (contracts/spinToken.sol#230-250):
        External calls:
        - swapTokensForEth(half) (contracts/spinToken.sol#241)
                - uniswapV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(tokenAmount,0,path,address(this),block.timestamp) (contracts/spinToken.sol#262-268)
        - addLiquidity(otherHalf,newBalance) (contracts/spinToken.sol#247)
                - uniswapV2Router.addLiquidityETH{value: ethAmount}(address(this),tokenAmount,0,0,address(this),block.timestamp) (contracts/spinToken.sol#313-320)
        External calls sending eth:
        - addLiquidity(otherHalf,newBalance) (contracts/spinToken.sol#247)
                - uniswapV2Router.addLiquidityETH{value: ethAmount}(address(this),tokenAmount,0,0,address(this),block.timestamp) (contracts/spinToken.sol#313-320)
        Event emitted after the call(s):
        - Approval(owner,spender,amount) (node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol#319)
                - addLiquidity(otherHalf,newBalance) (contracts/spinToken.sol#247)
        - SwapAndLiquify(half,newBalance,otherHalf) (contracts/spinToken.sol#249)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#reentrancy-vulnerabilities-3

ERC20Permit.permit(address,address,uint256,uint256,uint8,bytes32,bytes32) (node_modules/@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol#49-68) uses timestamp for comparisons
        Dangerous comparisons:
        - require(bool,string)(block.timestamp <= deadline,ERC20Permit: expired deadline) (node_modules/@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol#58)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#block-timestamp

ECDSA.tryRecover(bytes32,bytes) (node_modules/@openzeppelin/contracts/utils/cryptography/ECDSA.sol#57-74) uses assembly
        - INLINE ASM (node_modules/@openzeppelin/contracts/utils/cryptography/ECDSA.sol#65-69)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#assembly-usage

Different versions of Solidity are used:
        - Version used: ['>=0.5.0', '>=0.6.2', '>=0.8.0', '^0.8.0']
        - >=0.8.0 (contracts/spinToken.sol#5)
        - ^0.8.0 (node_modules/@openzeppelin/contracts/access/Ownable.sol#4)
        - ^0.8.0 (node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol#4)
        - ^0.8.0 (node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol#4)
        - ^0.8.0 (node_modules/@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol#4)
        - ^0.8.0 (node_modules/@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol#4)
        - ^0.8.0 (node_modules/@openzeppelin/contracts/token/ERC20/extensions/draft-IERC20Permit.sol#4)
        - ^0.8.0 (node_modules/@openzeppelin/contracts/utils/Context.sol#4)
        - ^0.8.0 (node_modules/@openzeppelin/contracts/utils/Counters.sol#4)
        - ^0.8.0 (node_modules/@openzeppelin/contracts/utils/Strings.sol#4)
        - ^0.8.0 (node_modules/@openzeppelin/contracts/utils/cryptography/ECDSA.sol#4)
        - ^0.8.0 (node_modules/@openzeppelin/contracts/utils/cryptography/draft-EIP712.sol#4)
        - ^0.8.0 (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#4)
        - ^0.8.0 (node_modules/@openzeppelin/contracts/utils/math/SafeMath.sol#4)
        - ^0.8.0 (node_modules/@openzeppelin/contracts/utils/math/SignedSafeMath.sol#4)
        - >=0.5.0 (node_modules/@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol#1)
        - >=0.5.0 (node_modules/@uniswap/v2-core/contracts/interfaces/IUniswapV2Pair.sol#1)
        - >=0.6.2 (node_modules/@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router01.sol#1)
        - >=0.6.2 (node_modules/@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol#1)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#different-pragma-directives-are-used

Context._msgData() (node_modules/@openzeppelin/contracts/utils/Context.sol#21-23) is never used and should be removed
Counters.decrement(Counters.Counter) (node_modules/@openzeppelin/contracts/utils/Counters.sol#32-38) is never used and should be removed
Counters.reset(Counters.Counter) (node_modules/@openzeppelin/contracts/utils/Counters.sol#40-42) is never used and should be removed
ECDSA.recover(bytes32,bytes) (node_modules/@openzeppelin/contracts/utils/cryptography/ECDSA.sol#90-94) is never used and should be removed
ECDSA.recover(bytes32,bytes32,bytes32) (node_modules/@openzeppelin/contracts/utils/cryptography/ECDSA.sol#118-126) is never used and should be removed
ECDSA.toEthSignedMessageHash(bytes) (node_modules/@openzeppelin/contracts/utils/cryptography/ECDSA.sol#202-204) is never used and should be removed
ECDSA.toEthSignedMessageHash(bytes32) (node_modules/@openzeppelin/contracts/utils/cryptography/ECDSA.sol#188-192) is never used and should be removed
ECDSA.tryRecover(bytes32,bytes) (node_modules/@openzeppelin/contracts/utils/cryptography/ECDSA.sol#57-74) is never used and should be removed
ECDSA.tryRecover(bytes32,bytes32,bytes32) (node_modules/@openzeppelin/contracts/utils/cryptography/ECDSA.sol#103-111) is never used and should be removed
ERC20._burn(address,uint256) (node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol#280-295) is never used and should be removed
SafeCast.toInt104(int256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#900-903) is never used and should be removed
SafeCast.toInt112(int256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#882-885) is never used and should be removed
SafeCast.toInt120(int256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#864-867) is never used and should be removed
SafeCast.toInt128(int256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#846-849) is never used and should be removed
SafeCast.toInt136(int256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#828-831) is never used and should be removed
SafeCast.toInt144(int256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#810-813) is never used and should be removed
SafeCast.toInt152(int256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#792-795) is never used and should be removed
SafeCast.toInt16(int256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#1098-1101) is never used and should be removed
SafeCast.toInt160(int256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#774-777) is never used and should be removed
SafeCast.toInt168(int256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#756-759) is never used and should be removed
SafeCast.toInt176(int256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#738-741) is never used and should be removed
SafeCast.toInt184(int256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#720-723) is never used and should be removed
SafeCast.toInt192(int256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#702-705) is never used and should be removed
SafeCast.toInt200(int256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#684-687) is never used and should be removed
SafeCast.toInt208(int256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#666-669) is never used and should be removed
SafeCast.toInt216(int256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#648-651) is never used and should be removed
SafeCast.toInt224(int256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#630-633) is never used and should be removed
SafeCast.toInt232(int256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#612-615) is never used and should be removed
SafeCast.toInt24(int256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#1080-1083) is never used and should be removed
SafeCast.toInt240(int256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#594-597) is never used and should be removed
SafeCast.toInt248(int256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#576-579) is never used and should be removed
SafeCast.toInt256(uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#1130-1134) is never used and should be removed
SafeCast.toInt32(int256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#1062-1065) is never used and should be removed
SafeCast.toInt40(int256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#1044-1047) is never used and should be removed
SafeCast.toInt48(int256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#1026-1029) is never used and should be removed
SafeCast.toInt56(int256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#1008-1011) is never used and should be removed
SafeCast.toInt64(int256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#990-993) is never used and should be removed
SafeCast.toInt72(int256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#972-975) is never used and should be removed
SafeCast.toInt8(int256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#1116-1119) is never used and should be removed
SafeCast.toInt80(int256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#954-957) is never used and should be removed
SafeCast.toInt88(int256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#936-939) is never used and should be removed
SafeCast.toInt96(int256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#918-921) is never used and should be removed
SafeCast.toUint104(uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#340-343) is never used and should be removed
SafeCast.toUint112(uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#323-326) is never used and should be removed
SafeCast.toUint120(uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#306-309) is never used and should be removed
SafeCast.toUint128(uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#289-292) is never used and should be removed
SafeCast.toUint136(uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#272-275) is never used and should be removed
SafeCast.toUint144(uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#255-258) is never used and should be removed
SafeCast.toUint152(uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#238-241) is never used and should be removed
SafeCast.toUint16(uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#527-530) is never used and should be removed
SafeCast.toUint160(uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#221-224) is never used and should be removed
SafeCast.toUint168(uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#204-207) is never used and should be removed
SafeCast.toUint176(uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#187-190) is never used and should be removed
SafeCast.toUint184(uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#170-173) is never used and should be removed
SafeCast.toUint192(uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#153-156) is never used and should be removed
SafeCast.toUint200(uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#136-139) is never used and should be removed
SafeCast.toUint208(uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#119-122) is never used and should be removed
SafeCast.toUint216(uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#102-105) is never used and should be removed
SafeCast.toUint224(uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#85-88) is never used and should be removed
SafeCast.toUint232(uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#68-71) is never used and should be removed
SafeCast.toUint24(uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#510-513) is never used and should be removed
SafeCast.toUint240(uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#51-54) is never used and should be removed
SafeCast.toUint248(uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#34-37) is never used and should be removed
SafeCast.toUint256(int256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#558-561) is never used and should be removed
SafeCast.toUint32(uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#493-496) is never used and should be removed
SafeCast.toUint40(uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#476-479) is never used and should be removed
SafeCast.toUint48(uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#459-462) is never used and should be removed
SafeCast.toUint56(uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#442-445) is never used and should be removed
SafeCast.toUint64(uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#425-428) is never used and should be removed
SafeCast.toUint72(uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#408-411) is never used and should be removed
SafeCast.toUint8(uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#544-547) is never used and should be removed
SafeCast.toUint80(uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#391-394) is never used and should be removed
SafeCast.toUint88(uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#374-377) is never used and should be removed
SafeCast.toUint96(uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#357-360) is never used and should be removed
SafeMath.add(uint256,uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeMath.sol#93-95) is never used and should be removed
SafeMath.div(uint256,uint256,string) (node_modules/@openzeppelin/contracts/utils/math/SafeMath.sol#191-200) is never used and should be removed
SafeMath.mod(uint256,uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeMath.sol#151-153) is never used and should be removed
SafeMath.mod(uint256,uint256,string) (node_modules/@openzeppelin/contracts/utils/math/SafeMath.sol#217-226) is never used and should be removed
SafeMath.sub(uint256,uint256,string) (node_modules/@openzeppelin/contracts/utils/math/SafeMath.sol#168-177) is never used and should be removed
SafeMath.tryAdd(uint256,uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeMath.sol#22-28) is never used and should be removed
SafeMath.tryDiv(uint256,uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeMath.sol#64-69) is never used and should be removed
SafeMath.tryMod(uint256,uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeMath.sol#76-81) is never used and should be removed
SafeMath.tryMul(uint256,uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeMath.sol#47-57) is never used and should be removed
SafeMath.trySub(uint256,uint256) (node_modules/@openzeppelin/contracts/utils/math/SafeMath.sol#35-40) is never used and should be removed
SignedSafeMath.add(int256,int256) (node_modules/@openzeppelin/contracts/utils/math/SignedSafeMath.sol#65-67) is never used and should be removed
SignedSafeMath.div(int256,int256) (node_modules/@openzeppelin/contracts/utils/math/SignedSafeMath.sol#37-39) is never used and should be removed
SignedSafeMath.mul(int256,int256) (node_modules/@openzeppelin/contracts/utils/math/SignedSafeMath.sol#23-25) is never used and should be removed
SignedSafeMath.sub(int256,int256) (node_modules/@openzeppelin/contracts/utils/math/SignedSafeMath.sol#51-53) is never used and should be removed
Strings.toHexString(address) (node_modules/@openzeppelin/contracts/utils/Strings.sol#72-74) is never used and should be removed
Strings.toHexString(uint256) (node_modules/@openzeppelin/contracts/utils/Strings.sol#41-52) is never used and should be removed
Strings.toHexString(uint256,uint256) (node_modules/@openzeppelin/contracts/utils/Strings.sol#57-67) is never used and should be removed
Strings.toString(uint256) (node_modules/@openzeppelin/contracts/utils/Strings.sol#16-36) is never used and should be removed
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#dead-code

SpinToken.totalBuyFees (contracts/spinToken.sol#38) is set pre-construction with a non-constant function or state variable:
        - liquiditySellFee.add(marketingSellFee)
SpinToken.totalSellFees (contracts/spinToken.sol#39) is set pre-construction with a non-constant function or state variable:
        - liquiditySellFee.add(marketingSellFee)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#function-initializing-state

Pragma version>=0.8.0 (contracts/spinToken.sol#5) allows old versions
Pragma version^0.8.0 (node_modules/@openzeppelin/contracts/access/Ownable.sol#4) allows old versions
Pragma version^0.8.0 (node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol#4) allows old versions
Pragma version^0.8.0 (node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol#4) allows old versions
Pragma version^0.8.0 (node_modules/@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol#4) allows old versions
Pragma version^0.8.0 (node_modules/@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol#4) allows old versions
Pragma version^0.8.0 (node_modules/@openzeppelin/contracts/token/ERC20/extensions/draft-IERC20Permit.sol#4) allows old versions
Pragma version^0.8.0 (node_modules/@openzeppelin/contracts/utils/Context.sol#4) allows old versions
Pragma version^0.8.0 (node_modules/@openzeppelin/contracts/utils/Counters.sol#4) allows old versions
Pragma version^0.8.0 (node_modules/@openzeppelin/contracts/utils/Strings.sol#4) allows old versions
Pragma version^0.8.0 (node_modules/@openzeppelin/contracts/utils/cryptography/ECDSA.sol#4) allows old versions
Pragma version^0.8.0 (node_modules/@openzeppelin/contracts/utils/cryptography/draft-EIP712.sol#4) allows old versions
Pragma version^0.8.0 (node_modules/@openzeppelin/contracts/utils/math/SafeCast.sol#4) allows old versions
Pragma version^0.8.0 (node_modules/@openzeppelin/contracts/utils/math/SafeMath.sol#4) allows old versions
Pragma version^0.8.0 (node_modules/@openzeppelin/contracts/utils/math/SignedSafeMath.sol#4) allows old versions
Pragma version>=0.5.0 (node_modules/@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol#1) allows old versions
Pragma version>=0.5.0 (node_modules/@uniswap/v2-core/contracts/interfaces/IUniswapV2Pair.sol#1) allows old versions
Pragma version>=0.6.2 (node_modules/@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router01.sol#1) allows old versions
Pragma version>=0.6.2 (node_modules/@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol#1) allows old versions
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#incorrect-versions-of-solidity

Low level call in SpinToken.swapTokensForTokens(uint256,address) (contracts/spinToken.sol#272-306):
        - (wethsuccess) = uniswapV2Router.WETH().call{value: newEthBalance}() (contracts/spinToken.sol#287)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#low-level-calls

Parameter SpinToken.excludeFromPaused(address,bool)._address (contracts/spinToken.sol#155) is not in mixedCase
Parameter SpinToken.recoverToken(address,uint256)._token (contracts/spinToken.sol#324) is not in mixedCase
Variable SpinToken._deadWalletAddress (contracts/spinToken.sol#26) is not in mixedCase
Variable SpinToken._marketingWalletAddress (contracts/spinToken.sol#27) is not in mixedCase
Variable SpinToken._rewardWalletAddress (contracts/spinToken.sol#28) is not in mixedCase
Variable SpinToken.MARKETING_TOKEN (contracts/spinToken.sol#29) is not in mixedCase
Variable SpinToken._isBlacklisted (contracts/spinToken.sol#32) is not in mixedCase
Function ERC20Permit.DOMAIN_SEPARATOR() (node_modules/@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol#81-83) is not in mixedCase
Variable ERC20Permit._PERMIT_TYPEHASH_DEPRECATED_SLOT (node_modules/@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol#37) is not in mixedCase
Function IERC20Permit.DOMAIN_SEPARATOR() (node_modules/@openzeppelin/contracts/token/ERC20/extensions/draft-IERC20Permit.sol#59) is not in mixedCase
Variable EIP712._CACHED_DOMAIN_SEPARATOR (node_modules/@openzeppelin/contracts/utils/cryptography/draft-EIP712.sol#31) is not in mixedCase
Variable EIP712._CACHED_CHAIN_ID (node_modules/@openzeppelin/contracts/utils/cryptography/draft-EIP712.sol#32) is not in mixedCase
Variable EIP712._CACHED_THIS (node_modules/@openzeppelin/contracts/utils/cryptography/draft-EIP712.sol#33) is not in mixedCase
Variable EIP712._HASHED_NAME (node_modules/@openzeppelin/contracts/utils/cryptography/draft-EIP712.sol#35) is not in mixedCase
Variable EIP712._HASHED_VERSION (node_modules/@openzeppelin/contracts/utils/cryptography/draft-EIP712.sol#36) is not in mixedCase
Variable EIP712._TYPE_HASH (node_modules/@openzeppelin/contracts/utils/cryptography/draft-EIP712.sol#37) is not in mixedCase
Function IUniswapV2Pair.DOMAIN_SEPARATOR() (node_modules/@uniswap/v2-core/contracts/interfaces/IUniswapV2Pair.sol#18) is not in mixedCase
Function IUniswapV2Pair.PERMIT_TYPEHASH() (node_modules/@uniswap/v2-core/contracts/interfaces/IUniswapV2Pair.sol#19) is not in mixedCase
Function IUniswapV2Pair.MINIMUM_LIQUIDITY() (node_modules/@uniswap/v2-core/contracts/interfaces/IUniswapV2Pair.sol#36) is not in mixedCase
Function IUniswapV2Router01.WETH() (node_modules/@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router01.sol#5) is not in mixedCase
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#conformance-to-solidity-naming-conventions

Variable SpinToken.MARKETING_TOKEN (contracts/spinToken.sol#29) is too similar to SpinToken._transfer(address,address,uint256).marketingTokens (contracts/spinToken.sol#182)
Variable IUniswapV2Router01.addLiquidity(address,address,uint256,uint256,uint256,uint256,address,uint256).amountADesired (node_modules/@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router01.sol#10) is too similar to IUniswapV2Router01.addLiquidity(address,address,uint256,uint256,uint256,uint256,address,uint256).amountBDesired (node_modules/@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router01.sol#11)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#variable-names-are-too-similar

SpinToken.slitherConstructorVariables() (contracts/spinToken.sol#17-341) uses literals with too many digits:
        - _deadWalletAddress = address(0x000000000000000000000000000000000000dEaD) (contracts/spinToken.sol#26)
SpinToken.slitherConstructorVariables() (contracts/spinToken.sol#17-341) uses literals with too many digits:
        - swapTokensAtAmount = 5000000 * (10 ** 18) (contracts/spinToken.sol#30)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#too-many-digits

ERC20Permit._PERMIT_TYPEHASH_DEPRECATED_SLOT (node_modules/@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol#37) is never used in SpinToken (contracts/spinToken.sol#17-341)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#unused-state-variable

ERC20Permit._PERMIT_TYPEHASH_DEPRECATED_SLOT (node_modules/@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol#37) should be constant
SpinToken._deadWalletAddress (contracts/spinToken.sol#26) should be constant
SpinToken.liquiditySellFee (contracts/spinToken.sol#35) should be constant
SpinToken.nah (contracts/spinToken.sol#44) should be constant
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#state-variables-that-could-be-declared-constant

blacklistAddress(address,bool) should be declared external:
        - SpinToken.blacklistAddress(address,bool) (contracts/spinToken.sol#139-141)
renounceOwnership() should be declared external:
        - Ownable.renounceOwnership() (node_modules/@openzeppelin/contracts/access/Ownable.sol#61-63)
transferOwnership(address) should be declared external:
        - Ownable.transferOwnership(address) (node_modules/@openzeppelin/contracts/access/Ownable.sol#69-72)
name() should be declared external:
        - ERC20.name() (node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol#62-64)
symbol() should be declared external:
        - ERC20.symbol() (node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol#70-72)
decimals() should be declared external:
        - ERC20.decimals() (node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol#87-89)
totalSupply() should be declared external:
        - ERC20.totalSupply() (node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol#94-96)
transfer(address,uint256) should be declared external:
        - ERC20.transfer(address,uint256) (node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol#113-117)
approve(address,uint256) should be declared external:
        - ERC20.approve(address,uint256) (node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol#136-140)
transferFrom(address,address,uint256) should be declared external:
        - ERC20.transferFrom(address,address,uint256) (node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol#158-167)
increaseAllowance(address,uint256) should be declared external:
        - ERC20.increaseAllowance(address,uint256) (node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol#181-185)
decreaseAllowance(address,uint256) should be declared external:
        - ERC20.decreaseAllowance(address,uint256) (node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol#201-210)
permit(address,address,uint256,uint256,uint8,bytes32,bytes32) should be declared external:
        - ERC20Permit.permit(address,address,uint256,uint256,uint8,bytes32,bytes32) (node_modules/@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol#49-68)
nonces(address) should be declared external:
        - ERC20Permit.nonces(address) (node_modules/@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol#73-75)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#public-function-that-could-be-declared-external
/home/david/Documents/Projects/blockchain/audits/contracts/spinToken.sol analyzed (19 contracts with 78 detectors), 185 result(s) found
```